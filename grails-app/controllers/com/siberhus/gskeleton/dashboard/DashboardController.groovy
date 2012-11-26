package com.siberhus.gskeleton.dashboard

import com.siberhus.gskeleton.web.UserSessionMonitor
import org.apache.commons.lang.StringUtils

class DashboardController {

	private static final SESSION_NAME = 'gs_widgets'
	
	def index = {

		def userWidgets = []
		
		if(session[SESSION_NAME]){
			def widgetIds = session[SESSION_NAME]
			if(widgetIds){
				def param = StringUtils.substringBetween(widgetIds.toString(),'[',']')
				def q = "from Widget where id in ($param) and status='A'"
				userWidgets = Widget.executeQuery(q)
			}
		}else{
			def userWidgetIds = []
			def allWidgets = Widget.executeQuery("from Widget where status='A'")
			def userSess = UserSessionMonitor.get(session)
			def userRoles = userSess.userObject.roles*.id
			for(widget in allWidgets){
				def widgetRoles = widget.roles*.id
				if(widgetRoles){
					for(String userRole in userRoles){
						if(widgetRoles.contains(userRole)){
							userWidgets << widget
							userWidgetIds << widget.id
						}
					}
				}else{
					userWidgets << widget
					userWidgetIds << widget.id
				}
			}
			session[SESSION_NAME] = userWidgetIds
		}
		
		render(view:'/dashboard/dashboard', model:[userWidgets:userWidgets])
	}
}
