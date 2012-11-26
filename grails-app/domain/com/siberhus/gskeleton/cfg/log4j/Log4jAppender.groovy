package com.siberhus.gskeleton.cfg.log4j

import static com.siberhus.gskeleton.util.Log4jAppenderFactory.*

/**
 * All appenders will be added to root logger because
 * I've tested to add the appender to other logger but it didn't work.
 * 
 */
class Log4jAppender {

	String name
	String threshold
	String type
	String conversionPattern = '%c{1} %p: %d{dd/MM/yyyy HH:mm:ss} | %m%n'
	Map props = [:]
	
	String toString(){
		return name
	}

	static mapping = {
		table 'gsk_log4j_appenders'
		conversionPattern column: 'conversion_pattern'

		props column: 'log4j_appender_id', joinTable: 'gsk_log4j_appender_props'
	}

	static constraints = {
		name(blank:false, unique:true)
		threshold(blank:false, inList:['ALL','TRACE','DEBUG','INFO','WARN','ERROR','FATAL','OFF'])
		type(blank:false, inList:[FILE,ROLLING_FILE,DAILY_ROLLING_FILE,CONSOLE,SMTP], unique:'threshold')
		conversionPattern(blank:false)
	}
	
	
	//static searchFields = [fieldName:operation]
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	static listFields = ['name','type','conversionPattern']
}
