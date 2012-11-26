package com.siberhus.gskeleton.sfm

import java.sql.Timestamp 
import com.siberhus.gskeleton.base.User;

class FileOpLog {
	
	static final OP_CREATE = 'CREATE'
	static final OP_MODIFY = 'MODIFY'
	static final OP_DELETE = 'DELETE'
	static final OP_WIPE = 'WIPE'
	static final OP_MOVE = 'MOVE'
	static final OP_RESTORE = 'RESTORE'
	static final OP_RENAME = 'RENAME'
	static final OP_DOWNLOAD = 'DOWLOAD'
	
	String filePath
	User user
	String operation
	Timestamp operationDate
	Timestamp operationDate_
	String oldFilePath
	String checksum
	
	String toString(){
		return "${operation}>${filePath}"
	}
	
	static transients = [ "operationDate_"]
	
	static mapping = {
		table "gsk_file_op_logs"
		
		filePath column: 'file_path'
		operationDate column: 'operation_date'
		oldFilePath column: 'old_file_path'
	}
	
	static constraints = {
		filePath(blank:false)
		user(nullable:false)
		operation(nullable:false,inList:['CREATE','MODIFY','DELETE','WIPE','MOVE','RESTORE','RENAME','DOWLOAD'])
		operationDate(nullable:false)
		oldFilePath(nullable:true)
		checksum(nullable:true)
	}
	
	static searchFields = [filePath:'like','user.id':'=',operation:'=',operationDate:'between']
	static exportFields = ['filePath','user','operation','description','operationDate','oldFilePath','checksum']
	static listFields = ['filePath','user','operation','operationDate','oldFilePath']
	
}
