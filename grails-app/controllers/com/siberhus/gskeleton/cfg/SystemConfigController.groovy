package com.siberhus.gskeleton.cfg;

import com.siberhus.gskeleton.config.ConfigurationException;
import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.cfg.SystemConfig
import com.siberhus.gskeleton.web.CrudMessageHelper;

class SystemConfigController {

	String VIEW_LIST = '/cfg/systemConfig/list'
	String VIEW_CREATE = '/cfg/systemConfig/create'
	String VIEW_EDIT = '/cfg/systemConfig/edit'
	String VIEW_SHOW = '/cfg/systemConfig/show'

	String SEARCH_COUNT = 'systemConfig.count'
	String SEARCH_QUERY_STRING = 'systemConfig.queryString'
	String SEARCH_QUERY_PARAMS = 'systemConfig.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'systemConfig')
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new SystemConfig(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def systemConfigCount = SystemConfig.count();
			session[SEARCH_COUNT] = systemConfigCount
			def instance = new SystemConfig(params)
			if(!params.type){
				instance.type = null
			}
			render(view:VIEW_LIST,model:[instanceList: SystemConfig.list(params), instanceTotal: systemConfigCount, instance: instance])
		}
	}
	
	def show = {
		def instance = SystemConfig.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = SystemConfig.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}
	
	def update = {
		def instance = SystemConfig.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			int idx = params.name.indexOf('.')
			String systemName = params.name.substring(0, idx)
			String configName = params.name.substring(idx+1)
			try{
				SysConfig.set(systemName, configName, params.value)
				if(instance.needRestart){
					MessageHelper.setWarningMessage(flash, "_warn.systemConfig.updated.needRestart",
						"System Configuration ${params.name} updated.<br/>You need to reboot system for the changes to take effect.",[params.name])
				}else{
					CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				}
				redirect(action: "show", id: instance.id)
			}catch(ConfigurationException e){
				render(view: VIEW_EDIT, model: [instance: e.getConfigDomain()])
			}
		}else {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "edit", id: params.id)
		}
	}
	
	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from SystemConfig as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(SystemConfig, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}
		}
		def results = SystemConfig.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = SystemConfig.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new SystemConfig(params)
		if(!params.type){
			instance.type = null
		}
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!SystemConfig.metaClass.hasProperty(SystemConfig,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(SystemConfig, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
}
