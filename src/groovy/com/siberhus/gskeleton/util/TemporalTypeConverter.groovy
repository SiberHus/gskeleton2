package com.siberhus.gskeleton.util;

import org.apache.commons.beanutils.converters.DateTimeConverter;

public class TemporalTypeConverter extends DateTimeConverter{
	
	Class defaultType;
	
	public TemporalTypeConverter(Class defaultType){
		this.defaultType = defaultType;
	}
	
	@Override
	protected Class getDefaultType() {
		return defaultType;
	}
	
}