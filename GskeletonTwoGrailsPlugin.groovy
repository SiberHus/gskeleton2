import org.quartz.Job;

import grails.util.GrailsUtil;
import groovy.util.ConfigObject;

import org.codehaus.groovy.grails.commons.ConfigurationHolder;
import org.springframework.util.ClassUtils;
import org.springframework.cache.ehcache.EhCacheFactoryBean;

class GskeletonTwoGrailsPlugin {


	// the plugin version
	def version = "1.0"
	// the version or versions of Grails the plugin is designed for
	def grailsVersion = "1.2.0 > *"
	// the other plugins this plugin depends on
	def dependsOn = [hibernate:'1.2 > *',shiro:'1.1.1',fckeditor:'0.9.4 > *',mail:'0.9']
	// resources that are excluded from plugin packaging
	def pluginExcludes = [
			"grails-app/views/error.gsp"
	]

	def author = "Hussachai Puripunpinyo"
	def authorEmail = "hussachai@gmail.com"
	def title = "GSkeleton2"
	def description = '''\\
		GSkeleton2
	'''

	// URL to the plugin's documentation
	def documentation = "http://grails.org/plugin/gskeleton"

	def doWithWebDescriptor = { xml ->
		// TODO Implement additions to web.xml (optional), this event occurs before
		def servletElement = xml.'servlet'
		def servletMapElement = xml.'servlet-mapping'
		
		// Need to get the last element
		servletElement[servletElement.size()-1] + {
			'servlet' {
				'servlet-name'("chart")
				'servlet-class'("org.jfree.eastwood.ChartServlet")
			}
		}

		servletMapElement + {
			'servlet-mapping' {
				'servlet-name'("chart")
				'url-pattern'("/chart")
			}
		}
	}

	def doWithSpring = {

		def config = loadGSkeletonConfig()

		defaultCommonsConverterRegistrar(com.siberhus.gskeleton.init.DefaultCommonsConverterRegistrar)
		customPropertyEditorRegistrar(com.siberhus.gskeleton.spring.DefaultPropertyEditorRegistrar)
		messageSource(com.siberhus.gskeleton.spring.MapCacheDatabaseMessageSource)
		/*
		messageCache(EhCacheFactoryBean) {
			timeToLive = 500
			// other cache properties
		}
		messageSource(com.siberhus.gskeleton.spring.EhcacheDatabaseMessageSource){
			messageCache = messageCache
		}
		*/
		//messageSource(org.codehaus.groovy.grails.context.support.PluginAwareResourceBundleMessageSource)
		springApplicationContext(com.siberhus.gskeleton.spring.SpringApplicationContext)

		sessionBinderListener(com.siberhus.gskeleton.job.SessionBinderJobListener){bean->
			bean.autowire = "byName"
		}
		quartzScheduler(org.springframework.scheduling.quartz.SchedulerFactoryBean) {
			//		 delay scheduler startup to after-bootstrap stage
			autoStartup = config.gskeleton.jobScheduler.autoStart
			waitForJobsToCompleteOnShutdown = config.gskeleton.jobScheduler.waitForJobsToCompleteOnShutdown
			startupDelay = config.gskeleton.jobScheduler.startupDelay
			//		if(config.jdbcStore) {
			//			dataSource = ref('dataSource')
			//			transactionManager = ref('transactionManager')
			//		}
			//
			//		jobFactory = quartzJobFactory
//			jobListeners = [ref('sessionBinderListener')]
			globalJobListeners = [ref('sessionBinderListener')]
			//		globalJobListeners = [ref("${ExceptionPrinterJobListener.NAME}")]
		}

		// Redefine mailSender
		mailSender(org.springframework.mail.javamail.JavaMailSenderImpl)

		multipartResolver(org.springframework.web.multipart.commons.CommonsMultipartResolver)

	}

	def doWithDynamicMethods = { ctx ->
		
	}
	
	def doWithApplicationContext = { applicationContext ->
		// TODO Implement post initialization spring config (optional)
	}

	def onChange = { event ->
		// TODO Implement code that is executed when any artefact that this plugin is
		// watching is modified and reloaded. The event contains: event.source,
		// event.application, event.manager, event.ctx, and event.plugin.
	}

	def onConfigChange = { event ->
		// TODO Implement code that is executed when the project configuration changes.
		// The event is the same as for 'onChange'.
	}

	private ConfigObject loadGSkeletonConfig(){
		def config = ConfigurationHolder.config
		GroovyClassLoader classLoader = new GroovyClassLoader(getClass().classLoader)
		
		// merging default GSkeleton config into main application config
		config.merge(new ConfigSlurper(GrailsUtil.environment).parse(classLoader.loadClass('DefaultGSkeletonConfig')))
		// merging user-defined GSkeleton config into main application config if provided
		try {
			config.merge(new ConfigSlurper(GrailsUtil.environment).parse(classLoader.loadClass('GSkeletonConfig')))
		} catch (Exception ignored) {
			// ignore, just use the defaults
		}
		
		config.merge(new ConfigSlurper(GrailsUtil.environment).parse(classLoader.loadClass('DefaultWebPerformanceConfig')))
		try{
			config.merge(new ConfigSlurper(GrailsUtil.environment).parse(classLoader.loadClass('WebPerformanceConfig')))
		}catch(Exception ignored){}
		
		
		
		return config
	}

}
