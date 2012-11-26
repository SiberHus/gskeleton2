package com.siberhus.gskeleton.base;

import grails.converters.JSON;

class PermissionController {
	
	def index = {
		render(view:'/base/permission/index')
	}
	
	def jsonFindAllActionsByController = {
		def actions = new TreeSet()
		actions << "*"
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
	
	static updateObjectPermissions(def instance, def params){
		if(params.permissions){
			if(params.permissions.class==String.class){
				instance.addToPermissions(params.permissions)
			}else{
				for(def perm in params.permissions){
					if(perm){
						instance.addToPermissions(perm)
					}
				}
			}
		}else{
			instance.permissions = []
		}
	}
}
