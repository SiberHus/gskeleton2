package com.siberhus.gskeleton.web;

import java.sql.Timestamp;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;

import com.siberhus.gskeleton.util.PseudoSingletonMap;
import com.siberhus.gskeleton.base.LoginLog;
import com.siberhus.gskeleton.base.User;
import com.siberhus.gskeleton.config.SysConfig;
import com.siberhus.gskeleton.security.SecuritySession
import javax.servlet.http.HttpServletRequest
import com.siberhus.gskeleton.resource.SecurityData
import com.siberhus.gskeleton.resource.SecurityDataHolder

class UserSessionMonitor implements HttpSessionBindingListener {
	
	private static final PseudoSingletonMap LOGIN_USER_MAP = new PseudoSingletonMap()
	
	def userId
	def loginLogId
	String username
	String language
	String ipAddress
	
	public UserSessionMonitor(String username, String language, HttpServletRequest request){
		this.username = username
		this.language = language
		this.ipAddress = request.remoteAddr
		String userAgent = request.getHeader('User-Agent')
		
		if(SysConfig.get('security.log.login')){
			def m = [username:username,ipAddress:ipAddress,
				language:language, userAgent:userAgent,
				loginDate: new Timestamp(new Date().time) ]
			def loginLog = new LoginLog(m)
			loginLog.save(flush:true)
			loginLogId = loginLog.id
		}
		def userObj = User.findByUsername(username)
		this.userId = userObj.id
		SecurityData securityData = new SecurityData(username, userObj.roles*.id as Number[])
		SecurityDataHolder.setSecurityData(ipAddress, securityData)
//		SecurityUtils.getSubject().getSession().setAttribute("username", username)
		
	}
	
	public static UserSessionMonitor get(HttpSession session){
		return SecuritySession.getUserSessionMonitor(session)
	}
	
	public LoginLog getLoginLog() { 
		if(loginLogId)
			return LoginLog.get(loginLogId)
		return null
	}
	
	public def getUserId() { return userId }
	public User getUserObject() { return User.get(userId) }
	public String getUsername() { return username }
	public String getIpAddress() { return ipAddress }
	public String getLanguage() { return language }
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		addLoginUser(username, ipAddress);
	}
	
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		SecurityDataHolder.removeSecurityData(ipAddress)
		removeLoginUser(username);
		if(SysConfig.get('security.log.login')){
			def loginLog = getLoginLog()
			def loginUserMap = LOGIN_USER_MAP.get()
			if( loginLog && loginUserMap.get(username) ){
				loginLog.logoutDate = new Timestamp(new Date().time)
				loginLog.manLogout = false
				loginLog.save()
			}
		}
	}
	
	public static String getLastLoginAddress(String username){
		def loginUserMap = LOGIN_USER_MAP.get()
		return loginUserMap.get(username)
	}
	
	public static void addLoginUser(String username, String loginIpAddress){
		def loginUserMap = LOGIN_USER_MAP.get()
		loginUserMap.put(username, loginIpAddress)
	}
	
	public static void removeLoginUser(String username){
		def loginUserMap = LOGIN_USER_MAP.get()
		loginUserMap.remove(username)
	}
	
	public static boolean isMultiSessionLogin(String username){
		def loginUserMap = LOGIN_USER_MAP.get()
		return loginUserMap.get(username) != null
	}
	
	public static boolean isMultiAddressLogin(String username, String newIpAddress){
		def loginUserMap = LOGIN_USER_MAP.get()
		String oldIpAddress = loginUserMap.get(username)
		if(oldIpAddress!=null){
			if( !newIpAddress.equals(oldIpAddress)){
				return true
			}
		}
		return false
	}
}
