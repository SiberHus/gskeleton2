package com.siberhus.gskeleton.job;

import org.quartz.Scheduler;
import com.siberhus.gskeleton.util.State
import com.siberhus.gskeleton.service.JobManagerService
import com.siberhus.gskeleton.web.MessageHelper
import com.siberhus.gskeleton.web.CrudHelper
import org.quartz.CronExpression
import com.siberhus.gskeleton.config.SysConfig
import org.apache.commons.lang.time.FastDateFormat
import org.apache.commons.lang.time.DateFormatUtils
import com.siberhus.gskeleton.web.CrudMessageHelper;

class JobSchedulerController {

	String VIEW_LIST = '/job/jobScheduler/list'
	String VIEW_CREATE = '/job/jobScheduler/create'
	String VIEW_EDIT = '/job/jobScheduler/edit'
	String VIEW_SHOW = '/job/jobScheduler/show'

	String SEARCH_COUNT = 'job.count'
	String SEARCH_QUERY_STRING = 'job.queryString'
	String SEARCH_QUERY_PARAMS = 'job.queryParams'
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"];

	String modelName = message(code:'job')

	Scheduler quartzScheduler
	JobManagerService jobManagerService
	
	private void clearPageSession(){
		session.removeAttribute(SEARCH_COUNT)
		session.removeAttribute(SEARCH_QUERY_STRING)
		session.removeAttribute(SEARCH_QUERY_PARAMS)
	}
	
	def index = {
		clearPageSession()
		render(view:VIEW_LIST, model:[instance:new Job(), instanceTotal:0])
	}
    
    def list = {
		if(quartzScheduler.isInStandbyMode()){
			State.set('scheduler.state', 'standby')
		}else if(quartzScheduler.isStarted()){
			State.set('scheduler.state', 'started')
		}else{
			State.set('scheduler.state', 'shutdown')
		}
		if(session[SEARCH_QUERY_STRING]){
			params.retainCondition = true
			forward(action:'search',params:params)
		}else{
			params.max = CrudHelper.getMaxListSize(params)
			def jobCount = Job.count();
			session[SEARCH_COUNT] = jobCount
			def instance = new Job(params)
			def instanceList = updateFireTime(Job.list(params))
			render(view:VIEW_LIST,model:[instanceList: instanceList, instanceTotal: jobCount, instance: instance])
		}
	}

	def create = {
		clearPageSession()
		def instance = new Job()
		instance.properties = params
		render(view:VIEW_CREATE,model:[instance: instance])
	}

	def save = {
		def instance = new Job(params)
		if (!instance.hasErrors() && instance.save()) {
			
			jobManagerService.addJob(instance, true)
			if(instance.status=='A'){
				jobManagerService.scheduleJob(instance)
			}
			CrudMessageHelper.setCreatedMessage(flash, modelName , instance)
			redirect(action: "show", id: instance.id)
		}else {
			render(view: VIEW_CREATE, model: [instance: instance])
		}
	}

