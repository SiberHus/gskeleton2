package com.siberhus.gskeleton.job;

import java.lang.reflect.Method;
import java.util.concurrent.ConcurrentHashMap;
import grails.util.GrailsUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.quartz.Job;
import org.quartz.JobDataMap 
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.siberhus.gskeleton.job.JobLog;
import com.siberhus.gskeleton.service.JobManagerService;
import com.siberhus.gskeleton.spring.SpringApplicationContext
import com.siberhus.gskeleton.config.SysConfig;

class ServiceInvokingJob implements Job {

	public static final String JOB_GROUP = 'jobGroup'
	public static final String JOB_NAME = 'jobName'

	public static final String SERVICE_NAME = 'serviceName'
	public static final String METHOD_NAME = 'methodName'
	
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		
		JobDataMap jdm = context.getJobDetail().getJobDataMap()
		String jobName = jdm.get(JOB_NAME)
		String jobGroup = jdm.get(JOB_GROUP)
		String jobFullName = jobGroup+'.'+jobName
		String serviceName = jdm.get(SERVICE_NAME)
		String methodName = jdm.get(METHOD_NAME)
		
		JobLog jobLog
		if(SysConfig.get('jobScheduler.jobLog')){
			jobLog = new JobLog([jobGroup:jobGroup,jobName:jobName,status:'RUNNING'])
			jobLog.save(flush:true)
		}
		synchronized(JobManagerService.class){
			JobManagerService.runningJobs.add(jobFullName)
		}
		JobMethodInvoker methodInvoker = JobMethodInvoker.getMethodInvoker(serviceName, methodName)
		Throwable e = methodInvoker.invoke(context)
		if(SysConfig.get('jobScheduler.jobLog')){
			if(e==null){
				jobLog.status = 'SUCCESS'
				jobLog.save(flush:true)
			}else{
				jobLog.status = 'ERROR'
				jobLog.message = StringUtils.abbreviate(ExceptionUtils.getFullStackTrace(e),4000);
				jobLog.save(flush:true)
			}
		}
		
		synchronized(JobManagerService.class){
			JobManagerService.runningJobs.remove(jobFullName)
		}
		
	}
	
	public static boolean hasJobExecutionMethod(String serviceName){
		return JobMethodInvoker.getMethodInvoker(serviceName)!=null
	}
	
}
