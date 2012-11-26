package com.siberhus.gskeleton.util

import org.apache.log4j.Appender
import org.apache.log4j.DailyRollingFileAppender
import org.apache.log4j.PatternLayout
import org.apache.log4j.AppenderSkeleton
import org.apache.log4j.Level
import org.apache.log4j.RollingFileAppender
import org.apache.log4j.FileAppender
import org.apache.log4j.ConsoleAppender
import org.apache.log4j.net.SMTPAppender

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 1, 2010
 * Time: 3:29:19 PM
 * To change this template use File | Settings | File Templates.
 */
class Log4jAppenderFactory {

	static String DAILY_ROLLING_FILE = 'DAILY_ROLLING_FILE' //drfile
	static String ROLLING_FILE = 'ROLLING_FILE' //rfile
	static String FILE = 'FILE' //file
	static String CONSOLE = 'CONSOLE' //console
	static String SMTP = 'SMTP' //smtp
	
	public static Appender create(String type, String name, String threshold, String pattern, Map props){
		Appender appender
		if(!type) throw new IllegalArgumentException('type cannot be blank')
		if(!name) throw new IllegalArgumentException('name cannot be blank')

		if(type==DAILY_ROLLING_FILE){
			appender = new DailyRollingFileAppender()
		}else if(type==ROLLING_FILE){
			appender = new RollingFileAppender()
		}else if(type==FILE){
			appender = new FileAppender()
		}else if(type==CONSOLE){
			appender = new ConsoleAppender()
		}else if(type==SMTP){
			appender = new SMTPAppender()
		}
		appender.name = name
		update(appender, threshold, pattern, props)
		return appender
	}

	public static void update(Appender appender, String threshold, String pattern, Map props){

		if(!threshold) threshold = 'info'
		if(!pattern) pattern = '%c{1} %p: %d{dd/MM/yyyy HH:mm:ss} | %m%n'

		if(appender instanceof DailyRollingFileAppender){
			configureFileAppender(appender, props)
			if(props.datePattern){
				appender.datePattern = props.datePattern
			}else{
				String periodicity = props.periodicity
				// [monthly,weekly,half-daily,daily,hourly,minutely]
				if(periodicity=='monthly'){
					appender.datePattern = "'.'yyyy-MM"
				}else if(periodicity=='weekly'){
					appender.datePattern = "'.'yyyy-ww"
				}else if(periodicity=='half-daily'){
					appender.datePattern = "'.'yyyy-MM-dd-a"
				}else if(periodicity=='daily'){
					appender.datePattern = "'.'yyyy-MM-dd"
				}else if(periodicity=='hourly'){
					appender.datePattern = "'.'yyyy-MM-dd-HH"
				}else if(periodicity=='minutely'){
					appender.datePattern = "'.'yyyy-MM-dd-HH-mm"
				}else{
					appender.datePattern = "'.'yyyy-MM-dd"
				}
			}
		}else if(appender instanceof RollingFileAppender){
			configureFileAppender(appender, props)
			if(props.maxFileSize) appender.maxFileSize = props.maxFileSize
			if(props.maxBackupIndex) appender.maxBackupIndex = props.maxBackupIndex as int
		}else if(appender instanceof FileAppender){
			configureFileAppender(appender, props)
		}else if(appender instanceof ConsoleAppender){
//			if(!props.target) appender.target = 'System.out'
//			if(!(props.target in['System.out','System.err'])){
//				throw new IllegalAccessException('target must be System.out or System.err')
//			}
		}else if(appender instanceof SMTPAppender){
			if(!props.smtpHost) throw new MissingPropertyException('smtpHost')
			appender.smtpHost = props.smtpHost
			if(props.smtpUsername) appender.smtpUsername = props.smtpUsername
			if(props.smtpPassword) appender.smtpPassword = props.smtpPassword
			if(props.bufferSize) appender.bufferSize = props.bufferSize as int
			appender.smtpDebug = props.smtpDebug?true:false
			appender.locationInfo = props.locationInfo?true:false
			if(!props.to) throw new MissingPropertyException('to')
			appender.to = props.to
			if(!props.from) throw new MissingPropertyException('from')
			appender.from = props.from
			if(props.cc) appender.cc = props.cc
			if(props.bcc) appender.bcc = props.bcc
			if(!props.subject) throw new MissingResourceException('subject')
			appender.subject = props.subject
		}

		appender.layout = new PatternLayout(pattern)
		appender.threshold = Level.toLevel(threshold)
		appender.activateOptions()
	}

	static void configureFileAppender(FileAppender appender, Map props){
		if(!props.file) throw new MissingPropertyException('file')
		appender.file = props.file
		appender.encoding = props.encoding?:'UTF-8'
		appender.append = props.append?true:false
		appender.bufferedIO = props.bufferedIO?true:false
		if(props.bufferSize) appender.bufferSize = props.bufferSize as int
		appender.immediateFlush = props.immediateFlush?true:false
	}
}
