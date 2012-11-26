package com.siberhus.gskeleton.spring

import java.text.SimpleDateFormat
import org.springframework.beans.propertyeditors.CustomDateEditor
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

import com.siberhus.gskeleton.base.User;
import com.siberhus.gskeleton.util.State;
import com.siberhus.gskeleton.config.SysConfig
import java.text.ParseException;

class DefaultPropertyEditorRegistrar implements PropertyEditorRegistrar {
	
	public void registerCustomEditors(PropertyEditorRegistry registry) {
		
		if(!State.get('gskeleton.config')){
			return
		}
		
		String localeStr = (SysConfig.get('converter.dateLocale')?:'en_US').split('_')
		Locale locale = new Locale(localeStr[0],localeStr[1])

		SimpleDateFormat dateFormat = new SimpleDateFormat(SysConfig.get('converter.datePattern'),locale)
		registry.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, true))

		registry.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(
				new SqlDateFormat(SysConfig.get('converter.datePattern'),locale), true))

		registry.registerCustomEditor(java.sql.Time.class, new CustomDateEditor(
				new SqlTimeFormat(SysConfig.get('converter.timePattern'),locale), true))

		SqlTimestampFormat sqlTimestampFormat = new SqlTimestampFormat(SysConfig.get('converter.datetimePattern'),locale)
		sqlTimestampFormat.dateFormat = dateFormat
		registry.registerCustomEditor(java.sql.Timestamp.class, new CustomDateEditor(sqlTimestampFormat, true))
		
	}
}


class SqlDateFormat extends SimpleDateFormat {
	public SqlDateFormat(String pattern, Locale locale){ super(pattern, locale) }
	public java.sql.Date parse(String source){
		Date d = super.parse(source)
		return new java.sql.Date(d.getTime())
	}
}
class SqlTimeFormat extends SimpleDateFormat {
	public SqlTimeFormat(String pattern, Locale locale){ super(pattern, locale) }
	public java.sql.Time parse(String source){
		Date d = super.parse(source)
		return new java.sql.Time(d.getTime())
	}
}
class SqlTimestampFormat extends SimpleDateFormat {
	protected SimpleDateFormat dateFormat
	public SqlTimestampFormat(String pattern, Locale locale){ super(pattern, locale) }
	public java.sql.Timestamp parse(String source){
		Date d
		try{
			d = super.parse(source)
		}catch(ParseException e){
			d = dateFormat.parse(source)
		}
		return new java.sql.Timestamp(d.getTime())
	}
}
