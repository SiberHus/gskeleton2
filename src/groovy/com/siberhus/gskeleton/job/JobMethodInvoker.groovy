package com.siberhus.gskeleton.job;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.quartz.JobExecutionContext;

import com.siberhus.gskeleton.job.JobLog;
import com.siberhus.gskeleton.spring.SpringApplicationContext 
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method
import grails.util.GrailsUtil
import java.util.concurrent.ConcurrentHashMap;

class JobMethodInvoker {

	private static final Map JOB_METHOD_CACHE = new ConcurrentHashMap()
	
	String serviceName
	Method method
	boolean hasParam
	
	public Throwable invoke(JobExecutionContext context){
		
		Object serviceBean = SpringApplicationContext.getBean(serviceName)
		try{
			if(hasParam){
				method.invoke(serviceBean, [context] as Object[])
			}else{
				method.invoke(serviceBean)
			}
			return null
		}catch(InvocationTargetException e){
			return e.targetException
		}
	}

	public static JobMethodInvoker getMethodInvoker(String serviceName, String methodName) {

		String invokerKey = serviceName+'.'+methodName
		JobMethodInvoker methodInvoker = JOB_METHOD_CACHE.get(invokerKey)
		if(!GrailsUtil.isDevelopmentEnv() && methodInvoker!=null){
			return methodInvoker
		}
		Object serviceBean = SpringApplicationContext.getBean(serviceName)
		Class serviceClass = serviceBean.getClass()
		methodInvoker = new JobMethodInvoker()
		Method targetMethod
		try{
			targetMethod = serviceClass.getMethod(methodName, JobExecutionContext.class)
			methodInvoker.hasParam = true
		}catch(NoSuchMethodException e){
			targetMethod = serviceClass.getMethod(methodName)
			methodInvoker.hasParam = false
		}
		methodInvoker.serviceName = serviceName
		methodInvoker.method = targetMethod
		JOB_METHOD_CACHE.put(invokerKey, methodInvoker)

		return methodInvoker
	}
	
}
