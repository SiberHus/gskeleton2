
package com.siberhus.gskeleton.cfg.log4j



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper

import com.siberhus.gskeleton.util.Log4jAppenderFactory

import org.apache.log4j.Appender
import org.apache.log4j.Logger
import com.siberhus.gskeleton.web.CrudMessageHelper

class Log4jAppenderController {

	String VIEW_LIST = '/cfg/log4j/log4jAppender/list'
	String VIEW_CREATE = '/cfg/log4j/log4jAppender/create'
	String VIEW_EDIT = '/cfg/log4j/log4jAppender/edit'
	String VIEW_SHOW = '/cfg/log4j/log4jAppender/show'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'log4jAppender')
	
	def index = {
		redirect(action: "list", params: params) 
	}
	
	def list = {
		params.max = CrudHelper.getMaxListSize(params)
		def log4jAppenderCount = Log4jAppender.count();
		render(view:VIEW_LIST,model:[instanceList: Log4jAppender.list(params), instanceTotal: log4jAppenderCount])
	}

	def create = {
		def instance = new Log4jAppender()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		Map props = extractAppenderProperties(params)
		def instance = new Log4jAppender(params)
		instance.props = props
		try{
			updateAppender(props)
			if (!instance.hasErrors() && instance.save()) {
				CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		render(view: VIEW_CREATE, model: [instance: instance])
	}
	
	def show = {
		def instance = Log4jAppender.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = Log4jAppender.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = Log4jAppender.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			Map props = extractAppenderProperties(params)
			instance.properties = params
			try{
				updateAppender(props)
				if (!instance.hasErrors() && instance.save()) {
					CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
					redirect(action: "show", id: instance.id)
				}
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
			render(view: VIEW_EDIT, model: [instance: instance])
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = Log4jAppender.get(params.id)
		if (instance) {
			try {
				Logger.getRootLogger().removeAppender(instance.name)
				instance.delete()
				CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
				redirect(action: "list")
			}catch (org.springframework.dao.DataIntegrityViolationException e) {
				CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
				redirect(action: "show", id: params.id)
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
	}
	
	def bulkDelete = {
		
		if(params.ids){
			if(params.ids instanceof String) params.ids = [params.ids]
			for(id in params.ids){
				def instance = Log4jAppender.get(id)
				if (instance) {
					try {
						Logger.getRootLogger().removeAppender(instance.name)
						instance.delete()
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

	void updateAppender(def props){
		String name = params.name
		Appender appender = Logger.getRootLogger().getAppender(name)
		if(appender==null){
			appender = Log4jAppenderFactory.create(params.type, name,
				params.threshold, params.pattern, props)
			Logger.getRootLogger().addAppender(appender)
		}else{
			Log4jAppenderFactory.update(appender, params.threshold, params.pattern, props)
		}
	}

	Map extractAppenderProperties(def params){
		Map props = [:]
		if(params.type in [Log4jAppenderFactory.FILE,Log4jAppenderFactory.ROLLING_FILE,Log4jAppenderFactory.DAILY_ROLLING_FILE]){
			props.file = params.remove('file.file')
			props.encoding = params.remove('file.encoding')
			props.append = params.remove('file.append')
			props.bufferedIO = params.remove('file.bufferedIO')
			props.bufferSize = params.remove('file.bufferSize')
			props.immediateFlush = params.remove('file.immediateFlush')
			if(params.type==Log4jAppenderFactory.ROLLING_FILE){
				props.maxFileSize = params.remove('file.maxFileSize')
				props.maxBackupIndex = params.remove('file.maxBackupIndex')
			}else if(params.type==Log4jAppenderFactory.DAILY_ROLLING_FILE){
				props.datePattern = params.remove('file.datePattern')
				props.periodicity = params.remove('file.periodicity')
			}
		}else if(params.type==Log4jAppenderFactory.SMTP){
			props.smtpHost = params.remove('smtp.smtpHost')
			props.smtpUsername = params.remove('smtp.smtpUsername')
			props.smtpPassword = params.remove('smtp.smtpPassword')
			props.bufferSize = params.remove('smtp.bufferSize')
			props.smtpDebug = params.remove('smtp.smtpDebug')
			props.locationInfo = params.remove('smtp.locationInfo')
			props.from = params.remove('smtp.from')
			props.to = params.remove('smtp.to')
			props.cc = params.remove('smtp.cc')
			props.bcc = params.remove('smtp.bcc')
			props.subject = params.remove('smtp.subject')
		}
		return props
	}
}
