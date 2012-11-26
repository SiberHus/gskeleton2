package com.siberhus.gskeleton.base

import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudMessageHelper

class LoginFailureLogController {

	String VIEW_LIST = '/base/loginFailureLog/list'
	String VIEW_CREATE = '/base/loginFailureLog/create'
	String VIEW_EDIT = '/base/loginFailureLog/edit'
	String VIEW_SHOW = '/base/loginFailureLog/show'
	
	String SEARCH_COUNT = 'loginFailureLog.count'
	String SEARCH_QUERY_STRING = 'loginFailureLog.queryString'
	String SEARCH_QUERY_PARAMS = 'loginFailureLog.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}

	String modelName = message(code:'loginFailure')

	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new LoginFailureLog(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def loginFailureLogCount = LoginFailureLog.count();
			session[SEARCH_COUNT] = loginFailureLogCount
			def instance = new LoginFailureLog(params)
			render(view:VIEW_LIST,model:[instanceList: LoginFailureLog.list(params), instanceTotal: loginFailureLogCount, instance: instance])
		}
	}
	
	def show = {
		def instance = LoginFailureLog.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}
		else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def delete = {
		def instance = LoginFailureLog.get(params.id)
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
				def instance = LoginFailureLog.get(id)
				if (instance) {
					try {
						instance.delete()
						CrudHelper.decrementResultCount(session, SEARCH_COUNT)
					}catch (org.springframework.dao.DataIntegrityViolationException e) {
						CrudMessageHelper.setNotDeletedMessage(flash, modelName , instance)
						break
					}
				}else {
					CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
					break
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
		def queryString = 'from LoginFailureLog as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			def queryBean
			try{
				queryBean = CrudHelper.parseFindCondition(LoginFailureLog, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}
		def results = LoginFailureLog.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = LoginFailureLog.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new LoginFailureLog(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!LoginFailureLog.metaClass.hasProperty(LoginFailureLog,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(LoginFailureLog, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
}
