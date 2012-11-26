
package com.siberhus.gskeleton.cfg.log4j



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import org.springframework.dao.DataIntegrityViolationException
import org.apache.log4j.Logger
import org.apache.log4j.Level
import com.siberhus.gskeleton.web.CrudMessageHelper

class Log4jConfigController {

	String VIEW_LIST = '/cfg/log4j/log4jConfig/list'
	String VIEW_CREATE = '/cfg/log4j/log4jConfig/create'
	String VIEW_EDIT = '/cfg/log4j/log4jConfig/edit'
	String VIEW_SHOW = '/cfg/log4j/log4jConfig/show'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'log4j')

	def index = {
		redirect(action: "list", params: params) 
	}
	
	def list = {
		String logImpl = log.class.name
		params.max = CrudHelper.getMaxListSize(params)
		def log4jConfigCount = Log4jConfig.count();
		render(view:VIEW_LIST,model:[instanceList: Log4jConfig.list(params), instanceTotal: log4jConfigCount, logImpl: logImpl])
	}

	def create = {
		def instance = new Log4jConfig()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		def instance = new Log4jConfig(params)
		Logger logger = Logger.getLogger(instance.name)
		logger.level = Level.toLevel(instance.level)
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = Log4jConfig.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = Log4jConfig.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = Log4jConfig.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			instance.properties = params
			if (!instance.hasErrors() && instance.save()) {
				Logger logger = Logger.getLogger(instance.name)
				logger.level = Level.toLevel(instance.level)
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}else {
				render(view: VIEW_EDIT, model: [instance: instance])
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = Log4jConfig.get(params.id)
		if (instance) {
			try {
				Logger logger = Logger.getLogger(instance.name)
				logger.level = Logger.getRootLogger().getLevel()
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
				def instance = Log4jConfig.get(id)
				if (instance) {
					try {
						Logger logger = Logger.getLogger(instance.name)
						logger.level = Logger.getRootLogger().getLevel()
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
	
}
