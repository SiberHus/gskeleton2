package com.siberhus.gskeleton.job

class ServiceParameter implements Comparable{

	String name
	String type = 'string'
	String defaultValue
	String description
	
	String toString(){
		return "$type $name = $defaultValue"
	}

	int compareTo(Object o) {
		return this.id.compareTo(o.id); 
	}

	static mapping = {
		table 'gsk_service_parameters'
		defaultValue column: 'default_value'
	}

	static constraints = {
		serviceExecutor()
		name(blank:false)
		type(blank:false, inList:['string','int','long','float','double','boolean','date','time','datetime'])
		defaultValue(nullable:true)
		description(nullable:true, maxSize:1024)
	}

	static belongsTo = [serviceExecutor: ServiceExecutor]
	
}
