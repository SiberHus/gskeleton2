package com.siberhus.gskeleton.base



class LoginFailureLog {
	
	String username
	String ipAddress
	//From user selected language
	String language
	//Headers[User-Agent] or from javascript
	String userAgent
	java.sql.Timestamp tryDate
	java.sql.Timestamp tryDate_
	
	static transients = [ 'tryDate_']
	                      
	static mapping = {
		table 'gsk_login_failure_logs'
		ipAddress column: 'ip_address'
		userAgent column: 'user_agent'
		tryDate column: 'try_date'
	}
	
	static constraints = {
		username(blank:false)
		ipAddress(blank:false)
		language(blank:false)
		userAgent(nullable:true)
		tryDate(nullable:false)
	}
	
	static searchFields = [username:'like',ipAddress:'like',language:'=',userAgent:'=',tryDate:'between']
	static exportFields = ['username','ipAddress','language','userAgent','tryDate']
}
