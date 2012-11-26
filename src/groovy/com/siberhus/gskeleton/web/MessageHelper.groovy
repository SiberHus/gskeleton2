package com.siberhus.gskeleton.web

import org.apache.commons.lang.StringUtils 
import org.apache.commons.lang.exception.ExceptionUtils 

class MessageHelper {

	public static def setInfoMessage(def flash, String message, String defaultMessage, def args){
		flash.messageType = "info"
		flash.message = message
		flash.args = args
		flash.defaultMessage = defaultMessage
	}

	public static def setWarningMessage(def flash, String message, String defaultMessage, def args){
		flash.messageType = "warn"
		flash.message = message
		flash.args = args
		flash.defaultMessage = defaultMessage
	}

	public static def setErrorMessage(def flash, String message, String defaultMessage, def args){
		flash.messageType = "error"
		flash.message = message
		flash.args = args
		flash.defaultMessage = defaultMessage
	}

	public static def setErrorMessage(def flash, Throwable e){
		flash.messageType = "error"
		flash.message = "_error"
		flash.args = [e, toString(e)]
		flash.defaultMessage = toString(e)
	}
	
	public static String toString(Throwable e){
		Throwable rootCause = ExceptionUtils.getRootCause(e);
		if(rootCause!=null){
			e = rootCause;
		}
		if(!StringUtils.isBlank(e.getMessage())){
			return e.getMessage();
		}
		return e.getClass().getSimpleName();
	}
	
}
