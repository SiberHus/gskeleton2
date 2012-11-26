package com.siberhus.gskeleton.taglib

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.apache.commons.codec.digest.DigestUtils
import java.util.concurrent.ConcurrentHashMap
import com.siberhus.com.yahoo.platform.yui.compressor.YUICompressor
import grails.util.GrailsUtil
import grails.util.Environment

class WebPerformanceTagLib {

	static namespace = 'wp'

	static SCRIPT_RESOURCE_MAP = new HashMap<String, WebResource>()
	static STYLE_RESOURCE_MAP = new HashMap<String, WebResource>()

	static SCRIPT_BUNDLE_RESOURCE_MAP = new HashMap<String, String>()
	static STYLE_BUNDLE_RESOURCE_MAP = new HashMap<String, String>()

	static class WebResource {
		def lastModifiedTime
		String resourcePath
		String inputFilePath
		String outputFilePath
		boolean fileChanged
	}

	def pluginManager

	def script = {attrs->
		def name = attrs['name']
		def webResource = getCompressedResource('js', name)
		out << "<script type=\"text/javascript\" src=\"${webResource.resourcePath}\"></script>"
	}

	def style = {attrs->
		def name = attrs['name']
		def webResource = getCompressedResource('css', name)
		out << "<link href=\"${webResource.resourcePath}\" rel=\"stylesheet\" type=\"text/css\" />"
	}

	def scriptBundle = {attrs->
		def name = attrs['name']
		def merge = attrs['merge']=='true'?true:false
		if(!name){
			throw new IllegalArgumentException('Attribute name is required')
		}
		String resourcePath = SCRIPT_BUNDLE_RESOURCE_MAP.get(name)
		if(resourcePath!=null){
			if(merge && Environment.current.equals(Environment.PRODUCTION)){
				out << "<script type=\"text/javascript\" src=\"${resourcePath}\"></script>"
				return
			}
		}
		def resourceConfigMap = ConfigurationHolder.config.webPerformance.scriptBundles
		def bundleConfigMap = resourceConfigMap.get(name)
		def scripts = bundleConfigMap['scripts']
		def targetDirPath = bundleConfigMap['targetDir']
		if(!targetDirPath){
			targetDirPath = ConfigurationHolder.config.webPerformance.defaultTargetDir.scriptBundles
		}
		if(!merge){
			//Don't check null because groovy if is null safe
			for(script in scripts){
				def webResource = getCompressedResource('js', script)
				out << "<script type=\"text/javascript\" src=\"${webResource.resourcePath}\"></script>"
			}
		}else{
			if(resourcePath!=null){
				boolean reload = false
				if(GrailsUtil.isDevelopmentEnv()){
					for(script in scripts){
						WebResource webResource = getCompressedResource('js', script)
						if(webResource!=null && webResource.fileChanged){
							reload = true
							break
						}
					}
				}
				if(!reload){
					out << "<script type=\"text/javascript\" src=\"${resourcePath}\"></script>"
					return
				}
			}
			if(scripts){
				String hexName = '_'+DigestUtils.md5Hex(name)+'.js'
				String targetFilePath = servletContext.getRealPath(targetDirPath+File.separator+hexName)
				resourcePath = servletContext.contextPath+targetDirPath+'/'+hexName
				def targetFile = new File(targetFilePath)
				log.info("Packing script bundle: ${name} to file : ${targetFile}")
				targetFile.write('')
				for(script in scripts){
					WebResource webResource = SCRIPT_RESOURCE_MAP.get(script)
					if(!webResource){
						webResource = getCompressedResource('js', script)
					}
					def compressedFile = new File(webResource.outputFilePath)
					if(compressedFile.exists()){
						targetFile.withWriterAppend("UTF-8") { writer->
							writer.writeLine(compressedFile.getText('UTF-8'))
						}
					}
				}
				SCRIPT_BUNDLE_RESOURCE_MAP.put(name, resourcePath)
				out << "<script type=\"text/javascript\" src=\"${resourcePath}\"></script>"
			}
		}
	}

	def styleBundle = {attrs->
		def name = attrs['name']
		def merge = attrs['merge']=='true'?true:false
		if(!name){
			throw new IllegalArgumentException('Attribute name is required')
		}
		String resourcePath = STYLE_BUNDLE_RESOURCE_MAP.get(name)
		if(resourcePath!=null){
			if(merge && Environment.current.equals(Environment.PRODUCTION)){
				out << "<link href=\"${resourcePath}\" rel=\"stylesheet\" type=\"text/css\" />"
				return
			}
		}
		def resourceConfigMap = ConfigurationHolder.config.webPerformance.styleBundles
		def bundleConfigMap = resourceConfigMap.get(name)
		def styles = bundleConfigMap['styles']
		def targetDirPath = bundleConfigMap['targetDir']
		if(!targetDirPath){
			targetDirPath = ConfigurationHolder.config.webPerformance.defaultTargetDir.styleBundles
		}
		if(!merge){
			//Don't check null because groovy if is null safe
			for(style in styles){
				def webResource = getCompressedResource('css', style)
				out << "<link href=\"${webResource.resourcePath}\" rel=\"stylesheet\" type=\"text/css\" />"
			}
		}else{
			if(resourcePath!=null){
				boolean reload = false
				if(GrailsUtil.isDevelopmentEnv()){
					for(style in styles){
						WebResource webResource = getCompressedResource('css', style)
						if(webResource!=null && webResource.fileChanged){
							reload = true
							break
						}
					}
				}
				if(!reload){
					out << "<link href=\"${resourcePath}\" rel=\"stylesheet\" type=\"text/css\" />"
					return
				}
			}
			if(styles){
				String hexName = '_'+DigestUtils.md5Hex(name)+'.css'
				String targetFilePath = servletContext.getRealPath(targetDirPath+File.separator+hexName)
				resourcePath = servletContext.contextPath+targetDirPath+'/'+hexName
				def targetFile = new File(targetFilePath)
				log.info("Packing style bundle: ${name} to file : ${targetFile}")
				targetFile.write('')
				for(style in styles){
					WebResource webResource = STYLE_RESOURCE_MAP.get(style)
					if(!webResource){
						webResource = getCompressedResource('css', style)
					}
					def compressedFile = new File(webResource.outputFilePath)
					if(compressedFile.exists()){
						targetFile.withWriterAppend("UTF-8") { writer->
							writer.writeLine(compressedFile.getText('UTF-8'))
						}
					}
				}
				STYLE_BUNDLE_RESOURCE_MAP.put(name, resourcePath)
				out << "<link href=\"${resourcePath}\" rel=\"stylesheet\" type=\"text/css\" />"
			}
		}
	}

