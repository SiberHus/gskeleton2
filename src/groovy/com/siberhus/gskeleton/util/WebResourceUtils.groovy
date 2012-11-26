package com.siberhus.gskeleton.util

import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 12, 2010
 * Time: 9:15:34 PM
 * To change this template use File | Settings | File Templates.
 */
class WebResourceUtils {
	
	static File getResourceFile(String resourceName){
		String docBase = CH.config.gskeleton.resource.serverContext.docBase
		return new File(docBase+File.separator+resourceName)
	}

	static String getResourceWebPath(String resourceName){
		return CH.config.gskeleton.resource.serverContext.path+'/'+resourceName
	}

	static File getUserResourceFile(String resourceName){
		String docBase = CH.config.gskeleton.resource.serverContext.docBase
		String dirName = CH.config.gskeleton.resource.accessControl.userDir
		String username = SecurityUtils.getSubject().getPrincipal().toString()
		return new File(docBase+File.separator+dirName+File.separator
			+username+File.separator+resourceName)
	}

	static String getUserResourceWebPath(String resourceName){
		String dirName = CH.config.gskeleton.resource.accessControl.userDir
		String username = SecurityUtils.getSubject().getPrincipal().toString()
		return getResourceWebPath(dirName+'/'+username+'/'+resourceName)
	}

	static File getPrivateResourceFile(String resourceName){
		String docBase = CH.config.gskeleton.resource.serverContext.docBase
		String dirName = CH.config.gskeleton.resource.accessControl.privateDir
		return new File(docBase+File.separator+dirName+File.separator+resourceName)
	}

	static String getPrivateResourceWebPath(String resourceName){
		String dirName = CH.config.gskeleton.resource.accessControl.privateDir
		return getResourceWebPath(dirName+'/'+resourceName)
	}

	static File getPublicResourceFile(String resourceName){
		String docBase = CH.config.gskeleton.resource.serverContext.docBase
		String dirName = CH.config.gskeleton.resource.accessControl.publicDir
		return new File(docBase+File.separator+dirName+File.separator+resourceName)
	}

	static String getPublicResourceWebPath(String resourceName){
		String dirName = CH.config.gskeleton.resource.accessControl.publicDir
		return getResourceWebPath(dirName+'/'+resourceName)
	}
}
