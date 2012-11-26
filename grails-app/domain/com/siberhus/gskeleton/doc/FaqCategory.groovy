package com.siberhus.gskeleton.doc

import com.siberhus.gskeleton.Auditable

class FaqCategory extends Auditable {

	String name
	String description
	
	String toString(){
		return name
	}

	static mapping = {
		table 'gsk_faq_categories'
	}

	static constraints = {
		name(blank:false, unique:true)
		description(nullable:true, maxSize:4000)
	}

	static hasMany = [faqs: Faq]
	
	static searchFields = [name:'like', description:'like']
	static exportFields = ['name', 'description']
	static listFields = ['name', 'description']
}
