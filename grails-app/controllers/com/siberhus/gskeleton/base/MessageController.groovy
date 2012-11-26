package com.siberhus.gskeleton.base;

import grails.converters.JSON
import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudMessageHelper;

class MessageController {

	String VIEW_LIST = '/base/message/list'
	String VIEW_CREATE = '/base/message/create'
	String VIEW_EDIT = '/base/message/edit'
	String VIEW_SHOW = '/base/message/show'
	
	//auto wired
	def messageSource
	
	String SEARCH_COUNT = 'message.count'
	String SEARCH_QUERY_STRING = 'message.queryString'
	String SEARCH_QUERY_PARAMS = 'message.queryParams'

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'message')
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new Message(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def messageCount = Message.count();
			session[SEARCH_COUNT] = messageCount
			def instance = new Message(params)
			render(view:VIEW_LIST, model:[instanceList: Message.list(params), instanceTotal: messageCount, instance: instance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new Message()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		def instance = new Message(params)
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}
		else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = Message.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = Message.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = Message.get(params.id)
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
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}
			else {
				render(view: VIEW_EDIT, model: [instance: instance])
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = Message.get(params.id)
		if (instance) {
			try {
				instance.delete()
				CrudHelper.decrementResultCount(session, SEARCH_COUNT)
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
				def instance = Message.get(id)
				if (instance) {
					try {
						instance.delete()
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
		def queryString = 'from Message as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(Message, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.printException(flash, e)
			}
		}
		def results = Message.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = Message.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new Message(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!Message.metaClass.hasProperty(Message,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(Message, response, params,
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
	
	def ajaxSetMessage = {
			def instance = Message.findByLanguageAndCode(params.language, params.code)
			if(instance){
				instance.text = params.text
			}else{
				instance = new Message(params)
			}
			if(instance.save()){
				def locale = new Locale(instance.language, request.locale.country)
				if(params.hasArgs=="true"){
					messageSource.setMessage(instance.code, locale, instance.text)
				}else{
					messageSource.setMessageWithoutArguments(instance.code, locale, instance.text)
				}
				render 'ok'
			}else{
				render 'error'
			}
		}
		
	def jsonGetMessage = {
		def instance = Message.findByLanguageAndCode(params.language, params.code)
		if(instance){
			render instance as JSON
		}
		render {}
	}
	
}
