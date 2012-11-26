package com.siberhus.gskeleton

import grails.converters.JSON

class SystemController {

    def index = { }

	def error = {
		render(view:'/error')
	}
	
	def info = {
		render(view:'/info')
	}
	
	def jsonFindAllActionsByController = {
		def actions = new TreeSet()
		actions << ""
		if(params.controllerName){
			for(c in grailsApplication.controllerClasses){
				if(c.logicalPropertyName==params.controllerName){
					c.getURIs().each {
						def parts = it.split("/")
						if(parts.length>2){
							actions << parts[2]
						}
					}
					break
				}
			}
		}
		render actions as JSON
	}
	
}
