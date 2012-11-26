package com.siberhus.mazzmailer

import com.siberhus.gskeleton.Auditable

class MailingListGroup extends Auditable{

	String name
	String description
	String status
	
	String toString(){
		return name
	}
	
	static mapping = {
		table 'mm_mailing_list_groups'
		
	}

	static constraints = {
		name(blank:false)
		description(blank:false, maxSize:4000)
		status(blank:false, inList:['A','I'])
	}

	static hasMany = [mailingListSouces: MailingListSource]
	
	static searchFields = [name:'like', description:'like', status:'=']
//	static exportFields = ['fieldName']
//	static lookupFields = [fieldName:]
//	static listFields = ['name','description','status']
}
