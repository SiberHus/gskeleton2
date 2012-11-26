package com.siberhus.gskeleton.dashboard.widget

import grails.converters.JSON
import java.text.DecimalFormat
import grails.util.GrailsUtil

class MemoryInfoWidgetController {
	
	def index = {

		if(GrailsUtil.isDevelopmentEnv()) Thread.sleep(200)
		
		def model = getMemoryInfo()
		render(view:'/dashboard/widgets/memoryInfo', model:model)
	}

	def executeGc = {
		System.gc()
		def model = getMemoryInfo()
		render model as JSON
	}

	def getMemoryInfo(){
		def runtime = Runtime.runtime
		def model = [:]
		def formatter = new DecimalFormat('###,###')
		//Returns the amount of free memory in the Java Virtual Machine.
		model['freeMemory'] = formatter.format((int)(runtime.freeMemory()/1048576))
		//Returns the maximum amount of memory that the Java virtual machine will attempt to use.
		model['maxMemory'] = formatter.format((int)(runtime.maxMemory()/1048576))
		//Returns the total amount of memory in the Java virtual machine.
		model['totalMemory'] = formatter.format((int)(runtime.totalMemory()/1048576))
		return model
	}
}
