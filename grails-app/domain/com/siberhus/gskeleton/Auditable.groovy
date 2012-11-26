package com.siberhus.gskeleton

;

import java.sql.Timestamp;

import org.apache.shiro.SecurityUtils;

abstract class Auditable {
	
	Timestamp createdDate
	String createdBy
	Timestamp modifiedDate
	String modifiedBy

	Object _username //work around to prevent GORM do the mapping 

	static mapping = {
		autoTimestamp false
		createdDate column: 'created_date'
		createdBy column: 'created_by'
		modifiedDate column: 'modified_date'
		modifiedBy column: 'modified_by'
	}

//	static transients = ['_username'] //this is disabled in super class
	
	static constraints = {
		createdDate(nullable:true)
		createdBy(nullable:true)
		modifiedDate(nullable:true)
		modifiedBy(nullable:true)
	}
	
	def beforeInsert = {
		createdDate = _now()
		createdBy = _username?:_getUsername()
	}
	
	def beforeUpdate = {
		modifiedDate = _now()
		modifiedBy = _username?:_getUsername()
	}

	def overrideUsername(String username){
		this._username = username
	}

	protected static Timestamp _now() {
		return new Timestamp(new Date().time)
	}

	protected static String _getUsername(){
		try{
//			return SecurityUtils.getSubject().getSession().getAttribute('username')
			return SecurityUtils.subject?.principal
		}catch(Exception e){
			return 'unknown'
		}
	}
}
