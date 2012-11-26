
package com.siberhus.gskeleton.job



import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import java.util.concurrent.ConcurrentHashMap
import com.siberhus.gskeleton.config.SysConfig
import org.apache.commons.beanutils.ConvertUtils
import org.apache.shiro.SecurityUtils
import com.siberhus.gskeleton.spring.SpringApplicationContext
import com.siberhus.gskeleton.web.CrudMessageHelper

class ServiceExecutorController {

	String VIEW_LIST = '/job/serviceExecutor/list'
	String VIEW_CREATE = '/job/serviceExecutor/create'
	String VIEW_EDIT = '/job/serviceExecutor/edit'
	String VIEW_SHOW = '/job/serviceExecutor/show'
	String VIEW_EXEC = '/job/serviceExecutor/execute'
	String VIEW_WAITING = '/job/serviceExecutor/waiting'

	String SEARCH_COUNT = 'serviceExecutor.count'
	String SEARCH_QUERY_STRING = 'serviceExecutor.queryString'
	String SEARCH_QUERY_PARAMS = 'serviceExecutor.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'serviceExecutor')

	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new ServiceExecutor(), instanceTotal:0])
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def serviceExecutorCount = ServiceExecutor.count();
			session[SEARCH_COUNT] = serviceExecutorCount
			def serviceExecutorInstance = new ServiceExecutor(params)
			render(view:VIEW_LIST,model:[instanceList: ServiceExecutor.list(params), instanceTotal: serviceExecutorCount, instance: serviceExecutorInstance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new ServiceExecutor()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}
	
	def save = {
		def instance = new ServiceExecutor(params)
		
		addServiceParameters(instance)
		
		if (!instance.hasErrors() && instance.save()) {
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}
	
	def show = {
		def instance = ServiceExecutor.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = ServiceExecutor.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = ServiceExecutor.get(params.id)
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
			for(def serviceParam in ServiceParameter.findAllByServiceExecutor(instance)){
				instance.removeFromServiceParameters(serviceParam)
				serviceParam.delete()
			}
			addServiceParameters(instance)
			if (!instance.hasErrors() && instance.save()) {
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
		def instance = ServiceExecutor.get(params.id)
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
				def instance = ServiceExecutor.get(id)
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
		def queryString = 'from ServiceExecutor as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(ServiceExecutor, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
                MessageHelper.setErrorMessage(flash,e)
			}
		}
		def results = ServiceExecutor.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = ServiceExecutor.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def serviceExecutorInstance = new ServiceExecutor(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: serviceExecutorInstance])
		
	}
	
	def export = {
		if(!ServiceExecutor.metaClass.hasProperty(ServiceExecutor,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(ServiceExecutor, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}

	def prepareExecute = {
		def instance = ServiceExecutor.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_EXEC, model:[instance: instance])
		}
	}

	def execute = {
		def instance = ServiceExecutor.get(params.id)
		def pollingTime = params.pollingTime?Integer.parseInt(params.pollingTime):15
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			if(ServiceExecutionThread.isServiceRunning(instance.name) || params.pollingTime){
				//we also check pollingTime to prevent double submission in short time job
				render(view:VIEW_WAITING, model:[id:instance.id,pollingTime:pollingTime])
				return
			}
			Map parameters = [:]
			def paramType,paramValue
			try{
				if(params['paramName']){
					if(params['paramName'].class==String.class){
						paramType = params['paramType']
						paramValue = params['paramValue']
						def value = convertParameterValue(paramType, paramValue)
						parameters[params['paramName']] = value
					}else{
						for(int i=0;i<params['paramName'].size();i++){
							paramType = params['paramType'][i]
							paramValue = params['paramValue'][i]
							def value = convertParameterValue(paramType, paramValue)
							parameters[params['paramName'][i]] = value
						}
					}
				}
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash,"_error.serviceExecutor.unableToConvertParam",
					"Unable to convert parameter ${paramValue} to type ${paramType}",[paramType, paramValue])
				render(view:VIEW_EXEC, model:[instance: instance])
				return
			}

			def thread = new ServiceExecutionThread(instance.name)
			thread.setMethodInvoker(instance.serviceName, instance.methodName)
			thread.parameters = parameters
			thread.requestedBy = SecurityUtils.subject.principal.toString()
			thread.start()
			
			render(view:VIEW_WAITING, model:[id:instance.id,pollingTime:pollingTime])
		}
	}

	def wait = {
		def instance = ServiceExecutor.get(params.id)
		if(ServiceExecutionThread.isServiceRunning(instance.name)){
			def pollingTime = params.pollingTime?Integer.parseInt(params.pollingTime):15
			render(view:VIEW_WAITING, model:[id:instance.id, pollingTime: pollingTime])
			return
		}
		if(ServiceExecutionThread.ERROR_MESSAGES.get(instance.name)){
			MessageHelper.setWarningMessage(flash, '_warn.serviceExecutor.executedWithErr',
				"ServiceExecutor \"${instance.name}\" was executed with error", [instance.name])
		}else{
			MessageHelper.setInfoMessage(flash, '_info.serviceExecutor.executed',
				"ServiceExecutor \"${instance.name}\" was executed successfully", [instance.name])
		}
		render(view:VIEW_EXEC, model:[instance: instance])
	}

	def terminate = {
		def instance = ServiceExecutor.get(params.id)
		if(!instance){
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
		}else{
			def thread = ServiceExecutionThread.getInstanceByName(instance.name)
			if(thread){
				thread.interrupt()
			}else{
				MessageHelper.setWarningMessage(flash, '_warn.serviceExecutor.threadNotFound',
					"ServiceExecutor \"${instance.name}\" not found", [instance.name])
			}
		}
		redirect(action: "list")
		return
	}

	def convertParameterValue(String type, String value){
		if(!value){
			return null
		}
		if(type=='string'){
			return value
		}else if(type=='int'){
			return Integer.parseInt(value)
		}else if(type=='long'){
			return Long.parseLong(value)
		}else if(type=='float'){
			return Float.parseFloat(value)
		}else if(type=='double'){
			return Double.parseDouble(value)
		}else if(type=='boolean'){
			return Boolean.valueOf(value)
		}else if(type=='date'){
			return ConvertUtils.convert(value, java.sql.Date.class)
		}else if(type=='time'){
			return ConvertUtils.convert(value, java.sql.Time.class)
		}else if(type=='datetime'){
			return ConvertUtils.convert(value, java.sql.Timestamp.class)
		}else{
			throw new IllegalArgumentException('Unkown type: '+type)
		}
	}

	def addServiceParameters(def instance){
		if(!params['paramName']) return
		if(params['paramName'].class==String.class){
			def serviceParam = new ServiceParameter([
				name:params['paramName'],
				type:params['paramType'],
				description:params['paramDesc'],
				defaultValue:params['defaultValue']
			]);
			instance.addToServiceParameters(serviceParam)
		}else{
			for(int i=0;i<params['paramName'].size();i++){
				if(params['paramName'][i]){
					def serviceParam = new ServiceParameter([
						name:params['paramName'][i],
						type:params['paramType'][i],
						description:params['paramDesc'][i],
						defaultValue:params['defaultValue'][i]
					]);
					instance.addToServiceParameters(serviceParam)
				}
			}
		}
	}
}
