
package com.siberhus.gskeleton.sfm



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import java.sql.Timestamp
import com.siberhus.gskeleton.base.User
import org.apache.shiro.SecurityUtils
import org.apache.commons.io.FileUtils
import com.siberhus.gskeleton.web.CrudMessageHelper

class FileOpLogController {

	String VIEW_LIST = '/sfm/fileOpLog/list'
	String VIEW_SHOW = '/sfm/fileOpLog/show'
	
	static String SEARCH_COUNT = 'fileOpLog.count'
	static String SEARCH_QUERY_STRING = 'fileOpLog.queryString'
	static String SEARCH_QUERY_PARAMS = 'fileOpLog.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'fileOpLog')
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new FileOpLog(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def fileOpLogCount = FileOpLog.count();
			session[SEARCH_COUNT] = fileOpLogCount
			def fileOpLogInstance = new FileOpLog(params)
			render(view:VIEW_LIST,model:[instanceList: FileOpLog.list(params), instanceTotal: fileOpLogCount, instance: fileOpLogInstance])
		}
	}

	def show = {
		def instance = FileOpLog.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def delete = {
		def instance = FileOpLog.get(params.id)
		if (instance) {
			try {
				instance.delete()
				CrudHelper.decrementResultCount(session, SEARCH_COUNT)
				CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
				redirect(action: "list")
			}catch (org.springframework.dao.DataIntegrityViolationException e) {
				CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
				redirect(action: "show", id: params.id)
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
	}
	
	def bulkDelete = {
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			for(id in params.ids){
				def fileOpLogInstance = FileOpLog.get(id)
				if (fileOpLogInstance) {
					try {
						fileOpLogInstance.delete()
						CrudHelper.decrementResultCount(session, SEARCH_COUNT)
					}catch (org.springframework.dao.DataIntegrityViolationException e) {
						CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
						redirect(action: "list", id: params.id)
						return
					}
				}else {
					CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
					redirect(action: "list")
					return
				}
			}
			CrudMessageHelper.setBulkDeletedMessage(flash, modelName , params.ids)
		}
		params.remove('ids')
		params.remove('_ids')
		redirect(action: "list", params:params)
	}
	
	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from FileOpLog as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
//			if(params.parent?.id){
//				condString += 'and d.parent.id = ? '
//				queryParams << params.parent.id?.toLong()
//			}
//			if(params.name){
//				condString += 'and lower(d.name) like lower(?) '
//				queryParams << params.name
//			}
			try{
				def queryBean = CrudHelper.parseFindCondition(FileOpLog, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash,e)
			}
		}
		
		def results = FileOpLog.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = FileOpLog.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def fileOpLogInstance = new FileOpLog(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: fileOpLogInstance])
		
	}
	
	def export = {
		if(!FileOpLog.metaClass.hasProperty(FileOpLog,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(FileOpLog, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}

	static def logFileOperation(File file, String op, File oldFile){
//		println "Logging file operation: $op for file: $file"
		if(!file.exists()){
			throw new FileNotFoundException("File $file.name not found")
		}
		String username = SecurityUtils.getSubject().getPrincipal()
		FileOpLog fol = new FileOpLog()
		fol.filePath = file.canonicalPath
		fol.user = User.findByUsername(username)
		fol.operation = op
		fol.operationDate = new Timestamp(new Date().getTime())
		if(!file.isDirectory() && (op in [FileOpLog.OP_CREATE,FileOpLog.OP_MODIFY,FileOpLog.OP_DOWNLOAD]) ){
			fol.checksum = FileUtils.checksumCRC32(file)
//			println "File Checksum: $fol.checksum"
		}
		if(oldFile){
			fol.oldFilePath = oldFile.canonicalPath
		}
		return fol
	}

}
