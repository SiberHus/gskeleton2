package com.siberhus.gskeleton.base



class LoginLog {
	
	String username
	String ipAddress
	//From user selected language
	String language
	//Headers[User-Agent] or from javascript
	String userAgent
	java.sql.Timestamp loginDate
	java.sql.Timestamp loginDate_
	java.sql.Timestamp logoutDate
	java.sql.Timestamp logoutDate_
	Boolean manLogout = false
	
	static transients = [ 'loginDate_','logoutDate_' ]
	                      
	static mapping = {
		table 'gsk_login_logs'
		loginAt column: 'login_date'
		logoutAt column: 'logout_date'
		ipAddress column: 'ip_address'
		userAgent column: 'user_agent'
		manLogout column: 'manual_logout'
	}
	
	static constraints = {
		username(blank:false)
		ipAddress(blank:false)
		language(blank:false)
		userAgent(nullable:true, maxSize:2000)
		loginDate(nullable:false)
		logoutDate(nullable:true)
		manLogout()
	}
	
	static searchFields = [username:'like',ipAddress:'like',language:'=',userAgent:'like',loginDate:'between',logoutDate:'between']
	static exportFields = ['username','ipAddress','language','userAgent','loginDate','logoutDate','manLogout']
}
