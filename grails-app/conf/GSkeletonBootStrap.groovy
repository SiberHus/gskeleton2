
import com.siberhus.gskeleton.service.JobManagerService;
import com.siberhus.gskeleton.init.CommonsConverterRegisterTask;
import com.siberhus.gskeleton.init.CommonsConverterRegistrar;
import com.siberhus.gskeleton.init.DataInit;
import com.siberhus.gskeleton.init.LocalizationInit;
import com.siberhus.gskeleton.init.SystemConfigInit;
import com.siberhus.gskeleton.spring.SpringApplicationContext;
import com.siberhus.gskeleton.config.SysConfig;
import com.siberhus.gskeleton.config.SysConfigObject;

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH;
import org.codehaus.groovy.grails.commons.ApplicationHolder as AH
import org.quartz.Scheduler;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.util.ClassUtils;
import org.springframework.web.multipart.commons.CommonsMultipartResolver
import org.springframework.core.io.FileSystemResource
import com.siberhus.gskeleton.init.Log4jConfigInit
import com.siberhus.gskeleton.init.QuartzJobInit;

class GSkeletonBootStrap {

	//automatic wired spring bean
	JavaMailSenderImpl mailSender
	CommonsMultipartResolver multipartResolver

	JobManagerService jobManagerService
	Scheduler quartzScheduler
	
	static ClassLoader grailsClassLoader;

	def init = { servletContext ->

		servletContext.setAttribute("contextPath",servletContext.contextPath)

		SystemConfigInit configInit = new SystemConfigInit()
		configInit.init()
		servletContext.setAttribute('config',new SysConfigObject())

		def sysLocaleStr = (SysConfig.get('system.locale')?:'en_US').split('_')
		def sysLocale = new Locale(sysLocaleStr[0], sysLocaleStr[1])
		Locale.setDefault sysLocale

		grailsClassLoader = ClassUtils.getDefaultClassLoader()
		log.debug "Default Class Loader = "+ClassUtils.getDefaultClassLoader()
		log.debug "Parent Class Loader = "+ClassUtils.getDefaultClassLoader().getParent()
		Map registrarBeanMap = AH.application.mainContext.getBeansOfType(CommonsConverterRegistrar.class)
//		Map registrarBeanMap = SpringApplicationContext.getDelegate().getBeansOfType(CommonsConverterRegistrar.class)
		CommonsConverterRegisterTask registerTask = new CommonsConverterRegisterTask(registrarBeanMap?.values())
		registerTask.run()// execute in current thread (run in default class loader, it's GrailsClassLoader)
		registerTask.setContextClassLoader ClassUtils.getDefaultClassLoader().getParent()
		registerTask.start() //execute in another thread that run in native class loader

		DataInit dataInit = new DataInit()
		if(CH.config.gskeleton.initData.adminUser){
			log.info('Initializing admin user.')
			dataInit.initAdminUser()
		}
		if(CH.config.gskeleton.initData.defaultAdminMenu){
			log.info('Initializing default admin menu.')
			dataInit.initDefaultAdminMenus()
		}
		if(CH.config.gskeleton.initData.defaultJobGroup){
			log.info('Initializing default job group.')
			dataInit.initDefaultJobGroup()
		}

		mailSender.setHost(SysConfig.get('email.host'))
		mailSender.setDefaultEncoding(SysConfig.get('email.encoding'))

		def port = SysConfig.get('email.port')
		if(port) mailSender.setPort(port)
		def username = SysConfig.get('email.username')
		if(username) mailSender.setUsername(username)
		def password = SysConfig.get('email.password')
		if(password) mailSender.setPassword(password)
		def protocol = SysConfig.get('email.protocol')
		if(protocol) mailSender.setProtocol(protocol)
		StringReader mailPropsReader = new StringReader(SysConfig.get('email.properties'))
		Properties mailProps = new Properties()
		mailProps.load(mailPropsReader)
		mailSender.setJavaMailProperties(mailProps)
		
		def maxUploadSize = SysConfig.get('fileUpload.maxUploadSize')
		if(maxUploadSize) multipartResolver.setMaxUploadSize(maxUploadSize)
		def maxInMemorySize = SysConfig.get('fileUpload.maxInMemorySize')
		if(maxInMemorySize) multipartResolver.setMaxInMemorySize(maxInMemorySize)
		def defaultEncoding = SysConfig.get('fileUpload.defaultEncoding')
		if(defaultEncoding) multipartResolver.setDefaultEncoding(defaultEncoding)
		def uploadTmpDir = SysConfig.get('fileUpload.uploadTempDir')
		if(uploadTmpDir) multipartResolver.setUploadTempDir(new FileSystemResource(uploadTmpDir)) 

		
		log.info('Initialize Localization including loading message files to database')
		LocalizationInit localizationInit = new LocalizationInit()
		localizationInit.init(servletContext)

		log.info('Initializing Quartz Scheduling configuration')
		new QuartzJobInit().init()

		log.info('Initializing log4j configuration')
		new Log4jConfigInit().init()
		
	}

	def destroy = {
    }
}

