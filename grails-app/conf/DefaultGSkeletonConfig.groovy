import com.siberhus.gskeleton.web.UserSessionMonitor
import grails.util.GrailsUtil

gskeleton {
	resource{
		serverContext{
			//No trailing slash in docBase and path
			docBase = 'D:/AppServers/resources'
			path = '/gskeleton2/resources'
		}
		accessControl{
			userDir = 'users'
			roleDir = 'roles'
			privateDir = 'private'
			publicDir = 'public'
		}
	}
	security{
		sessionName{
			userSessionMonitor = '_userSessionMonitor'
		}
		password{
			//Available algos = NONE,SHA1,SHA256,SHA384,SHA512,MD2,MD5
			hashAlgo = 'SHA1'
			hashSalt = null //cannot specify custom salt because shiro uses principal(username) as salt.
			hashIteration = 1
			hashEncoding = 'HEX' //HEX,BASE64
		}
	}
	initData {
		adminUser = true
		defaultAdminMenu = true
		defaultJobGroup = true
	}
	jobScheduler {
		autoStart = false
		waitForJobsToCompleteOnShutdown = false
		startupDelay = 0
	}

	dashboard {
		widgetContentPaths = [
			'/memoryInfoWidget',
			'/test/widget?file=customer.png',
			'/test/widget?file=promo.jpg',
			'/test/widget?file=sales.png',
		]
	}
	permissions {
		if(new File('.').canonicalPath.endsWith(File.separator+'gskeleton-two'))
		controllerNames = [
			"System" : [
				system: "System"
			],
			"Users & Access Management":[
				personalProfile:"Personal Profile",
				user:"Users",
				role:"Roles",
				ipv4Filter:"IPv4 Filter",
				loginLog:"Login Logs",
				loginFailureLog:"Login Failure Logs"
			],
			"Dashboard Management":[
				widget:"Widgets"
			],
			"Screen Management":[
				messageSource:"Message Source",
				adminMenu:"Admin Menu"
			],
			"Job & Task Management":[
				jobGroup:"Job Group",
				jobScheduler:"Job Scheduler",
				jobLog:"Job Logs",
				serviceExecutor:"Service Executor",
				serviceExecutionLog:"Service Execution Logs"
			],
			"File Management":[
				directoryNode:"Directory Node",
				simpleFileManager:"Simple File Manager",
				fileRecycleBin:"File Recycle Bin",
				fileOpLog:"File Operation Logs"
			],
			"Configurations":[
				cusomConfig:"Custom Configurations",
				userConfig:"User Configurations",
				systemConfig:"System Configurations",
				log4j:"Log4j Configurations",
				log4jAppender:"Log4j Appenders"
			],
			"Document Management":[
				faqCategory: "FAQ Category",
				faq: "FAQ"
			],
			"Resources":[
				dbConnProfile:"Db Connection Profiles"
			]
		]
		else
			controllerNames = [:]
	}
}

auditLog {
	actorClosure = { request, session ->
		UserSessionMonitor.get(session).username
//		session.user?.username
	} 
}

fckeditor {
	upload {
		basedir = "/files/"
		overwrite = false
		link {
			browser = true
			upload = false
			allowed = []
			denied = ['html', 'htm', 'php', 'php2', 'php3', 'php4', 'php5', 'phtml', 'pwml', 'inc', 'asp', 'aspx', 'ascx', 'jsp',
 'cfm', 'cfc', 'pl', 'bat', 'exe', 'com', 'dll', 'vbs', 'js', 'reg', 
'cgi', 'htaccess', 'asis', 'sh', 'shtml', 'shtm', 'phtm']
		}
		image {
			browser = true
			upload = true
			allowed = ['jpg', 'gif', 'jpeg', 'png'] 
			denied = []
		}
		flash {
			browser = false
			upload = false
			allowed = ['swf']
			denied = []
		}
		media {
			browser = false
			upload = false
			allowed = ['mpg','mpeg','avi','wmv','asf','mov']
			denied = []
		}
	}
}
