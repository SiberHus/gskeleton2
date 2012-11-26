package com.siberhus.gskeleton.job

import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import com.siberhus.gskeleton.web.CrudMessageHelper;

class JobLogController {

	String VIEW_LIST = '/job/jobLog/list'
	String VIEW_CREATE = '/job/jobLog/create'
	String VIEW_EDIT = '/job/jobLog/edit'
	String VIEW_SHOW = '/job/jobLog/show'

	String SEARCH_COUNT = 'jobLog.count'
	String SEARCH_QUERY_STRING = 'jobLog.queryString'
	String SEARCH_QUERY_PARAMS = 'jobLog.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'jobLog')
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new JobLog(), instanceTotal:0])
	}
	
	def findByJob = {
		def instance = new JobLog()
		if(params.jobName){
			params.max = CrudHelper.getMaxListSize(params)
			def results = JobLog.findAllByJobName(params.jobName, 
					[sort:'createdDate', order:'desc', max:params.max])
			def resultCount = JobLog.countByJobName(params.jobName)
			instance.jobName = params.jobName
			render(view:VIEW_LIST, model:[instanceList:results, instanceTotal:resultCount,instance: instance])
		}else{
			render(view:VIEW_LIST, model:[instanceList:[], instanceTotal:0,instance: instance])
		}
	}
	
	def list = {
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def jobLogCount = JobLog.count();
			session[SEARCH_COUNT] = jobLogCount
			def instance = new JobLog(params)
			render(view:VIEW_LIST,model:[instanceList: JobLog.list(params), instanceTotal: jobLogCount, instance: instance])
		}
	}

	def show = {
		def instance = JobLog.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def delete = {
		def instance = JobLog.get(params.id)
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
				def instance = JobLog.get(id)
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
			CrudMessageHelper.setDeletedMessage(flash, modelName , instance)
		}
		params.remove('ids')
		params.remove('_ids')
		redirect(action: "list", params:params)
	}
	
	def search = {
		params.max = CrudHelper.getMaxListSize(params)
		params.offset = CrudHelper.getResultOffset(params)
		def queryString = 'from JobLog as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
//			if(params.parent?.id){
//				condString += 'and d.parent.id = ? '
//				queryParams << params.parent.id?.toLong()
//			}
//			if(params.name){
//				condString += 'and lower(d.name) like lower(?) '
//				queryParams << params.name
//			}
			try{
				def queryBean = CrudHelper.parseFindCondition(JobLog, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
			}

		}
		def results = JobLog.findAll(queryString,queryParams,paginate)
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = JobLog.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new JobLog(params)
		render(view:VIEW_LIST,model:[instanceList:results,instanceTotal:resultsCount, instance: instance])
		
	}
	
	def export = {
		if(!JobLog.metaClass.hasProperty(JobLog,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(JobLog, response, params,
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}
}
