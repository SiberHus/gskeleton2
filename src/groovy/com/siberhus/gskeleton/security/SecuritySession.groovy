package com.siberhus.gskeleton.security

import com.siberhus.gskeleton.web.UserSessionMonitor
import javax.servlet.http.HttpSession
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 5, 2010
 * Time: 10:33:09 PM
 * To change this template use File | Settings | File Templates.
 */
class SecuritySession {

	static UserSessionMonitor getUserSessionMonitor(HttpSession session){
		String sessionName = CH.config.gskeleton.security.sessionName.userSessionMonitor
		return session.getAttribute(sessionName)
	}

	static void setUserSessionMonitor(HttpSession session, UserSessionMonitor value){
		String sessionName = CH.config.gskeleton.security.sessionName.userSessionMonitor
		session.setAttribute(sessionName, value)
	}
	
}
