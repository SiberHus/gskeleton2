package com.siberhus.gskeleton.spring

import java.text.MessageFormat;
import java.util.concurrent.ConcurrentHashMap;


import com.siberhus.gskeleton.base.Message

class MapCacheDatabaseMessageSource extends DatabaseMessageSource {
	
	Map<String, Map<String,String>> stringCache = new ConcurrentHashMap<String, Map<String,String>>()
	Map<String, Map<String,MessageFormat>> messageFormatCache = new ConcurrentHashMap<String, Map<String,MessageFormat>>()
	
	public void clearCache() {
		logger.debug("Clearing entire resource bundle cache")
		stringCache.clear()
		messageFormatCache.clear()
	}

	public void setMessageWithoutArguments(String code, Locale locale, String text){
		String lang = locale.getLanguage()
		Map<String, String> cache = stringCache.get(lang)
		if(cache!=null){
			cache.put(code, text)
		}
	}

	public void setMessage(String code, Locale locale, String text){
		String lang = locale.getLanguage()
		Map<String, MessageFormat> cache = messageFormatCache.get(lang)
		if(cache!=null){
			cache.put(code, new MessageFormat((text != null ? text : ""), locale))
		}
	}

	@Override
	protected String resolveCodeWithoutArguments(String code, Locale locale) {
		String lang = locale.getLanguage()
		Map<String, String> cache = stringCache.get(lang)
		if(cache==null){
			cache = new ConcurrentHashMap<String, String>()
			stringCache.put(lang, cache)
		}
		String text = cache.get(code)
		if(!text){
			text = Message.findByLanguageAndCode(lang,code)
			if(text){
				cache.put(code, text)
			}
		}
		
		return text
	}
	
	@Override
	protected MessageFormat resolveCode(String code, Locale locale) {
		String lang = locale.getLanguage()
		Map<String, MessageFormat> cache = messageFormatCache.get(lang)
		if(cache==null){
			cache = new ConcurrentHashMap<String, MessageFormat>()
			messageFormatCache.put(lang, cache)
		}
		MessageFormat messageFormat = cache.get(code)
		if(!messageFormat){
			String text = Message.findByLanguageAndCode(lang,code)
			if(text){
				messageFormat = new MessageFormat((text != null ? text : ""), locale)
				cache.put(code, messageFormat)
			}
		}
		
		return messageFormat
	}
	
}
