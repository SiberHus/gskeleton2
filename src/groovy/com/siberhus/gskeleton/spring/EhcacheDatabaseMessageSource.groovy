package com.siberhus.gskeleton.spring

import java.text.MessageFormat;


import com.siberhus.gskeleton.base.Message
import net.sf.ehcache.Ehcache
import net.sf.ehcache.Element

class EhcacheDatabaseMessageSource extends DatabaseMessageSource {

	Ehcache messageCache

	
	public void clearCache() {
		logger.debug("Clearing entire resource bundle cache")
		messageCache.removeAll()
	}

	public void setMessageWithoutArguments(String code, Locale locale, String text){
		this.setMessage(code, locale, text)
	}

	public void setMessage(String code, Locale locale, String text){
		def key = new MessageKey(code,locale)
		def format
		if(text) {
			format = new MessageFormat(text, locale)
		}else {
			format = new MessageFormat(code, locale)
		}
		messageCache.put new Element(key, format)
	}

	@Override
	protected MessageFormat resolveCode(String code, Locale locale) {
		def key = new MessageKey(code,locale)
		def format = messageCache.get(key)?.value
		if(!format) {
			Message msg = Message.findByLanguageAndCode(locale.language, code)
			if(msg) {
				format = new MessageFormat(msg.text, locale)
				messageCache.put new Element(key, format)
				return format
			}
		}
		return format
	}

}
