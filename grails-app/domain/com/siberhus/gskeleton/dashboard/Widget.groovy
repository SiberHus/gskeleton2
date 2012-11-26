package com.siberhus.gskeleton.dashboard

import com.siberhus.gskeleton.base.Role
import com.siberhus.gskeleton.Auditable
import org.apache.commons.codec.digest.DigestUtils

class Widget extends Auditable{

	String code //code is generated from name
	String name
	String contentPath
	String description
	String status
	String defaultPosition = 'CENTER'
	
	String toString(){
		return name
	}

	void setName(String name){
		this.name = name
		if(name) this.code = DigestUtils.md5Hex(name)
	}
	//static transients = ['fieldName']

	static mapping = {
		table 'gsk_widgets'
		contentPath column: 'content_path'
		defaultPosition column: 'default_position'
		roles column: 'widget_id', joinTable: 'gsk_widgets_roles'
	}

	
	static constraints = {
		code(blank:false, unique:true)
		name(blank:false, unique:true)
		contentPath(blank:false)
		description(nullable:true)
		status(blank:false, inList:['A','I'])
		defaultPosition(balnk:false, inList:['CENTER','LEFT','RIGHT'] )
	}

	static hasMany = [roles: Role]

	static searchFields = [name:'like', description:'like', status:'=']
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	//static listFields = ['fieldName']
}
