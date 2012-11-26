package com.siberhus.gskeleton.init

import com.siberhus.gskeleton.job.Job

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 3, 2010
 * Time: 11:37:57 AM
 * To change this template use File | Settings | File Templates.
 */
class QuartzJobInit {

	public void init(){
		//Start all persistent jobs
		def jobInstances = Job.list()
		for(Job jobInstance in jobInstances){
			jobManagerService.addJob(jobInstance, false)
			if(jobInstance.getStatus()=='A'){
				jobManagerService.scheduleJob(jobInstance)
			}
		}
//		//remove all default triggers
//		def listJobGroups = quartzScheduler.getJobGroupNames()
//		listJobGroups?.each {jobGroup ->
//			quartzScheduler.getJobNames(jobGroup)?.each {jobName ->
//				def triggers = quartzScheduler.getTriggersOfJob(jobName, jobGroup)
//				if (triggers != null && triggers.size() > 0) {
//					triggers.each {trigger ->
//						quartzScheduler.unscheduleJob(trigger.name,trigger.group)
//					}
//				}
//			}
//		}
	}
}
