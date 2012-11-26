package com.siberhus.gskeleton.job

import org.springframework.beans.factory.NoSuchBeanDefinitionException
import org.springframework.util.ClassUtils
import org.springframework.util.ReflectionUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.quartz.CronExpression
import org.quartz.JobExecutionContext;
import com.siberhus.gskeleton.Auditable;
import com.siberhus.gskeleton.spring.SpringApplicationContext;

class Job extends Auditable {

	JobGroup jobGroup
	String name
	String serviceName
	String methodName = 'executeJob'
	boolean concurrent
	String triggerType
	String cronExp
	Long repeatInterval
	String timeUnit = 'H'
	Integer repeatCount = -1
	java.sql.Timestamp startTime
	java.sql.Timestamp startTime_
	java.sql.Timestamp endTime
	java.sql.Timestamp endTime_
	String description
	String status = 'A'
	
	String triggerState
	Date nextFireTime
	Date previousFireTime
	
	String toString(){
		return toFullName()
	}

	String toFullName(){
		return jobGroup.name+'.'+name
	}
	
	static transients = ['triggerState','nextFireTime','previousFireTime','startTime_','endTime_'];
	
	static mapping = {
		table 'gsk_jobs'
		serviceName column: 'service_name'
		methodName column: 'method_name'
		triggerType column: 'trigger_type'
		cronExp column: 'cron_exp'
		repeatInterval column: 'repeat_interval'
		timeUnit column: 'time_unit'
		repeatCount column: 'repeat_count'
	}
	
	static constraints = {
		jobGroup(nullable:false)
		name(blank:false, unique:true)
		serviceName(blank:false, validator: {val, obj->
			try{
				SpringApplicationContext.getBean(val)
			}catch(NoSuchBeanDefinitionException e){
				return 'service.not.found'
			}
			return true
		})
		methodName(nullable:false, validator: {val, obj->
			try{
				Object bean = SpringApplicationContext.getBean(obj.serviceName)
				try{
					bean.class.getMethod(val, JobExecutionContext.class)
				}catch(NoSuchMethodException e){
					bean.class.getMethod(val)
				}
			}catch(NoSuchBeanDefinitionException e){
				return 'service.not.found'
			}catch(NoSuchMethodException e){
				return 'method.not.found'
			}
			return true
		})
		concurrent()
		triggerType(blank:false, inList:['cron','repeat'])
		cronExp(nullable:true,validator: {val,obj->
			if(obj.triggerType=='cron'){
				if(val==null || val?.isEmpty()){
					return 'default.blank.message'
				}else if(!CronExpression.isValidExpression(val)){
					return 'cron.expression.invalid'
				}
			}
			return true
		})
		repeatInterval(nullable:true,validator: {val,obj->
			if(obj.triggerType=='repeat'
				&& val==null){
				return 'default.null.message'
			}
			return true
		})
		timeUnit(nullable:true,inList:['S','M','H'], validator: {val, obj->
			if(obj.repeatInterval!=null && val==null){
				return 'default.null.message';
			}
			return true
		})
		repeatCount(nullable:false)
		startTime(nullable:true)
		endTime(nullable:true)
		description(nullable:true, maxSize:4000)
		status(blank:false, inList:['A','I'])
	}

	static searchFields = ['jobGroup.id':'=',name:'like' ,serviceName:'=',triggerType:'=',startTime:'between',endTime:'between'];
	
}