	def show = {
		def instance = Job.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
			redirect(action: "list")
		}else {
			render(view:VIEW_SHOW,model:[instance: instance])
		}
	}

	def edit = {
		def instance = Job.get(params.id)
		if (!instance) {
			CrudMessageHelper.setNotFoundMessage(flash, modelName, params.id)
            redirect(action: "list")
		}else {
			render(view:VIEW_EDIT,model:[instance: instance])
		}
	}

	def update = {
		def instance = Job.get(params.id)
		if (instance) {
			if (params.version) {
				def version = params.version.toLong()
				if (instance.version > version) {
					CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
					render(view: VIEW_EDIT, model: [instance: instance])
					return
				}
			}
			boolean replaceJob = false
			String oldJobName, oldGroupName
			if(instance.name!=params.name 
					|| instance.serviceName!=params.serviceName
					|| instance.methodName!=params.methodName){
				replaceJob = true
				oldJobName = instance.name
				oldGroupName = instance.jobGroup.name
			}
			instance.properties = params
			if (!instance.hasErrors() && instance.save()) {
				if(replaceJob){
					jobManagerService.removeJob(oldJobName, oldGroupName)
					jobManagerService.addJob(instance, true)
					jobManagerService.scheduleJob(instance)
				}else{
					if(instance.status=='A'){
						jobManagerService.rescheduleJob(instance)
					}else{
						jobManagerService.unscheduleJob(instance)
					}
				}
				CrudMessageHelper.setUpdatedMessage(flash, modelName , instance)
				redirect(action: "show", id: instance.id)
			}else {
				render(view: VIEW_EDIT, model: [instance: instance])
            }
		}else {
			CrudMessageHelper.setOldVersionUpdateMessage(flash, modelName, instance)
			redirect(action: "edit", id: params.id)
		}
	}

	def delete = {
		def instance = Job.get(params.id)
		if (instance) {
			try {
				jobManagerService.unscheduleJob(instance)
				jobManagerService.removeJob(instance)
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
				def instance = Job.get(id)
				if (instance) {
					try {
						jobManagerService.unscheduleJob(instance)
						jobManagerService.removeJob(instance)
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
		def queryString = 'from Job as d where 1=1 '
		def queryParams = []
		def paginate = [max:params.max,offset:params.offset]
		if(params.retainCondition){
			queryString = session[SEARCH_QUERY_STRING]
			queryParams = session[SEARCH_QUERY_PARAMS]
		}else{
			try{
				def queryBean = CrudHelper.parseFindCondition(Job, params)
				queryString += queryBean.queryString
				queryParams += queryBean.queryParams
				log.debug "queryString= $queryString"
				log.debug "queryParams= $queryParams"
			}catch(Exception e){
				MessageHelper.setErrorMessage(flash, e)
				render(view:'list',model:[instance: new Job(params)])
			}
		}
		def instanceList = updateFireTime(Job.findAll(queryString,queryParams,paginate))
		def resultsCount
		if(session[SEARCH_QUERY_PARAMS] != queryParams){
			resultsCount = Job.executeQuery('select count(*) '+queryString,queryParams)[0]
			session[SEARCH_COUNT] = resultsCount
			session[SEARCH_QUERY_STRING] = queryString
			session[SEARCH_QUERY_PARAMS] = queryParams
		}else{
			resultsCount = session[SEARCH_COUNT]
		}
		def instance = new Job(params)
		render(view:VIEW_LIST,model:[instanceList:instanceList,instanceTotal:resultsCount, instance: instance])
	}
	
	def export = {
		if(!Job.metaClass.hasProperty(Job,'exportFields')){
			forward(action:'search',params:params)
			return;
		}
		if(session[SEARCH_QUERY_STRING]){
			def writer = CrudHelper.exportDataToWriterStream(Job, response, params, 
					[subResultSize:100,fullListSize:session[SEARCH_COUNT],
					 queryString:session[SEARCH_QUERY_STRING],queryParams:session[SEARCH_QUERY_PARAMS]])
			writer.flush()
			return writer
		}
		redirect(action: "search", params: params)
	}

	def execute = {
		def instance = Job.get(params.id)
		if (!instance) {
			MessageHelper.setErrorMessage(flash, "_error.job.not.found",
					"Job not found with id ${params.id}",[params.id])
		}
//		else if(instance.status=='A'){
//			flash.message = "job.manualExec.notAllowed"
//			flash.args = [instance.name]
//			flash.defaultMessage = "Manual execution is not allowed for active job ${instance.name}"
		else{
			if(!instance.concurrent && JobManagerService.isJobRunning(instance)){
				flash.message = "job.concurrent.notAllowed"
				flash.args = [instance.name]
				flash.defaultMessage = "Concurrent execution is not allowed for job ${instance.name}"
			}else{
				try{
					jobManagerService.executeJob(instance)
				}catch(Exception e){
					flash.message = "_error.job.executionFailed"
					flash.args = [e.message]
					flash.defaultMessage = e.toString()
				}
			}
		}
		redirect(action: "list")
	}
	
	def togglePause = {
		def instance = Job.get(params.id)
		if (!instance) {
			MessageHelper.setErrorMessage(flash, "_error.job.not.found",
					"Job not found with id ${params.id}",[params.id])
		}else{
			if(instance.status=='I'){
				MessageHelper.setErrorMessage(flash, "_error.job.not.active",
					"Inactive job id ${params.id} can not be pause/unpause",[params.id])
			}else{
				String triggerStateName = jobManagerService.getTriggerStateName(instance)
				if(triggerStateName=='NORMAL'){
					jobManagerService.pauseJob(instance)
				}else if(triggerStateName=='PAUSED'){
					jobManagerService.resumeJob(instance)
				}else{
					MessageHelper.setErrorMessage(flash, "_error.job.invalidState",
						"Job id ${params.id} cannot be paused/unpaused because current state is ${triggerStateName}",[params.id, triggerStateName])
				}
			}
		}
		redirect(action: "list")
	}
	
	def standbyScheduler = {
		try{
			quartzScheduler.standby()
			State.set('scheduler.state', 'standby')
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action: "list")
	}
	
	def restartScheduler = {
		try{
			quartzScheduler.start()
			State.set('scheduler.state', 'started')
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action: "list")
	}
	
	def pauseAllTriggers = {
		try{
			quartzScheduler.pauseAll()
			State.set('scheduler.allTriggers.state', 'paused')
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action: "list")
	}
	
	def resumeAllTriggers = {
		try{
			quartzScheduler.resumeAll()
			State.set('scheduler.allTriggers.state', 'normal')
		}catch(Exception e){
			MessageHelper.setErrorMessage(flash, e)
		}
		redirect(action: "list")
	}
	
	def updateFireTime(def instanceList){
		for(def instance in instanceList){
			def triggers = quartzScheduler.getTriggersOfJob(instance.name, 
					Scheduler.DEFAULT_GROUP)
			if (triggers != null && triggers.size() > 0) {
				triggers.each {trigger ->
					instance.triggerState = jobManagerService.getTriggerStateName(instance)
					instance.nextFireTime = trigger.nextFireTime
					instance.previousFireTime = trigger.previousFireTime
				}
			}
		}
		return instanceList
	}

	def jsonParseCronExpression = {
//		println params.cronExp
//		def result = CronExpression.isValidExpression(params.cronExp)
//		if(result==false){
//			render(text:"{\"success\":false,\"message\":\"Invalid cron expression\"}")
//			return
//		}
		try{
			def cronExp = new CronExpression(params.cronExp)
			def fireTime = cronExp.getNextValidTimeAfter(new Date())
			def datetimePattern = SysConfig.get('converter.datetimePattern')
			def fireTimeStr = DateFormatUtils.format(fireTime, datetimePattern)
			render(text:"{\"success\":true,\"message\":\"${fireTimeStr}\"}")
		}catch(Exception e){
			render(text:"{\"success\":false,\"message\":\"${e.message}\"}")
		}
	}
}
