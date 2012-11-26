package com.siberhus.gskeleton.base;


import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.springframework.web.multipart.MultipartFile;
import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.security.CredentialUtils;
import com.siberhus.gskeleton.security.PasswordUtils
import org.grails.plugins.imagetools.ImageTool
import com.siberhus.gskeleton.util.WebResourceUtils
import com.siberhus.gskeleton.web.CrudMessageHelper;

class UserController {

	String VIEW_LIST = '/base/user/list'
	String VIEW_CREATE = '/base/user/create'
	String VIEW_EDIT = '/base/user/edit'
	String VIEW_SHOW = '/base/user/show'
	
	String SEARCH_COUNT = 'user.count'
	String SEARCH_QUERY_STRING = 'user.queryString'
	String SEARCH_QUERY_PARAMS = 'user.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'user')
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}

	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new User(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def userCount = User.count();
			session[SEARCH_COUNT] = userCount
			def instance = new User(params)
			render(view:VIEW_LIST,model:[instanceList: User.list(params), instanceTotal: userCount, instance: instance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new User()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}

	def save = {
		def instance = new User(params)
		if(params.password){
//			instance.password = new Sha1Hash(params.password).toHex()
			instance.password = CredentialUtils.encodePassword(params.password)
			if(!PasswordUtils.complyWithRules(flash, params.password)){
				render(view: VIEW_CREATE, model: [instance: instance])
				return
			}
			instance.pwdChangedDate = new Date()
		}	 
		updatePhotoImage(request, instance)
		PermissionController.updateObjectPermissions(instance, params)
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}
		else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = User.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = User.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_EDIT, model:[instance: instance])
		}
	}
	
	def update = {
		def instance = User.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			updatePhotoImage(request, instance)
			instance.properties = params
			PermissionController.updateObjectPermissions(instance, params)
			if(params.newPassword){
				if(params.newPassword!=params.newPassword2){
					flash.message = "user.passwords.notMatch"
					MessageHelper.setErrorMessage(flash, "_error.user.passwords.notEquals",
					"Password and Repeat Password must be equals",null)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
//				instance.password = new Sha1Hash(params.newPassword).toHex()
				instance.password = CredentialUtils.encodePassword(params.newPassword)
				if(!PasswordUtils.complyWithRules(flash, params.newPassword)){
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
				instance.pwdChangedDate = new Date()
			}
			if (!instance.hasErrors() && instance.save()) {
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}
			else {
				render(view: VIEW_EDIT, model: [instance: instance])
			}
		}
		else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = User.get(params.id)
		if (instance) {
			try {
//				instance.delete()
				instance.status = 'D'
				CrudHelper.decrementResultCount(session, SEARCH_COUNT)
				CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
				redirect(action: "list")
			}catch (org.springframework.dao.DataIntegrityViolationException e) {
				CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
				redirect(action: "show", id: params.id)
			}
		}
		else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
	}
	
	def bulkDelete = {
		
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			for(id in params.ids){
				def instance = User.get(id)
				if (instance) {
					try {
//						instance.delete()
						instance.status = 'D'
						CrudHelper.decrementResultCount(session, SEARCH_COUNT)
					}catch (org.springframework.dao.DataIntegrityViolationException e) {
						CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
						redirect(action: "list", id: params.id)
						return
					}
				}else {
					CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
					redirect(action: "list")
					return
				}
			}
			CrudMessageHelper.setBulkDeletedMessage(flash, modelName , params.ids)
		}
		params.remove('ids')
		params.remove('_ids')
		redirect(action: "list", params:params)
	}

	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from User as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(User, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}
		def results = User.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = User.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new User(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!User.metaClass.hasProperty(User,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(User, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
	
	def unlock = {
		
		def instance = User.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: "edit", model: [instance: instance])
					return
				}
			}
			if(instance.status=='S'){
				def lf = LoginFailure.findByUsername(instance.username)
				if(lf){
					lf.failCount = 0
					lf.suspendedDate = null
					lf.save()
				}
			}else if(instance.status=='E'){
				def expiryDate = null
				if(params.expiryDate){
					try{
						expiryDate = new java.sql.Date(new SimpleDateFormat(SysConfig.get('converter.datePattern'))
							.parse(params.expiryDate).time)
//						expiryDate = ConvertUtils.convert(params.expiryDate, java.sql.Date.class)
						if(expiryDate <= new java.sql.Date(new Date().time)){
							MessageHelper.setErrorMessage(flash,  "_error.user.expiryDateMustBeFuture",
								"Expiry date ${expiryDate} must be a future date",[params.expiryDate])
							redirect(action: "edit", id: params.id)
							return
						}
					}catch(ParseException e){
						MessageHelper.setErrorMessage(flash, "_error.user.unableToParseDate",
							"Unable to parse date for expiryDate using format:${CH.config.gskeleton.datePattern}",[params.expiryDate,SysConfig.get('converter.datePattern')])
						redirect(action: "edit", id: params.id)
						return
					}
				}
				instance.expiryDate = expiryDate
			}
			MessageHelper.setInfoMessage(flash, "_info.user.unlock.success",
					"User id ${params.id} was unlocked",[params.id])
			instance.status = 'A'
			instance.save()
			
			redirect(action: "show", id: instance.id)
		}else{
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
		
	}
	
	static def updatePhotoImage(def request, User instance){
		MultipartFile multipartFile = request.getFile('photoImg')
		if(!multipartFile.isEmpty()){
//			def ext = FilenameUtils.getExtension(multipartFile.originalFilename)
			File imageFile = WebResourceUtils.getUserResourceFile(instance.username+'.jpg')
			multipartFile.transferTo(imageFile)
			ImageTool imageTool = new ImageTool()
			imageTool.load(imageFile.canonicalPath)
			imageTool.thumbnailSpecial(150,180,1,1)
			imageTool.writeResult(imageFile.canonicalPath, "JPEG")
			instance.photoImgPath = imageFile.canonicalPath
		}
	}
}
