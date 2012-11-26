package com.siberhus.mazzmailer

import com.siberhus.gskeleton.resource.DbConnProfile
import com.siberhus.gskeleton.Auditable

class MailingListSource extends Auditable{

	String name
	String type
	String description
	String status = 'A'
	Integer sampleResultSize
	boolean hasLabel = true
	
	//SQL datasource
	DbConnProfile dbConnProfile
	String sqlValue

	/* ============= File datasource ===============*/ 
	String fileSource
	String filePath
	String fileType
	String fileCharset //csv, txt
	String sheetName //spreadsheet setting (xls,xlsx)
	String tableName //database setting (mdb)

	/* ============= Text datasource ===============*/
	String textValue

	//csv file, text file and text(Copy&Paste) setting
	String fieldSeparator
	String quoteChar
	Boolean strictQuotes


	String primaryEmail
	String secondaryEmail
	boolean multiEmailsColumn = false
	String emailSeparator

	Map dataFields //string map
	
	
	String toString(){
		return name
	}
	//static transients = ['fieldName']

	static mapping = {
		table 'mm_mailing_list_sources'
		sampleResultSize column: 'sample_result_size'
		hasLabel column: 'has_label'
		sqlValue column: 'sql_value'
		fileSource column: 'file_source'
		filePath column: 'file_path'
		fileType column: 'file_type'
		fileCharset column: 'file_charset'
		sheetName column: 'sheet_name'
		tableName column: 'table_name'
		fieldSeparator column: 'field_separator'
		quoteChar column: 'quote_char'
		strictQuotes column: 'strict_quotes'

		primaryEmail column: 'primary_email'
		secondaryEmail column: 'secondary_email'
		multiEmailsColumn column: 'multi_emails_column'
		emailSeparator column: 'email_separator'

		dataFields column: 'mailing_list_source_id', joinTable: 'mm_data_fields'
	}

	static constraints = {
		mailingListGroup(nullable:false)
		name(blank:false, unique:true)
		type(blank:false, inList:['SQL','FILE','TEXT'])
		description(nullable:true, maxSize:4000)
		status(nullable:false, inList:['A','I'])
		sampleResultSize(nullable:false, min:1, max:99)
		hasLabel()
		
		dbConnProfile(nullable:true)
		sqlValue(nullable:true, maxSize:4000)

		fileSource(nullable:true, inList:['LINK','UPLOAD'])
		filePath(nullable:true)
		fileType(nullable:true, inList:['AUTO','CSV','TEXT','XLS','XLSX','MDB'])
		fileCharset(nullable:true)
		sheetName(nullable:true)
		tableName(nullable:true)

		textValue(nullable:true, maxSize:4000)
		fieldSeparator(nullable:true)
		quoteChar(nullable:true)
		strictQuotes(nullable:true)

		primaryEmail(blank:false)
		secondaryEmail(nullable:true)
		multiEmailsColumn()
		emailSeparator(nullable:true)
	}
	
	static belongsTo = [mailingListGroup: MailingListGroup]

	static searchFields = ['mailingListGroup.id':'=',name:'like', type:'=', description:'like', status:'=']
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	static listFields = ['mailingListGroup','name','type','description','status']
}
