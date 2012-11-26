package com.siberhus.gskeleton.cfg

import com.siberhus.gskeleton.Auditable


class SystemConfig extends Auditable{
	
	String name	
	String value
	String description
	String type = 'string'
	boolean required = true
	boolean multiValues = false
	boolean needRestart = true
	
	String toString(){
		return "$name = $value"
	}
	
	static mapping = {
		table 'gsk_system_configs'
		multiValues column: 'multi_values'
		needRestart column: 'need_restart'
	}
	
	static constraints = {
		name(blank:false, unique: true)		
		value(nullable:true, validator: {val, obj->
			if(!val?.trim() && obj.required){
				return 'required.missing'
			}
		})
		description(nullable:true, maxSize:4000)
		type(blank:false, inList:['string','int','long','float','double','boolean'],validator: {val, obj->
			if(!obj.value){
				return true
			}
			try{
				if(obj.multiValues){
					for(def v in obj.value?.split(",")){
						v = v.trim()
						if(val=='int'){
							Integer.parseInt v
						}else if(val=='long'){
							Long.parseLong v
						}else if(val=='float'){
							Float.parseFloat v
						}else if(val=='double'){
							Double.parseDouble v
						}else if(val=='boolean'){
							Boolean.parseBoolean v
						}
					}
				}else{
					if(val=='int'){
						Integer.parseInt obj.value
					}else if(val=='long'){
						Long.parseLong obj.value
					}else if(val=='float'){
						Float.parseFloat obj.value
					}else if(val=='double'){
						Double.parseDouble obj.value
					}else if(val=='boolean'){
						Boolean.parseBoolean obj.value
					}
				}
			}catch(Exception e){
				return 'invalid.valueType'
			}
			return true
		})
		required()
		multiValues()
		needRestart()
	}
	
	static searchFields = [name:'like',type:'=']
	static exportFields = ['name','type','value']
}
