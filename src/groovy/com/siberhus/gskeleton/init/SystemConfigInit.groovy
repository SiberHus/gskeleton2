package com.siberhus.gskeleton.init;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.siberhus.gskeleton.cfg.SystemConfig;
import com.siberhus.gskeleton.util.State;


import org.springframework.core.io.ClassPathResource
import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.config.ConfigurationException

public class SystemConfigInit {
	
	private static final Log log = LogFactory.getLog(SystemConfigInit.class);
	
	public void init(){
		
		log.info "Installing system configurations"
		
		boolean install = false
		try{
			install = SysConfig.get('install')
		}catch(Exception e){
			install = true
		}
		
		boolean upgrade = false
		try{
			upgrade = SysConfig.get('upgrade')
		}catch(Exception e){}
		
		if(install==false && upgrade==false){
			log.info "Skip install/upgrade system configuration process."
			State.set('gskeleton.config', 'ready')
			return
		}
		if(install) log.info "Start installing system configurations."
		if(upgrade) log.info "Start upgrading system configurations."
		
		InputStream propsIs = new ClassPathResource("gskeleton.properties").getInputStream()
		Properties props = new Properties()
		props.load propsIs
		Enumeration<String> propNames = props.propertyNames()
		while(propNames.hasMoreElements()){			
			String propName = propNames.nextElement()
			String propValue = props.getProperty(propName)
			if(propName.endsWith("_desc") || propName.endsWith("_attrs")){
				continue
			}
			String propDesc = props.getProperty(propName+"_desc")
			def params = [name:propName,value:propValue,description:propDesc];
			def attrs = props.getProperty(propName+"_attrs")?.split(":")
			if(attrs){
				params+= [type:attrs[0],required:attrs[1],multiValues:attrs[2],needRestart:attrs[3]]
			}
			
			SystemConfig config = null
			if(upgrade){
				config = SystemConfig.findByName(propName)
				if(config==null){
					config = new SystemConfig(params)
					config.save(flush:true)
				}else{
					config.properties = params
				}
			}else{
				config = new SystemConfig(params)				
			}
			config.save(flush:true)
			if (!config.save()) {
				config.errors.allErrors.each { log.error it }
				throw new ConfigurationException("Unable to save configuration: $params ")
			}
		}
		
		State.set('gskeleton.config', 'ready')
		SysConfig.set('install', 'false')
		SysConfig.set('upgrade', 'false')
		log.info "All system configuration was installed successful"
		log.info "Total configuration = "+SystemConfig.count()
	}
	
	
}
