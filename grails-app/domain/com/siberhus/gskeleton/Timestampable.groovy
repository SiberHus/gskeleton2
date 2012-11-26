package com.siberhus.gskeleton



import java.sql.Timestamp;

abstract class Timestampable {
	
	Timestamp createdDate
	Timestamp modifiedDate
	
	static mapping = {
		autoTimestamp false
		createdDate column: 'created_date'
		modifiedDate column: 'modified_date'
	}
	
	static constraints = {
		createdDate(nullable:true)
		modifiedDate(nullable:true)
	}
	
	def beforeInsert = {
		createdDate = _now()
	}
	
	def beforeUpdate = {
		modifiedDate = _now()
	}
	
	protected static Timestamp _now() {
		return new Timestamp(new Date().time)
	}
	
}
