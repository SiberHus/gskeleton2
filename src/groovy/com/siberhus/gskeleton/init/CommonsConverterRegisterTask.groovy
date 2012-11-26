package com.siberhus.gskeleton.init;

import java.util.Collection;

class CommonsConverterRegisterTask extends Thread {
	
	Collection<CommonsConverterRegistrar> registrars;
	
	public CommonsConverterRegisterTask(Collection<CommonsConverterRegistrar> registrars){
		this.registrars = registrars;
	}
	
	public void run(){
		
		for(CommonsConverterRegistrar registrar in registrars){
			registrar.registerConverters()
		}
	}
	
}
