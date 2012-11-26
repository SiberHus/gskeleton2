import org.codehaus.groovy.grails.commons.ConfigurationHolder

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]


// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder=false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable fo AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// set per-environment serverURL stem for creating absolute links
environments {
	production {
		grails.serverURL = "http://www.changeme.com"
		grails.config.locations = [ "classpath:jdbc-config.properties" ]
	}
	development {
		grails.serverURL = "http://localhost:8080/${appName}"
	}
	test {
		grails.serverURL = "http://localhost:8080/${appName}"
	}
}

// log4j configuration
log4j = {
	// Example of changing the log pattern for the default console
	// appender:
	//
	appenders {
		console name:'stdout', threshold: org.apache.log4j.Level.INFO, layout:pattern(conversionPattern: '%c{1} %p: %d{dd/MM/yyyy HH:mm:ss} | %m%n')
	}

	error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
		'org.codehaus.groovy.grails.web.pages', //  GSP
		'org.codehaus.groovy.grails.web.sitemesh', //  layouts
		'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
		'org.codehaus.groovy.grails.web.mapping', // URL mapping
		'org.codehaus.groovy.grails.commons', // core / classloading
		'org.codehaus.groovy.grails.plugins', // plugins
		'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
		'org.springframework',
		'org.hibernate',
		'net.sf.ehcache.hibernate'

	warn   'org.mortbay.log'

	debug	'grails.app', // Logging warnings and higher for all of the app
			'com.siberhus.gskeleton',

	root {
		warn stdout
	}
}

/*
grails.naming.entries = ['jdbc/gskeleton': [
	type: "javax.sql.DataSource", //required
	auth: "Container", // optional
	description: "Data source for plugin testing", //optional
	//properties for particular type of resource
	url: "jdbc:postgresql://localhost:5432/gskeleton2",
	username: "admin",
	password: "password",
	driverClassName: "org.postgresql.Driver",
	maxActive: "8", //and so on
	maxIdle: "4"
	]
]
*/
