package com.siberhus.gskeleton.init

import com.siberhus.gskeleton.base.AdminMenu;
import com.siberhus.gskeleton.base.User;
import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.security.CredentialUtils
import com.siberhus.gskeleton.base.Role
import com.siberhus.gskeleton.job.JobGroup
import org.quartz.Scheduler
import grails.util.GrailsUtil

class DataInit {
	
	public void initAdminUser(){
		Object initialized = SysConfig.get('initData.adminUser.initialized')
		if(initialized) return
		def role = new Role([name:'Administrator'])
		role.addToPermissions('*:*')
		role.save()
		def user = new User([username:'admin',firstName:'Administrator',lastName:'System',
				systemAdmin:true, password:'password',email:'changeme@changeme.com'])
		user.password = CredentialUtils.encodePassword(user.password)
//		user.addToPermissions("*:*")
		user.addToRoles(role)
		user.save()
		SysConfig.set('initData.adminUser.initialized', 'true')
	}
	
	public void initDefaultAdminMenus(){
		Object initialized = SysConfig.get('initData.defaultAdminMenus.initialized')
		if(initialized) return
		def menus1 = [
			
			[code:'home',label:'Home',labelKey:'adminMenu.menu.home',targetUrl:'/'],
			
			[code:'admin',label:'Administration',labelKey:'adminMenu.menu.administration'],

			[code:'admin-systemInfo',label:'System Info',labelKey:'adminMenu.menu.systemInfo',controllerName:'system', actionName:'info', parentCode:'admin'],
			
			[code:'admin-userAccess',label:'Users & Access Management',labelKey:'adminMenu.menu.usersAndAccessMgmt', parentCode:'admin'],
			[code:'admin-userAccess-users',label:'Users',labelKey:'adminMenu.menu.users',controllerName:'user', parentCode:'admin-userAccess'],
			[code:'admin-userAccess-roles',label:'Roles',labelKey:'adminMenu.menu.roles',controllerName:'role', parentCode:'admin-userAccess'],
			[code:'admin-userAccess-ipv4Filter',label:'IPv4 Filter',labelKey:'adminMenu.menu.ipv4Filter',controllerName:'ipv4Filter', parentCode:'admin-userAccess'],
			[code:'admin-userAccess-loginLogs',label:'Login Logs',labelKey:'adminMenu.menu.loginLogs',controllerName:'loginLog', parentCode:'admin-userAccess'],
			[code:'admin-userAccess-loginFailureLogs',label:'Login Failure Logs',labelKey:'adminMenu.menu.loginFailureLogs',controllerName:'loginFailureLog', parentCode:'admin-userAccess'],

			[code:'admin-dashboardMgmt',label:'Dashboard Management',labelKey:'adminMenu.menu.dashboardMgmt', parentCode:'admin'],
			[code:'admin-dashboardMgmt-widget',label:'Widgets',labelKey:'adminMenu.menu.widgets',controllerName:'widget', parentCode:'admin-dashboardMgmt'],

			[code:'admin-screenMgmt',label:'Screen Management',labelKey:'adminMenu.menu.screenMgmt', parentCode:'admin'],
			[code:'admin-screenMgmt-i18n',label:'Message (i18n)',labelKey:'adminMenu.menu.i18n',controllerName:'message', parentCode:'admin-screenMgmt'],
			[code:'admin-screenMgmt-adminMenu',label:'Admin Menu',labelKey:'adminMenu.menu.adminMenu',controllerName:'adminMenu', parentCode:'admin-screenMgmt'],
			[code:'admin-screenMgmt-uiTheme',label:'UI Theme',labelKey:'adminMenu.menu.uiTheme',controllerName:'customConfig',actionName:'editTheme', parentCode:'admin-screenMgmt'],
			
			[code:'admin-jobMgmt',label:'Job Management',labelKey:'adminMenu.menu.jobMgmt', parentCode:'admin'],
			[code:'admin-jobMgmt-jobGroup',label:'Job Group',labelKey:'adminMenu.menu.jobGroup', controllerName:'jobGroup', parentCode:'admin-jobMgmt'],
			[code:'admin-jobMgmt-jobScheduler',label:'Job Scheduler',labelKey:'adminMenu.menu.jobScheduler', controllerName:'jobScheduler', parentCode:'admin-jobMgmt'],
			[code:'admin-jobMgmt-jobLogs',label:'Job Logs',labelKey:'adminMenu.menu.jobLogs', controllerName:'jobLog', parentCode:'admin-jobMgmt'],
			[code:'admin-jobMgmt-serviceExecutor',label:'Service Executor',labelKey:'adminMenu.menu.serviceExecutor', controllerName:'serviceExecutor', parentCode:'admin-jobMgmt'],
			[code:'admin-jobMgmt-serviceExecutionLogs',label:'Service Execution Logs',labelKey:'adminMenu.menu.serviceExecutionLog', controllerName:'serviceExecutionLog', parentCode:'admin-jobMgmt'],
			
			[code:'admin-fileMgmt',label:'File Management',labelKey:'adminMenu.menu.fileMgmt', parentCode:'admin'],
			[code:'admin-fileMgmt-dirNode',label:'Directory Node',labelKey:'adminMenu.menu.dirNode',controllerName:'directoryNode', parentCode:'admin-fileMgmt'],
			[code:'admin-fileMgmt-simpleFileMgr',label:'Simple File Manager',labelKey:'adminMenu.menu.simpleFileMgr',controllerName:'simpleFileManager', parentCode:'admin-fileMgmt'],
			[code:'admin-fileMgmt-fileRecycleBin',label:'File Recycle Bin',labelKey:'adminMenu.menu.fileRecycleBin',controllerName:'fileRecycleBin', parentCode:'admin-fileMgmt'],
			[code:'admin-fileMgmt-fileOpLogs',label:'File Operation Logs',labelKey:'adminMenu.menu.fileOpLogs',controllerName:'fileOpLog', parentCode:'admin-fileMgmt'],
			
			[code:'admin-config',label:'Configurations',labelKey:'adminMenu.menu.configurations', parentCode:'admin'],
			[code:'admin-config-security',label:'Security',labelKey:'adminMenu.menu.security', controllerName:'customConfig',actionName:'editSecurity', parentCode:'admin-config'],
			[code:'admin-config-log',label:'Logging',labelKey:'adminMenu.menu.logging', parentCode:'admin-config'],
			[code:'admin-config-log-log4j',label:'Log4j',labelKey:'adminMenu.menu.log4j', controllerName:'log4jConfig', parentCode:'admin-config-log'],
			[code:'admin-config-log-log4jAppender',label:'Log4j Appender',labelKey:'adminMenu.menu.log4jAppender', controllerName:'log4jAppender', parentCode:'admin-config-log'],
			[code:'admin-config-user',label:'User Configurations',labelKey:'adminMenu.menu.userConfigs', controllerName:'userConfig', parentCode:'admin-config'],
			[code:'admin-config-sys',label:'System Configurations',labelKey:'adminMenu.menu.systemConfigs', controllerName:'systemConfig', parentCode:'admin-config'],

			[code:'admin-resources',label:'Resources',labelKey:'adminMenu.menu.resources', parentCode:'admin'],
			[code:'admin-resources-dbConnProfile',label:'DbConnection Profile',labelKey:'adminMenu.menu.dbConnProfile', controllerName:'dbConnProfile', parentCode:'admin-resources'],

			[code:'admin-docMgmt',label:'Document Management',labelKey:'adminMenu.menu.docMgmt', parentCode:'admin'],
			[code:'admin-docMgmt-faqCat',label:'FAQ Category',labelKey:'adminMenu.menu.faqCat',controllerName:'faqCategory', parentCode:'admin-docMgmt'],
			[code:'admin-docMgmt-faq',label:'FAQ Management',labelKey:'adminMenu.menu.faq',controllerName:'faq', parentCode:'admin-docMgmt'],
		]
		def menus2 = [
			[code:'profile',label:'My Profile',labelKey:'adminMenu.menu.profile',controllerName:'personalProfile'],
			[code:'profile-editMyAcc',label:'Edit My Account',labelKey:'adminMenu.menu.editMyAcc',controllerName:'personalProfile',actionName:'editUser', parentCode:'profile'],
			[code:'profile-changePasswd',label:'Change Password',labelKey:'adminMenu.menu.changePasswd',controllerName:'personalProfile',actionName:'changePassword', parentCode:'profile'],
			[code:'profile-loginLogs',label:'Login Logs',labelKey:'adminMenu.menu.loginLogs',controllerName:'personalProfile',actionName:'listLoginLog', parentCode:'profile'],
			[code:'profile-preferences',label:'Preferences',labelKey:'adminMenu.menu.preferences',controllerName:'personalProfile',actionName:'editPreferences', parentCode:'profile'],

			[code:'docs',label:'Documentations',labelKey:'adminMenu.menu.docs'],
			[code:'docs-faqDisplay',label:'FAQ',labelKey:'adminMenu.menu.faqDisplay',controllerName:'faq',actionName:'display', parentCode:'docs'],
			
			//[code:'logout',label:'Logout',labelKey:'adminMenu.menu.logout', menuOrder:99],
		]
		GroovyClassLoader classLoader = new GroovyClassLoader(getClass().classLoader)
		def config
		try{
			config = new ConfigSlurper(GrailsUtil.environment).parse(classLoader.loadClass('DefaultAdminMenus'))
		}catch(Exception ignored){}

		def menus = menus1 + config.defaultAdminMenus.menus + menus2
		int menuOrder = 0
		for(def m in menus){
			AdminMenu menu = new AdminMenu(m)
			if(!menu.controllerName && !menu.targetUrl){
				menu.targetUrl = '#'
			}
			if(m['parentCode']){
				AdminMenu parent = AdminMenu.findByCode(m['parentCode'])
				menu.parent = parent
			}
			menu.menuOrder = menuOrder
			menuOrder++
			menu.save([flush:true])
		}
		
		SysConfig.set('initData.defaultAdminMenus.initialized', 'true')
	}
	
	public void initDefaultJobGroup(){
		def jobGroup = JobGroup.findByName(Scheduler.DEFAULT_GROUP)
		if(!jobGroup){
			new JobGroup(name:Scheduler.DEFAULT_GROUP, description:'''Default job group.
				If the number of job is small, this will be the most suitable group for those jobs.''').save()
		}
	}
}
