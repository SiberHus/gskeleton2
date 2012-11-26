package com.siberhus.gskeleton.service

import com.siberhus.gskeleton.job.ServiceExecutionLog
import org.apache.commons.lang.exception.ExceptionUtils

class ServiceExecutionLogService {

	boolean transactional = true

	def beginLog(ServiceExecutionLog log) {
		log.status = 'RUNNING'
		log.save()
		return log.id
	}

	def completeLog(def id, Throwable e){
		def log = ServiceExecutionLog.get(id)
		if(e){
			log.status = 'ERROR'
			log.errorMessage = ExceptionUtils.getRootCauseMessage(e)
		}else{
			log.status = 'SUCCESS'
		}
		log.save() 
	}

}
