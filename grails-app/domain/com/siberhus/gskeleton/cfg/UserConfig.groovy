package com.siberhus.gskeleton.cfg
;

import org.springframework.util.ClassUtils;

import com.siberhus.gskeleton.Auditable;

class UserConfig extends Auditable {

	String username
	String name
	String type
	String value
	String description
	
	String toString(){
		return "$name = $value"
	}
	
	static mapping = {
		table "gsk_user_configs"
	}
	
	static constraints = {
		username(blank:false)
		name(blank:false, unique: 'username')
		type(blank:false, validator: {val, obj->
			try{
				ClassUtils.forName(val)
			}catch(ClassNotFoundException e){
				return '_error.userConfig.classNotFound'
			}
			return true
		})
		value(nullable:true)
		description(nullable:true, maxSize:4000)
	}
	
	static searchFields = [name:'like',type:'=']
	static exportFields = ['username','name','type','value']
	
}
