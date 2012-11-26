package com.siberhus.gskeleton.base

import com.siberhus.gskeleton.Auditable;



class Role extends Auditable{
	
	String name
	String description
	String status = 'A'
	
	String toString(){
		return name
	}
	
	static mapping = {
		table "gsk_roles"
		users cascade: 'lock'
    }
	
    static constraints = {
		name(blank:false, unique:true)
		description(nullable:true, maxSize:4000)
		//permissions(nullable:true)
		status(blank:false, inList:['A','I'])
    }
	
	static hasMany = [ users: User, permissions: String ]
	static belongsTo = User
	
//	static auditable = true
	
	static searchFields = ['parent.id':'=','name':'ilike','status':'=']
	static exportFields = ['name','description','status','permissions']
}
