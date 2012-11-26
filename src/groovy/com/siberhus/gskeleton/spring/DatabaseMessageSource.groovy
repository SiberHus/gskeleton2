package com.siberhus.gskeleton.spring

import org.springframework.context.support.AbstractMessageSource

/**
 * Created by IntelliJ IDEA.
 * User: hussachai
 * Date: Sep 25, 2010
 * Time: 8:17:58 PM
 * To change this template use File | Settings | File Templates.
 */
abstract class DatabaseMessageSource extends AbstractMessageSource {

	public abstract void clearCache()

	public abstract void setMessageWithoutArguments(String code, Locale locale, String text)

	public abstract void setMessage(String code, Locale locale, String text)
	
}
