package com.siberhus.gskeleton.config

import com.siberhus.gskeleton.cfg.SystemConfig

class ConfigurationException extends RuntimeException{

	private SystemConfig configDomain
	
	public ConfigurationException(SystemConfig configDomain){
		this.configDomain = configDomain
	}
	
	public ConfigurationException() {
		super();
	}
	
	public ConfigurationException(String message, Throwable cause) {
		super(message, cause);
	}

	public ConfigurationException(String message) {
		super(message);
	}

	public ConfigurationException(Throwable cause) {
		super(cause);
	}

	public SystemConfig getConfigDomain(){
		return configDomain
	}
	
}
