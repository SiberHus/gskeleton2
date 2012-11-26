package com.siberhus.gskeleton.config

import com.siberhus.gskeleton.cfg.SystemConfig;
import com.siberhus.gskeleton.util.PseudoSingletonMap

class SysConfig {
	
	private static final PseudoSingletonMap CONFIG_CACHE = new PseudoSingletonMap()
	
	public static boolean contains(String name){
		return contains('gskeleton', name)
	}
	
	public static boolean contains(String systemName, String name){
		name = systemName +'.' +name
		def config = SystemConfig.findByName(name)
		if(config!=null){
			return true 
		}
		return false
	}
	
	public static def get(String name){
		return SysConfig.get('gskeleton', name)
	}
	
	public static def get(String systemName, String name){
		name = systemName +'.' +name
		
		Map cache = CONFIG_CACHE.get()
		if(cache.containsKey(name)){
			return cache.get(name)
		}
		def config = SystemConfig.findByName(name)
		if(config==null) {
			throw new MissingPropertyException("system configuration not found for key: $name")
		}
		return convertAndCache(cache, config)
	}
	
	public static void set(String name, String value){
		SysConfig.set('gskeleton', name, value)
	}
	
	public static void set(String systemName, String name, String value){
		name = systemName +'.' +name
		
		def config = SystemConfig.findByName(name)
		if(config==null) {
			throw new MissingPropertyException("system configuration not found for key: $name")
		}
		config.value = value
		if(config.save()){
			Map cache = CONFIG_CACHE.get()
			convertAndCache(cache, config)
		}else{
			throw new ConfigurationException(config)
		}
	}
	
	private static def convertAndCache(Map cache, SystemConfig config){
		if(!config.value){
			return null
		}
		if(config.multiValues){
			def vals = []
			for(def v in config.value?.split(",")){
				vals << convertScalarType(v, config.type)
			}
			cache.put(config.name, vals)
			return vals
		}else{
			def val = convertScalarType(config.value, config.type)
			cache.put(config.name, val)
			return val
		}
	}
	
	private static def convertScalarType(String v, String type){
		if(!v) return null
		if(type=='int'){
			return Integer.parseInt(v)
		}else if(type=='long'){
			return Long.parseLong(v)
		}else if(type=='float'){
			return Float.parseFloat(v)
		}else if(type=='double'){
			return Double.parseDouble(v)
		}else if(type=='boolean'){
			return Boolean.parseBoolean(v)
		}
		return v
	}
	
}

