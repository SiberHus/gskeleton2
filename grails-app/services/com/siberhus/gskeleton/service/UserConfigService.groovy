package com.siberhus.gskeleton.service;


import java.util.concurrent.ConcurrentHashMap;
import org.springframework.util.ClassUtils;
import org.apache.commons.beanutils.ConvertUtils;

import com.siberhus.gskeleton.cfg.UserConfig
import org.apache.shiro.SecurityUtils

class UserConfigService {
	
	private static final Map CLASS_CACHE = new ConcurrentHashMap()
	
	def setValue(String name, Class type, String value){
		String username = SecurityUtils.subject.principal
		UserConfig config = UserConfig.findByUsernameAndName(username, name)
		if(!config){
			config = new UserConfig()
		}
		config.username = username
		config.name = name
		config.type = type.name
		config.value = value
		config.save(flush:true)
		println config.errors
	}
	
	def getValue(String name){
		String username = SecurityUtils.subject.principal
		UserConfig config = UserConfig.findByUsernameAndName(username, name)
		if(config!=null){
			Class clazz = CLASS_CACHE.get(config.type)
			if(clazz==null){
				clazz = ClassUtils.forName(config.type)
				CLASS_CACHE.put(config.type, clazz)
			}
			return ConvertUtils.convert(config.value, clazz)
		}
		return null
	}
	
	def getValue(String name, Object defaultValue){
		def value = getValue(name)
		if(value==null){
			return defaultValue
		}
		return value
	}
	
	def getTypeOfValue(String name){
		String username = SecurityUtils.subject.principal
		UserConfig config = UserConfig.findByUsernameAndName(username, name)
		return ClassUtils.forName(config.type)
	}
	
	
}