	WebResource getCompressedResource(String type, String name){
		if(!name){
			throw new IllegalArgumentException('Attribute name is required')
		}
		def resourceConfigMap
		def webResourceMap
		if(type=='js'){
			resourceConfigMap = ConfigurationHolder.config.webPerformance.scripts
			webResourceMap = SCRIPT_RESOURCE_MAP
		}else if(type=='css'){
			resourceConfigMap = ConfigurationHolder.config.webPerformance.styles
			webResourceMap = STYLE_RESOURCE_MAP
		}
		WebResource webResource = webResourceMap.get(name)
		if(webResource!=null){
			if(Environment.getCurrent()==Environment.PRODUCTION)
			return webResource
		}else{
			webResource = new WebResource()
			webResourceMap.put(name, webResource)
		}

		def resourceAttrs = resourceConfigMap[name]
		if(!resourceAttrs){
			throw new ResourceException("Missing configuration name: ${name}")
		}
		String newResourcePath
		String resourcePath = findResourcePath(resourceAttrs)
		String inputFilePath = servletContext.getRealPath(resourcePath)
		String plugin = resourceAttrs['plugin']
		if(GrailsUtil.isDevelopmentEnv() && webResource.inputFilePath){
			def previousMod = webResource.lastModifiedTime
			def currentMod = new File(webResource.inputFilePath).lastModified()
			if(previousMod != currentMod){
				webResource.resourcePath = null
				webResource.fileChanged = true
			}else{
				webResource.fileChanged = false
			}
		}
		if(webResource.resourcePath==null){
			String targetDirPath
			if(resourceAttrs['targetDir']){
				targetDirPath = resourceAttrs['targetDir']
				if(targetDirPath=='dir') targetDirPath = resourceAttrs['dir']
			}else{
				if(type=='js') targetDirPath = ConfigurationHolder.config.webPerformance.defaultTargetDir.scripts
				else if(type=='css') targetDirPath = ConfigurationHolder.config.webPerformance.defaultTargetDir.styles
			}
			targetDirPath = targetDirPath.startsWith('/')?targetDirPath:'/'+targetDirPath
			String hexName = '_'+DigestUtils.md5Hex(name)+'.'+type
			String pluginPath = ''
			if(plugin) pluginPath = pluginManager.getPluginPath(plugin)
			String outputFilePath = servletContext.getRealPath(pluginPath+targetDirPath+File.separator+hexName)
			webResource.inputFilePath = inputFilePath
			webResource.outputFilePath = outputFilePath
			webResource.lastModifiedTime = new File(webResource.inputFilePath).lastModified()
			try{
				File outputFile = new File(outputFilePath)
				boolean compress = true
				if(!webResource.fileChanged || Environment.getCurrent().equals(Environment.PRODUCTION)) {
					if(outputFile.exists()){
						log.info("Configuring existing web resource; $name")
						compress = false
					}else{
						log.info("Compressing resource : $name")
						log.info("From file : $inputFilePath")
						log.info("To file: $outputFilePath")
					}
				}
				if(compress){
					File outputDir = outputFile.getParentFile()
					if(!outputDir.exists())outputDir.mkdirs()
					YUICompressor.main([
						inputFilePath,
						"--type", type,
						"--charset","utf-8",
						"-o", outputFilePath
					] as String[])
				}
				newResourcePath = servletContext.contextPath+pluginPath+targetDirPath+'/'+hexName
			}catch(Exception e){
				log.error("Unable to compress file: ${inputFilePath}")
				newResourcePath = g.resource(resourceAttrs)
			}
			webResource.resourcePath = newResourcePath
		}
		return webResource
	}

	def findResourcePath(attrs){
		def resourcePath = ''
		def plugin = attrs['plugin']
		if(plugin){
			resourcePath = pluginManager.getPluginPath(plugin)
		}
		def dir = attrs['dir']
		if (dir) {
			resourcePath = resourcePath + (dir.startsWith("/") ?  dir : "/${dir}")
		}
		def file = attrs['file']
		if (file) {
			resourcePath = resourcePath + (file.startsWith("/") || dir?.endsWith('/') ?  file : "/${file}")
		}
		return resourcePath
	}

}
