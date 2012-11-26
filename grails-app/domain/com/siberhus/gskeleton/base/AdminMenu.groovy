package com.siberhus.gskeleton.base

import com.siberhus.gskeleton.Auditable

class AdminMenu extends Auditable{

	String code
	String label
	String labelKey
	String imageIcon
	String destRoute = 'system'
	String controllerName
	String actionName
	String targetUrl
	String targetName = '_self'
	Integer menuOrder = 0
	String description
	String status = 'A'

	String toString(){
		return code
	}

	//static transients = ['fieldName']

	static mapping = {
		cache true
		table 'gsk_admin_menus'
//		sort children:'asc'
		//***********************//
		label column: 'menu_label'
		labelKey column: 'menu_label_key'
		destRoute column: 'destination_route'
		controllerName column: 'controller_name'
		actionName column: 'action_name'
		targetUrl column: 'target_url'
		targetName column: 'target_name'
		menuOrder column: 'menu_order'

		roles column: 'admin_menu_id', joinTable: 'gsk_admin_menus_roles'
	}

	static constraints = {
		code(blank:false, unique:true)
		parent(nullable:true)
		label(blank:false)
		labelKey(blank:false)
		imageIcon(nullable:true)
		destRoute(nullable:false, inList:['system','custom'])
		controllerName(nullable:true,validator: {val, obj->
			if(!obj.targetUrl && !val){
				return 'adminMenu.error.noRoute'
			}
			return true
		})
		actionName(nullable:true)
		targetUrl(nullable:true)
		targetName(inList:['_self','_blank','_top','_parent'])
		menuOrder(nullable:true)
		description(nullable:true, maxSize:4000)
		//roles()
		//children()
		status(blank:false, inList:['A', 'I', 'H']) 
	}

	static hasMany = [children: AdminMenu, roles: Role]
	static belongsTo = [parent: AdminMenu]

	static searchFields = [code:'=',label:'like',labelKey:'like',targetUrl:'like',description:'like',status:'=']
	static exportFields = ['code','parent.id','label','labelKey','targetUrl','targetName']
	static lookupFields = ['parent.id':'adminMenu']
	//static listFields = ['fieldName']
}
