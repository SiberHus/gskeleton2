package com.siberhus.gskeleton.job

import java.util.concurrent.ConcurrentHashMap
import java.lang.reflect.InvocationTargetException
import org.apache.commons.lang.exception.ExceptionUtils
import com.siberhus.gskeleton.spring.SpringApplicationContext

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 6, 2010
 * Time: 5:37:07 PM
 * To change this template use File | Settings | File Templates.
 */
class ServiceExecutionThread extends Thread{

	public final static Map THREADS = Collections.synchronizedMap(new HashMap())
	public final static Map ERROR_MESSAGES = Collections.synchronizedMap(new HashMap())
	public final static Set RUNNING_SERVICES = Collections.synchronizedSet(new HashSet())
	
	private String name
	ServiceMethodInvoker methodInvoker
	Map parameters
	String requestedBy
	
	public ServiceExecutionThread(String name){
		this.name = name
	}

	public void setMethodInvoker(String serviceName, methodName){
		this.methodInvoker = ServiceMethodInvoker.getMethodInvoker(serviceName, methodName)
	}
	
	public static Thread getInstanceByName(String name){
		return THREADS.get(name)
	}

	public static boolean isServiceRunning(String name){
		return RUNNING_SERVICES.contains(name)
	}

	//TODO: Watch out!!! this method is not thread-safe. I may fix it in someday.
	public void run(){
		if(!methodInvoker) throw new IllegalArgumentException('Method invoker is required')
		if(!requestedBy) throw new IllegalArgumentException('RequestedBy is required')
		THREADS.put(name, this)
		def logService = SpringApplicationContext.getBean('serviceExecutionLogService')
		def log = new ServiceExecutionLog()
		log.serviceExecutorName = name
		log.requestedBy = requestedBy
		if(parameters) {
			log.serviceParameters = parameters.toString()
			parameters['requestedBy'] = requestedBy
		}

		def logId = logService.beginLog(log)

		ERROR_MESSAGES.remove(name)
		RUNNING_SERVICES.add(name)
		try{
			Throwable e = methodInvoker.invoke(parameters)
			logService.completeLog(logId, e)
			if(e) ERROR_MESSAGES.put(name, e)
			else ERROR_MESSAGES.remove(name)
		}finally{
			RUNNING_SERVICES.remove(name)
			THREADS.remove(name)
		}
	}

}
