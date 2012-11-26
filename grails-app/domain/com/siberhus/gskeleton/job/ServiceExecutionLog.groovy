package com.siberhus.gskeleton.job

import com.siberhus.gskeleton.Timestampable
import java.sql.Timestamp

class ServiceExecutionLog extends Timestampable {

	String serviceExecutorName
	String serviceParameters
	String requestedBy //username
	String status
	String errorMessage
	
	Timestamp createdDate_
	
	String toString(){
		return "${serviceExecutorName} - ${status}"
	}

	static transients = ['createdDate_'];

	static mapping = {
		table 'gsk_service_execution_logs'
		serviceExecutorName column: 'service_executor_name'
		serviceParameters column: 'service_parameters'
		requestedBy column: 'requested_by'
		errorMessage column: 'error_message'
	}

	static constraints = {
		serviceExecutorName(blank:false)
		serviceParameters(nullable:true)
		requestedBy(blank:false)
		status(blank:false, inList:['RUNNING','ERROR','SUCCESS'])
		errorMessage(nullable:true)
	}

	static belongsTo = ServiceExecutor

	static searchFields = [serviceExecutorName:'like',status:'=',requestedBy:'=']
	static listFields = ['serviceExecutorName','requestedBy','status','dateCreated','lastUpdated']
}
