package com.siberhus.gskeleton.job

import com.siberhus.gskeleton.Auditable
import org.quartz.Scheduler
import org.springframework.beans.factory.NoSuchBeanDefinitionException
import com.siberhus.gskeleton.spring.SpringApplicationContext
import org.springframework.util.ClassUtils

class ServiceExecutor extends Auditable{

	String name
	String serviceName
	String methodName
	boolean concurrent
	String description
	List serviceParameters
	
	String toString(){
		return name
	}

	static mapping = {
		table 'gsk_service_executors'
		serviceName column: 'service_name'
		methodName column: 'method_name'
	}

	static constraints = {
		name(blank:false, unique:true)
		serviceName(blank:false, unique: 'name', validator: {val, obj->
			try{
				SpringApplicationContext.getBean(val)
			}catch(NoSuchBeanDefinitionException nsbde){
				try{
					ClassUtils.forName(val)
				}catch(Exception e){
					println e
					return 'service.not.found'
				}
			}
			return true
		})
		methodName(blank:false, unique:'serviceName', validator: {val, obj->
			Class beanClass
			try{
				Object bean = SpringApplicationContext.getBean(obj.serviceName)
				beanClass = bean.class
			}catch(NoSuchBeanDefinitionException nsbde){
				try{
					beanClass = ClassUtils.forName(obj.serviceName)
				}catch(Exception e){
					println e
					return 'service.not.found'
				}
			}
			try{
				try{
					beanClass.getMethod(val, Map.class)
				}catch(NoSuchMethodException e){
					beanClass.getMethod(val)
				}
			}catch(Exception e){
				println e
				return 'method.not.found'
			}
			return true
		})
		concurrent()
		description(nullable:true, maxSize:4000)
	}

	static hasMany = [serviceParameters: ServiceParameter]
	
	static searchFields = ['name':'like', 'serviceName':'=', 'methodName':'=']
	//static exportFields = ['fieldName']
	//static lookupFields = [fieldName:]
	static listFields = ['name','serviceName','methodName']
}
