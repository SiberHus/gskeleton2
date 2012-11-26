package com.siberhus.gskeleton.base;

import java.sql.Timestamp;
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.web.UserSessionMonitor
import com.siberhus.gskeleton.security.SecuritySession
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.apache.shiro.web.util.WebUtils

class AuthController {
	
	static allowedMethods = [signIn: "POST"];
	
	def shiroSecurityManager
	def userConfigService

	def index = {
		redirect(action: "login", params: params)
	}

	def login = {
		
		render(view:'/base/auth/login',model:[ username: params.username,
			rememberMe: (params.rememberMe != null), targetUri: params.targetUri ])
	}
	
	def signIn = {
		
		def authToken = new UsernamePasswordToken(params.username, params.password)
		
		// Support for "remember me"
		if (params.rememberMe) {
			authToken.rememberMe = true
		}
		
		// If a controller redirected to this page, redirect back
		// to it. Otherwise redirect to the root URI.
		def targetUri = params.targetUri ?: "/"
		
		// Handle requests saved by Shiro filters.
		def savedRequest = WebUtils.getSavedRequest(request)
		if (savedRequest) {
			targetUri = savedRequest.requestURI - request.contextPath
			if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
		}
		
		// Keep the username and "remember me" setting so that the
		// user doesn't have to enter them again.
		def m = [ username: params.username, lang:params.lang ]
		if (params.rememberMe) {
			m["rememberMe"] = true
		}
		
		// Remember the target URI too.
		if (params.targetUri) {
			m["targetUri"] = params.targetUri
		}
		
		try{
			
			// Perform the actual login. An AuthenticationException
			// will be thrown if the username is unrecognised or the
			// password is incorrect.
			SecurityUtils.subject.login(authToken)

			def user = User.findByUsername(params.username)
			//fetch roles and its permissions
			if(user.roles){
				user.roles.size()
				user.roles.permissions.size()
			}
			user.permissions?.size()

			
			if(user.status!='A'){
				SecurityUtils.subject.logout()
				if(user.status=='I'){
					flash.message = message(code: 'login.failed.inactive')
				}else if(user.status=='E'){
					flash.message = message(code: 'login.failed.expired')
				}else if(user.status=='S'){
					flash.message = message(code: 'login.failed.suspended')
				}else if(user.status=='D'){
					flash.message = message(code: 'login.failed.deleted')
				}				
				redirect(action: "login", params: m)
				return
			}
			
			if(user.expiryDate){
				if(user.expiryDate < new Date()){
					user.status = 'E'
					user.save()
					SecurityUtils.subject.logout()
					flash.message = message(code: 'login.failed.expired')
					redirect(action: "login", params: m)
					return
				}
			}
			
			if( !SysConfig.get('security.authc.multiSessionLogin')){
				if(UserSessionMonitor.isMultiSessionLogin(params.username)){
					SecurityUtils.subject.logout()
					flash.message = message(code: "login.failed.multisession")
					redirect(action: "login", params: m)
					return
				}
			}
			if( !SysConfig.get('security.authc.multiAddressLogin')){
				if(UserSessionMonitor.isMultiAddressLogin(params.username, request.remoteAddr)){
					SecurityUtils.subject.logout()
					flash.message = message(code: "login.failed.mutiaddress")
					redirect(action: "login", params: m)
					return
				}
			}

			userConfigService.setValue('language', String.class, params.lang)
			def userSessMon = new UserSessionMonitor(params.username, params.lang, request)
			SecuritySession.setUserSessionMonitor(session, userSessMon)
			session['locale'] = request.locale
			
			if(SysConfig.get('security.authc.maxLoginFailures')>0){
				LoginFailure lf = LoginFailure.findByUsername(params.username)?:new LoginFailure([username:params.username])
				lf.failCount = 0
				lf.save()
				if(user.status!='A'){
					user.status = 'A'
					user.save()
				}
			}
			
			log.info "Redirecting to '${targetUri}'."
			if(targetUri==null || targetUri=='/'){
				targetUri = SysConfig.get('security.authc.defaultSuccessView')
			}
			redirect(uri: targetUri)
		}catch (AuthenticationException ex){
			// Authentication failed, so display the appropriate message
			// on the login page.
			log.info "Authentication failure for user '${params.username}'."
			flash.message = message(code: "login.failed")
			
			if(SysConfig.get('security.authc.maxLoginFailures')>0){
				
				def user = User.findByUsername(params.username)
				if(user){
					LoginFailure lf = LoginFailure.findByUsername(params.username)
					if(lf==null){
						lf = new LoginFailure([username:params.username])
					}
					lf.failCount += 1
					if(lf.failCount>=SysConfig.get('security.authc.maxLoginFailures')){
						
						user.status = 'S'
						user.save()
						lf.suspendedDate = new Date()
					}
					lf.save()
				}
			}
			if(SysConfig.get('security.log.loginFailure')){
				def lfl = new LoginFailureLog([username: params.username, ipAddress: request.remoteAddr,
					language: params.lang, userAgent: params.userAgent,
					tryDate: new Timestamp(new Date().time) ])
				lfl.save()
			}
			// Now redirect back to the login page.
			redirect(action: "login", params: m)
		}
	}
	
	def signOut = {
		def userSessMon = SecuritySession.getUserSessionMonitor(session)
		if(userSessMon){
			userSessMon.removeLoginUser(userSessMon.username)
			def loginLog = userSessMon.getLoginLog()
			if(loginLog){
				loginLog.logoutDate = new Timestamp(new Date().time)
				loginLog.manLogout = true
				loginLog.save()
			}
		}
		
		// Log the user out of the application.
		SecurityUtils.subject?.logout()
		
		// For now, redirect back to the home page.
		redirect(uri: "/auth/login")
	}
	
	def unauthorized = {
		render "You do not have permission to access this page."
	}
}
