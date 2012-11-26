package com.siberhus.gskeleton.init

import java.util.Locale;

import org.apache.commons.beanutils.ConvertUtils;

import com.siberhus.gskeleton.config.SysConfig;
import com.siberhus.gskeleton.util.TemporalTypeConverter;

class DefaultCommonsConverterRegistrar implements CommonsConverterRegistrar {
	
	
	@Override
	public void registerConverters() {
		
		String localeStr = (SysConfig.get('converter.dateLocale')?:'en_US').split('_')
		Locale locale = new Locale(localeStr[0],localeStr[1])
		
		TemporalTypeConverter converter = new TemporalTypeConverter(Date.class)
		converter.setLocale(locale)
		converter.setPattern(SysConfig.get('converter.datePattern'))
		ConvertUtils.register(converter, java.util.Date.class)
		
		converter = new TemporalTypeConverter(java.sql.Date.class)
		converter.setLocale(locale)
		converter.setPattern(SysConfig.get('converter.datePattern'))
		ConvertUtils.register(converter, java.sql.Date.class)
		
		converter = new TemporalTypeConverter(java.sql.Timestamp.class)
		converter.setLocale(locale)
		converter.setPattern(SysConfig.get('converter.datetimePattern'))
		ConvertUtils.register(converter, java.sql.Timestamp.class)
		
		converter = new TemporalTypeConverter(java.sql.Time.class)
		converter.setLocale(locale)
		converter.setPattern(SysConfig.get('converter.timePattern'))
		ConvertUtils.register(converter, java.sql.Time.class)
		
	}
	
	
}
