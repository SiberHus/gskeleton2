package com.siberhus.gskeleton.web;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;

import org.apache.commons.lang.StringEscapeUtils;

import com.siberhus.gskeleton.util.ReflectionUtils;
import com.siberhus.gskeleton.config.SysConfig
import java.text.ParseException;

/**
 * 
 */
class CrudHelper {

	public static def getMaxListSize(def params){
		def max = params.max
		if(max){
			if(!(max instanceof String)) max = max[0]
			return Math.min(max.toInteger(),SysConfig.get('crud.list.maxSize'))
		}
		return Math.min(SysConfig.get('crud.list.defaultSize'),  SysConfig.get('crud.list.maxSize'))
	}

	public static def getResultOffset(def params){
		def offset = params.offset
		if(offset){
			if(!(offset instanceof String)) offset = offset[0]
			return offset.toInteger()
		}
		return 0
	}

	public static void decrementResultCount(def session, String varName){
		def count = session[varName]
		if(count){
			if(count instanceof Number){
				if(count>0) count--
				session[varName] = count
			}
		}
	}

	public static def convertParam(def domainClass, def params, def searchField){
		def value = params[searchField]
		if(value){
			if(searchField.endsWith('id')){
				if(searchField.split('\\.').length==2){
					if(value!='null'){
						value = value.toLong()
					}
				}
			}else{
				def propType = ReflectionUtils.classOf(domainClass,searchField)
				if(Date.class.isAssignableFrom(propType)){
					value = convertDateParam(propType, value)
				}else{
					value = params[searchField].asType(propType)
				}
			}
			return value
		}
		return null
	}
	
	public static def convertDateParam(def propType, def val){
		if(propType==java.util.Date || propType==java.sql.Date){
			val = new java.text.SimpleDateFormat(SysConfig.get('converter.datePattern')).parse(val) 
		}else if(propType==java.sql.Timestamp || propType==java.util.Calendar){
			try{
				val = new java.text.SimpleDateFormat(SysConfig.get('converter.datetimePattern')).parse(val)
			}catch(ParseException e){
				val = new java.text.SimpleDateFormat(SysConfig.get('converter.datePattern')).parse(val) 
			}
		}else if(propType==java.sql.Time){
			val = new java.text.SimpleDateFormat(SysConfig.get('converter.timePattern')).parse(val)
		}
		return val
	}
	
	public static QueryBean parseFindCondition (def domainClass, def params){
		return parseFindCondition(domainClass, params, null)
	}
	
	public static QueryBean parseFindCondition (def domainClass, def params, def addCond){
		def queryBean = new QueryBean()
		domainClass.searchFields.each { searchField,sqlOper ->
			searchField = searchField.trim()
			def value = convertParam(domainClass, params, searchField)
			if(value){
				if(sqlOper=='between'){
					def value2 = convertParam(domainClass, params, searchField+"_")
					if(value2){
						queryBean.queryParams << value
						queryBean.queryParams << value2
						queryBean.queryString += "and d.$searchField between ? and ? "
					}else{
						queryBean.queryParams << value
						queryBean.queryString += "and d.$searchField  >= ? "
					}
				}else if(sqlOper=='ilike'){
					value = value.replaceAll('\\%',';%')
					value = value.replaceAll('\\_',';_')
					queryBean.queryParams << '%'+value+'%'
					queryBean.queryString += "and upper(d.$searchField) like upper(?) escape ';' "
				}else if(sqlOper=='like'){
					value = value.replaceAll('\\%',';%')
					value = value.replaceAll('\\_',';_')
					queryBean.queryParams << '%'+value+'%'
					queryBean.queryString += "and d.$searchField like ? escape ';' "
				}else{
					queryBean.queryParams << value
					queryBean.queryString += "and d.$searchField $sqlOper ? "
				}
			}else{
				if(sqlOper=='between'){
					def value2 = convertParam(domainClass, params, searchField+"_")
					if(value2){
						queryBean.queryParams << value2
						queryBean.queryString += "and d.$searchField  <= ? "
					}
				}
			}
		}
		if(addCond){
			queryBean.queryString += addCond
		}
		if(params.sort){
			if(!params.order) params.order='asc'
			queryBean.queryString += "order by d.${params.sort} ${params.order}"
		}
		return queryBean
	}
	
	public static def exportDataToWriterStream(def domainClass, def response, def params, def options){
		
		String fileName = params.fileName?:'untitled.csv'
		boolean isEscapeCsv = params.escapeCsv?:true
		String columnSeparator = params.columnSeparator?:','
		String fileFormat = params.fileFormat?:'WIN'
		String fileEncoding = params.fileEncoding?:'UTF-8'
		String lineSeparator = null
		if(fileFormat.startsWith("WIN")){
			lineSeparator = "\r\n"
		}else if(fileFormat.startsWith("UNIX")){
			lineSeparator = "\n"
		}else if(fileFormat.startsWith("MAC")){
			lineSeparator = "\r"
		}
		if("\t".equals(columnSeparator)){
			columnSeparator = "\t"
		}
		response.setCharacterEncoding(fileEncoding)
		response.setContentType("text/csv")
		response.setHeader("Content-Disposition","attachment; filename=${fileName}")
		
		def subResultSize = options.subResultSize
		def fullListSize = options.fullListSize
		def totalRound = (fullListSize/subResultSize)+1
		
		def queryString = options.queryString
		def queryParams = options.queryParams
		
		OutputStream out = response.getOutputStream()
		BufferedOutputStream bout = null
		if(out instanceof BufferedOutputStream){
			bout = (BufferedOutputStream)out
		}else{
			bout = new BufferedOutputStream(out)
		}
		OutputStreamWriter writer = new OutputStreamWriter(bout, Charset.forName(fileEncoding))
		
		domainClass.exportFields.each {
			writer.append it
			writer.append columnSeparator
		}
		writer.append lineSeparator
		int j =0
		def dateFormat = new SimpleDateFormat(SysConfig.get('converter.datePattern'))
		def dateTimeFormat = new SimpleDateFormat(SysConfig.get('converter.datetimePattern'))
		def timeFormat = new SimpleDateFormat(SysConfig.get('converter.timePattern'))
		for(int i=0; i<totalRound;i++){
			def paginate = [max:subResultSize,offset:j]
			def rows = domainClass.findAll(queryString,queryParams,paginate)
			for(row in rows){
				for(eField in domainClass.exportFields){
					def value = row[eField]
					value = value?:''
					def valueType = value.getClass()
					if(valueType==java.util.Date.class || valueType==java.sql.Date.class){
						value = dateFormat.format(value)
					}else if(valueType==java.sql.Timestamp.class || valueType==Calendar.class){
						value = dateTimeFormat.format(value)
					}else if(valueType==java.sql.Time.class){
						value = timeFormat.format(value)
					}
					value = value.toString()
					if(isEscapeCsv){
						value = StringEscapeUtils.escapeCsv(value?.toString())
					}
					writer.append value
					writer.append columnSeparator
				}
				writer.append lineSeparator
			}
			j+=subResultSize
		}
		return writer
	}
}
