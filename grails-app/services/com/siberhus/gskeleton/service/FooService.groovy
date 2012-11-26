package com.siberhus.gskeleton.service;

import org.quartz.JobExecutionContext;
import org.springframework.util.ClassUtils
import com.siberhus.gskeleton.job.Job
import com.siberhus.gskeleton.job.ServiceExecutionLog;

class FooService {
	

	public void transactionalJob(){
		def log = new ServiceExecutionLog()
		log.serviceExecutorName = 'test'
//		if(parameters) log.serviceParameters = parameters.toString()
		log.requestedBy = 'test'
		log.status = 'RUNNING'
		log.save()
	}

	public void printParameters(Map params){
		params.each{ k,v->
			println "$k (${v.class})=> $v"
		}
	}

	public void executeDatabaseJob(){
		def jobs = Job.findAll()
		log.debug('Hello')
		println "All jobs: $jobs"
	}
	
	public void executeLongRunningJob(){
		/* sleep 20 seconds */
		for(def i in 1..10){
			Thread.sleep 2000
			println "Foo executing task no. $i"
		}
		println "============= Finish processing FooJob ==========="
	}

	public void executeVeryLongRunningJob(){
		/* sleep 20 seconds */
		for(def i in 1..100){
			if(Thread.currentThread().isInterrupted()){
				println "Job executeVeryLongRunningJob is interrupted"
				break
			}
			Thread.sleep 2000
			println "Foo executing task no. $i"
		}
		println "============= Finish processing FooJob ==========="
	}

	public void executeErrorJob(){
		println 'error'
		throw new RuntimeException("Trivial exception")
	}
	
	public void executeContextAwareJob(JobExecutionContext context){
		println "Context $context"
	}
	
}
