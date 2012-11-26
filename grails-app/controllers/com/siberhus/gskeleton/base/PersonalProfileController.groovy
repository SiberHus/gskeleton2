package com.siberhus.gskeleton.base;

import org.apache.shiro.crypto.hash.Sha1Hash
import com.siberhus.gskeleton.web.UserSessionMonitor
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.security.CredentialUtils;
import com.siberhus.gskeleton.security.PasswordUtils
import com.siberhus.gskeleton.web.CrudMessageHelper;

class PersonalProfileController {

	static String VIEW_EDIT_USER = '/base/personalProfile/editUser'
	static String VIEW_CH_PWD = '/base/personalProfile/changePassword'
	static String VIEW_LST_LOGIN_LOG = '/base/personalProfile/listLoginLog'
	static String VIEW_INDEX = '/base/personalProfile/index'
	static String VIEW_EDIT_PREF = '/base/personalProfile/editPreferences'

	def index = {
		def userInstance = getLoggedInUser()
		if(userInstance){
			render(view:VIEW_INDEX, model:[instance: userInstance])
		}
	}
	
	def editUser = {
		def userInstance = getLoggedInUser()
		if (userInstance) {
			render(view:VIEW_EDIT_USER,model:[instance: userInstance])
		}
	}
	
	def updateUser = {
		
		def userInstance = getUserInstanceForUpdate()
		if (userInstance) {
			
			userInstance.firstName = params.firstName
			userInstance.lastName = params.lastName
			userInstance.email = params.email
			userInstance.mobilePhone = params.mobilePhone
			userInstance.workPhone = params.workPhone
			userInstance.homePhone = params.homePhone
			userInstance.addressLine1 = params.addressLine1
			userInstance.addressLine2 = params.addressLine2
			userInstance.city = params.city
			userInstance.state = params.state
			userInstance.postalCode = params.postalCode
			userInstance.country = params.country
			userInstance.description = params.description
			UserController.updatePhotoImage(request, userInstance)
			if (!userInstance.hasErrors() && userInstance.save()) {
				CrudMessageHelper.setUpdatedMessage(flash, message(code:'user') , userInstance)
				redirect(action: "editUser")
			}else {
				render(view: VIEW_EDIT_USER, model: [instance: userInstance])
			}
		}
	}
	
	def changePassword = {
		def userInstance = getLoggedInUser()
		if (userInstance) {
			render(view:VIEW_CH_PWD,model:[instance: userInstance])
		}
	}
	
	def updatePassword = {
		def userInstance = getUserInstanceForUpdate()
		if (userInstance) {
			if(params.newPassword){
				if(params.newPassword!=params.newPassword2){
					MessageHelper.setErrorMessage(flash, "_error.user.passwords.notEqual",
						"Password and confirm password does not equal",null)
					render(view: VIEW_CH_PWD, model: [instance: userInstance])
					return
				}
//				userInstance.password = new Sha1Hash(params.newPassword).toHex()
				userInstance.password = CredentialUtils.encodePassword(params.newPassword)
				if(!PasswordUtils.complyWithRules(flash, params.newPassword)){
					render(view: VIEW_CH_PWD, model: [instance: userInstance])
					return
				}
				userInstance.pwdChangedDate = new Date()
			}else{
				MessageHelper.setWarningMessage(flash, "_warn.user.passwords.notChange",
					"Password was not updated due to new password is empty",null)
				render(view: VIEW_CH_PWD, model: [instance: userInstance])
				return
			}
			
			if (!userInstance.hasErrors() && userInstance.save()) {
				CrudMessageHelper.setUpdatedMessage(flash, message(code:'user') , userInstance)
				redirect(action: "changePassword")
				return
			}else {
				render(view: VIEW_CH_PWD, model: [instance: userInstance])
				return
			}
		}
		redirect(action: "index")
	}
	
	def listLoginLog = {
		def userInstance = getLoggedInUser()
		params.max = Math.min(params.max ? params.max.toInteger() : 20,  100)
		def loginLogCount = LoginLog.countByUsername(userInstance.username)
		render(view:VIEW_LST_LOGIN_LOG,model:[loginLogInstanceList: LoginLog.findAllByUsername(userInstance.username,params), loginLogInstanceTotal: loginLogCount])
	}
	
	def editPreferences = {
		
		render(view:VIEW_EDIT_PREF)
	}
	
	def getLoggedInUser(){
		def userInstance = User.findByUsername(UserSessionMonitor.get(session).username)
		if (!userInstance) {
			CrudMessageHelper.setNotFoundMessage(flash, message(code:'user'), params.id)
			redirect(action: "index")
		}
		return userInstance
	}
	
	def getUserInstanceForUpdate(){
		def userInstance
		try{
			userInstance = User.get(Long.parseLong(params.id))
		}catch(Exception e){
			return
		}
		if (userInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (userInstance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, message(code:'user'), userInstance)
					render(view: VIEW_EDIT_USER, model: [instance: userInstance])
					return
				}
			}
			return userInstance
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, message(code:'user'), params.id)
			redirect(action: "editUser")
		}
	}
	
	
}
