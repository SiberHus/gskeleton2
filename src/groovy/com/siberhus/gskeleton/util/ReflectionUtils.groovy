package com.siberhus.gskeleton.util

import java.lang.reflect.Modifier;


class ReflectionUtils {
	
	static typeMaps = [:]
	
	/**
	 * Thanks Shawn Hartsock for the idea
	 * http://hartsock.blogspot.com/2007/12/fun-with-groovy-and-reflection-api.html
	 */
	static getTypeMap(Class clazz) {
		def typeMap = typeMaps.get(clazz)
		if(typeMap) return typeMap
		typeMap = [:];
		while( clazz!=null ){
			def members = clazz.declaredFields
			for(def m in members){
				if(!m.isAccessible()){
					m.setAccessible(true)
				}
				if(m.name.startsWith('$') || m.name.startsWith('_')
				|| Modifier.isStatic(m.modifiers)
				|| Modifier.isFinal(m.modifiers)
				|| m.name=='metaClass'){
					continue
				}
				typeMap[m.name] = m.type	
			}
			clazz = clazz.superclass
		}
		typeMaps[clazz] = typeMap
		return typeMap 
	}

	/**
	 * Thanks Shawn Hartsock for the idea
	 * http://hartsock.blogspot.com/2007/12/fun-with-groovy-and-reflection-api.html
	 */
	static classOf(Class clazz, field) {
		def typeMap = getTypeMap(clazz)
		if(typeMap.containsKey(field)) {
			return typeMap[field]
		}
		else {
			return null
		}
	}
	
}
