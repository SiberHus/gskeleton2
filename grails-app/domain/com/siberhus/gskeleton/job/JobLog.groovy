package com.siberhus.gskeleton.job



import java.sql.Timestamp;

import com.siberhus.gskeleton.Timestampable;

class JobLog extends Timestampable {

	String jobGroup
	String jobName
	String status
	String message
	
	Timestamp createdDate_
	
	static transients = ['createdDate_'];
	
	static mapping = {
		table 'gsk_job_logs'
		jobGroup column: 'job_group'
		jobName column: 'job_name'
	}
	
	static constraints = {
		jobGroup(nullable:false)
		jobName(nullable:false)
		status(nullable:false, inList:['RUNNING','ERROR','SUCCESS'])
		message(nullable:true, maxSize:4000)
	}
	
	static belongsTo = Job
	
	static searchFields = ['jobGroup':'=','jobName':'like',status:'=',dateCreated:'between'];
	static listFields = ['jobGroup','jobName','status','message','dateCreated','lastUpdated'];
	
}
