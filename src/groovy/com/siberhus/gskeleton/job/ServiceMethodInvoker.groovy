package com.siberhus.gskeleton.job;


import com.siberhus.gskeleton.spring.SpringApplicationContext
import grails.util.GrailsUtil
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method
import java.util.concurrent.ConcurrentHashMap
import org.springframework.util.ClassUtils

class ServiceMethodInvoker {

	private static final Map SERVICE_METHOD_CACHE = new ConcurrentHashMap()
	
	String serviceName
	Method method
	boolean hasParam
	
	public Throwable invoke(Map parameters){
		
		Object serviceBean
		try{
			serviceBean = SpringApplicationContext.getBean(serviceName)
		}catch(Exception e){}
		try{
			if(!serviceBean){
				Class serviceClass = ClassUtils.forName(serviceName)
				serviceBean = serviceClass.newInstance()
			}
			if(hasParam){
				method.invoke(serviceBean, [parameters] as Object[])
			}else{
				method.invoke(serviceBean)
			}
			return null
		}catch(InvocationTargetException e){
			return e.targetException
		}catch(Exception e){
			return e
		}
	}

	public static ServiceMethodInvoker getMethodInvoker(String serviceName, String methodName) {

		String invokerKey = serviceName+'.'+methodName
		ServiceMethodInvoker methodInvoker = SERVICE_METHOD_CACHE.get(invokerKey)
		if(!GrailsUtil.isDevelopmentEnv() && methodInvoker!=null){
			return methodInvoker
		}
		Object serviceBean
		try{
			serviceBean = SpringApplicationContext.getBean(serviceName)
		}catch(Exception e){
			Class serviceClass = ClassUtils.forName(serviceName)
			serviceBean = serviceClass.newInstance()
		}
		Class serviceClass = serviceBean.getClass()
		methodInvoker = new ServiceMethodInvoker()
		Method targetMethod
		try{
			targetMethod = serviceClass.getMethod(methodName, Map.class)
			methodInvoker.hasParam = true
		}catch(NoSuchMethodException e){
			targetMethod = serviceClass.getMethod(methodName)
			methodInvoker.hasParam = false
		}
		methodInvoker.serviceName = serviceName
		methodInvoker.method = targetMethod
		SERVICE_METHOD_CACHE.put(invokerKey, methodInvoker)

		return methodInvoker
	}
	
}
