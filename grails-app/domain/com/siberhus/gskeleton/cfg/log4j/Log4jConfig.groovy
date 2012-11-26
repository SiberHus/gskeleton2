package com.siberhus.gskeleton.cfg.log4j

import com.siberhus.gskeleton.Auditable

class Log4jConfig extends Auditable{

	String name
	String level

	String toString(){
		return "$name - $level"
	}

	static mapping = {
		table 'gsk_log4j_configs'
		level column: 'log_level' //level is Oracle reserved word
	}

	static constraints = {
		name(blank:false, unique:true)
		level(blank:false, inList:['ALL','TRACE','DEBUG','INFO','WARN','ERROR','FATAL','OFF'])
	}
	
	//static searchFields = [fieldName:operation]
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	static listFields = ['name', 'level']
}
