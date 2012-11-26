package com.siberhus.gskeleton.init

import org.apache.log4j.PatternLayout
import org.apache.log4j.ConsoleAppender
import org.apache.log4j.Logger
import org.apache.log4j.Appender
import com.siberhus.gskeleton.util.Log4jAppenderFactory
import com.siberhus.gskeleton.cfg.log4j.Log4jAppender
import org.apache.log4j.Level

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 3, 2010
 * Time: 11:32:19 AM
 * To change this template use File | Settings | File Templates.
 */
class Log4jConfigInit {

	
	public void init(){
		def appenders = Logger.getRootLogger().getAllAppenders()
		for(def appender in appenders){
			if(appender instanceof ConsoleAppender){
				def instance = Log4jAppender.findByName(appender.name)
				if(!instance){
					instance = new Log4jAppender()
					instance.name = appender.name
					instance.threshold = appender.threshold?appender.threshold.toString():'DEBUG'
					instance.conversionPattern = ((PatternLayout)appender.layout).conversionPattern
					instance.type = Log4jAppenderFactory.CONSOLE
					instance.save()
				}else{
					appender.threshold = Level.toLevel(instance.threshold)
					appender.layout = new PatternLayout(instance.conversionPattern)
				}
			}
		}
		for(def log4jAppender in Log4jAppender.list()){
			String type = log4jAppender.type
			String name = log4jAppender.name
			String threshold = log4jAppender.threshold
			String pattern = log4jAppender.conversionPattern
			Map props = log4jAppender.props
			Appender appender = Log4jAppenderFactory.create(type, name, threshold, pattern, props)
			Appender existing = Logger.getRootLogger().getAppender(name)
			if(!existing){
				Logger.getRootLogger().addAppender(appender)
			}else if(!(existing instanceof ConsoleAppender)){
//				log.warn("There are existing appenders (${name}), log4j setting in db is ignored!!!")
			}
		}
	}
}
