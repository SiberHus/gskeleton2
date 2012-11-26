package com.siberhus.gskeleton.job

class JobGroup {

	String name
	String description
	
	String toString(){
		return name
	}
	
	static mapping = {
		table 'gsk_job_groups'
	}

	static constraints = {
		name(blank:false)
		description(blank:false, maxSize:4000)
	}

	static hasMany = [jobs: Job]
	
	static searchFields = [name:'like',description:'like']
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	//static listFields = ['fieldName']
}
