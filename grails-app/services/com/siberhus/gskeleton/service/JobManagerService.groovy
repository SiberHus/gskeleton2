package com.siberhus.gskeleton.service

import com.siberhus.gskeleton.job.ServiceInvokingJob
import com.siberhus.gskeleton.job.StatefulServiceInvokingJob

import org.quartz.CronTrigger
import org.quartz.Scheduler
import org.quartz.JobDetail
import org.quartz.SimpleTrigger
import org.quartz.Trigger

import com.siberhus.gskeleton.job.Job
import org.quartz.JobDataMap

class JobManagerService {
	
	static transactional = false
	
	//keep serviceName not jobName
	static Set runningJobs = Collections.synchronizedSet(new HashSet())
	
	Scheduler quartzScheduler
	
	static def isJobRunning(Job jobInstance){
		
		return runningJobs.contains(jobInstance.toFullName())
	}
	
	def addJob(Job jobInstance, boolean replace){
		JobDetail jobDetail
		if(jobInstance.concurrent){
			jobDetail = new JobDetail(jobInstance.name, jobInstance.jobGroup.name,
				ServiceInvokingJob.class)
		}else{
			jobDetail = new JobDetail(jobInstance.name, jobInstance.jobGroup.name,
				StatefulServiceInvokingJob.class)
		}
//		jobDetail.setVolatility(false)
		jobDetail.setRequestsRecovery(false)
		jobDetail.setDurability(true)
		
		jobDetail.getJobDataMap().put(ServiceInvokingJob.JOB_GROUP, jobInstance.jobGroup.name)
		jobDetail.getJobDataMap().put(ServiceInvokingJob.JOB_NAME, jobInstance.name)
		jobDetail.getJobDataMap().put(ServiceInvokingJob.SERVICE_NAME, jobInstance.serviceName)
		jobDetail.getJobDataMap().put(ServiceInvokingJob.METHOD_NAME, jobInstance.methodName)
		quartzScheduler.addJob(jobDetail, replace)
	}

	
	/**
	 * Delete the identified Job from the Scheduler - and any associated Triggers. 
	 * @param jobInstance
	 * @return true if the Job was found and deleted. 
	 */
	def removeJob(Job jobInstance){
		quartzScheduler.deleteJob(jobInstance.name, jobInstance.jobGroup.name)
	}

	def removeJob(String jobName, String groupName){
		quartzScheduler.deleteJob(jobName, groupName)
	}

	def scheduleJob(Job jobInstance){
		Trigger trigger = createTrigger(jobInstance)
		quartzScheduler.scheduleJob(trigger)
	}

	def unscheduleJob(String jobName, String groupName){
		quartzScheduler.unscheduleJob(jobName, groupName)
	}
	
	def unscheduleJob(Job jobInstance){
		quartzScheduler.unscheduleJob(jobInstance.name, jobInstance.jobGroup.name)
	}
	
	def rescheduleJob(Job jobInstance){
		Trigger trigger = quartzScheduler.getTrigger(jobInstance.name, jobInstance.jobGroup.name)
		if(trigger){
			trigger = createTrigger(jobInstance)
			quartzScheduler.rescheduleJob(jobInstance.name, jobInstance.jobGroup.name, trigger)
		}else{
			scheduleJob(jobInstance)
		}
	}
	
	def pauseJob(Job jobInstance){
		quartzScheduler.pauseJob(jobInstance.name, jobInstance.jobGroup.name)
	}
	
	def resumeJob(Job jobInstance){
		quartzScheduler.resumeJob(jobInstance.name, jobInstance.jobGroup.name)
	}

	def executeJob(Job jobInstance){
		executeJob(jobInstance, null)
	}

	def executeJob(Job jobInstance, JobDataMap jobDataMap){
		
		if(!jobInstance.isConcurrent()){
			synchronized(JobManagerService.class){
				JobManagerService.runningJobs.add(jobInstance.toFullName())
			}
		}
//		Look at the job listener, 
		try{
			if(jobDataMap){
				quartzScheduler.triggerJob(jobInstance.name, jobInstance.jobGroup.name, jobDataMap)
			}else{
				quartzScheduler.triggerJob(jobInstance.name, jobInstance.jobGroup.name)
			}
		}finally{
			if(!jobInstance.isConcurrent()){
				synchronized(JobManagerService.class){
					JobManagerService.runningJobs.remove(jobInstance.toFullName())
				}
			}
		}
	}
	
	
	def getTriggerStateName(Job jobInstance){
		int triggerState = quartzScheduler.getTriggerState(jobInstance.name, jobInstance.jobGroup.name)
		switch(triggerState){
		case Trigger.STATE_NORMAL:
			return 'NORMAL';
		case Trigger.STATE_PAUSED:
			return 'PAUSED';
		case Trigger.STATE_ERROR:
			return 'ERROR';
		case Trigger.STATE_COMPLETE:
			return 'COMPLETE';
		case Trigger.STATE_BLOCKED:
			return 'BLOCKED';
		case Trigger.STATE_NONE:
			return 'NONE';
		}
		return null
	}
	
	private Trigger createTrigger(Job jobInstance){
		Trigger trigger = null
		if(jobInstance.triggerType=='cron'){
			trigger = new CronTrigger(jobInstance.name, jobInstance.jobGroup.name, 
					jobInstance.cronExp)
		}else if(jobInstance.triggerType=='repeat'){
			long repeatInterval = jobInstance.repeatInterval
			if(jobInstance.timeUnit=='H'){
				repeatInterval *= 3600000
			}else if(jobInstance.timeUnit=='M'){
				repeatInterval *= 60000
			}else if(jobInstance.timeUnit=='S'){
				repeatInterval *= 1000
			}
			trigger = new SimpleTrigger(jobInstance.name, jobInstance.jobGroup.name, 
					jobInstance.repeatCount, repeatInterval)
		}
		if(jobInstance.startTime){
			trigger.startTime = jobInstance.startTime
		}
		if(jobInstance.endTime){
			trigger.endTime = jobInstance.endTime
		}
		trigger.setJobName(jobInstance.name)
		trigger.setJobGroup(jobInstance.jobGroup.name)
		return trigger
	}
}
