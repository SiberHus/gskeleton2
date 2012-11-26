package com.siberhus.gskeleton.base


class LoginFailure {
	
	String username
	Integer failCount = 0
	Date suspendedDate
	
	static mapping = {
		table 'gsk_login_failures'
		failCount column: 'fail_count'
		suspendedDate column: 'suspended_date'
	}
	
	static constraints = {
		username(blank:false)
		failCount(nullable:false, min:0)
		suspendedDate(nullable:true)
	}
	
	static searchFields = [username:'like']
}
