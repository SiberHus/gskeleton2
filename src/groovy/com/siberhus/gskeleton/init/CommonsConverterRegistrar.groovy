package com.siberhus.gskeleton.init

/**
 * Because Commons BeanUtils Converter keeps the registered coverters in psudo-singleton scope
 * not static (singleton scope). It will create new BeanUtilsBean object when it detects that 
 * the caller class is in difference class loader. The problem in grails is Bootstrap class
 * is load in the GrailsClassLoader which is the wrapper of native class loader but
 * others class such as Controller, GSP, Taglib are executed in native class loader.
 * 
 * Register converters inside registerConverters() method will be visible to both class loader.
 * 
 * @author hussachai
 *
 */
interface CommonsConverterRegistrar {
	
	public void registerConverters();
	
}
