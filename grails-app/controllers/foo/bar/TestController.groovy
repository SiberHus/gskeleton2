package foo.bar

import org.apache.log4j.Logger
import org.apache.log4j.Level
import org.apache.log4j.ConsoleAppender
import org.apache.log4j.PatternLayout

import org.apache.log4j.AppenderSkeleton
import org.apache.log4j.FileAppender
import org.apache.log4j.RollingFileAppender

import com.siberhus.gskeleton.dashboard.Widget
import com.siberhus.gskeleton.web.UserSessionMonitor

class TestController {

	def widget = {
		render(view:'/test/tmpWidget')
	}
	
	def index = {
//		Logger.getRootLogger().setLevel(Level.WARN)
//		Logger.getLogger("foo.bar").setLevel(Level.DEBUG)
		def appenders = Logger.getRootLogger().getAllAppenders()
		println 'Root appender'
		for(AppenderSkeleton appender in appenders){
			if(appender instanceof ConsoleAppender){
				appender.threshold = null
			}
			println appender.name
		}
		println 'Foobar appender'
		appenders = Logger.getLogger("foo.bar").getAllAppenders()
		for(AppenderSkeleton appender in appenders){
			println appender.name
		}
	}
	
    def setup = {

		Logger.getLogger("foo").removeAppender('fileout')
		
//		Logger.getRootLogger().removeAllAppenders()
		Logger.getRootLogger().removeAppender('fileout')
		def layout = new PatternLayout('%c{1} %p: %d{dd/MM/yyyy HH:mm:ss} | %m%n')

		FileAppender appender = new RollingFileAppender()
//		FileAppender appender = new RollingFileAppender(layout, 'D:/Tmp/abc.log')
		appender.name = 'fileout'
		appender.layout = new PatternLayout('%c{1} %p: %d{dd/MM/yyyy HH:mm:ss} | %m%n')
		appender.threshold = Level.WARN
		appender.file = 'D:/Tmp/abc.log'
		appender.append = true
		appender.immediateFlush = true
//		appender.bufferSize = 5
		appender.maxBackupIndex = 3
		appender.maxFileSize = '3KB'
		appender.activateOptions()
		Logger.getRootLogger().addAppender(appender)
//		Logger.getLogger("foo").addAppender(appender)
	}
	
	def test = {
		render(view:'/dashboard')
	}
}
