package com.siberhus.gskeleton.cfg

import com.siberhus.gskeleton.config.SysConfig

class CustomConfigController {

    def editTheme = {
		render(view:'/cfg/customConfig/theme')
	}

	def updateTheme = {
		SysConfig.set('webUi.theme', params.theme)
		render(view:'/cfg/customConfig/theme')
	}

	def editSecurity = {
		render(view:'/cfg/customConfig/security')
	}

	def updateSecurity = {
		//IPv4 Filter
		SysConfig.set('security.ipv4Filter', params['ipv4Filter']?'true':'false')
		SysConfig.set('security.ipv4Filter.localhost', params['ipv4Filter.localhost']?'true':'false')
		SysConfig.set('security.ipv4Filter.definedOnly', params['ipv4Filter.definedOnly']?'true':'false')
		//Authentication
		SysConfig.set('security.authc.rememberMe', params['authc.rememberMe']?'true':'false')
		SysConfig.set('security.authc.defaultSuccessView', params['authc.defaultSuccessView'])
		SysConfig.set('security.authc.multiSessionLogin', params['authc.multiSessionLogin']?'true':'false')
		SysConfig.set('security.authc.multiAddressLogin', params['authc.multiAddressLogin']?'true':'false')
		SysConfig.set('security.authc.maxLoginFailures', params['authc.maxLoginFailures'])
		SysConfig.set('security.authc.disableTimeInterval', params['authc.disableTimeInterval'])

		//Password Policy
		SysConfig.set('security.password.minLength', params['password.minLength'])
		SysConfig.set('security.password.maxLength', params['password.maxLength'])
		SysConfig.set('security.password.rule', params['password.rule'])
		SysConfig.set('security.password.ruleRegex', params['password.ruleRegex'])

		//Logs
		SysConfig.set('security.log.login', params['log.login']?'true':'false')
		SysConfig.set('security.log.loginFailure', params['log.loginFailure']?'true':'false')

		render(view:'/cfg/customConfig/security')
	}
}
