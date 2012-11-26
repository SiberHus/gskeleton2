package com.siberhus.gskeleton.init

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


import org.springframework.web.context.support.ServletContextResourceLoader;
import com.siberhus.gskeleton.base.Message;
import com.siberhus.gskeleton.config.SysConfig

class LocalizationInit  {
	
	private static final Log log = LogFactory.getLog(LocalizationInit.class);
	
	public void init(def servletContext){
		
		log.debug "Initializing locale configurations"
//		ServletContextResourceLoader resourceLoader = new ServletContextResourceLoader(servletContext)
		Set<String> langSet = new HashSet<String>()
		Map<String, String> langCodeNameMap = new TreeMap<String, String>();
		for(Locale locale : Locale.getAvailableLocales()){
			langSet.add(locale.language)
			langCodeNameMap.put(locale.getLanguage(),
				locale.getDisplayLanguage(locale));
		}
		
		servletContext.setAttribute(SysConfig.get('i18n.languageMap'), langCodeNameMap)
		log.debug 'LanguageMap was installed to ServletContext\'s attribute name: '+SysConfig.get('i18n.languageMap')
		
		if(SysConfig.get('i18n.loadOnStartup'))
		log.info 'Loading i18n from files'
		for(String lang in SysConfig.get('i18n.loadLangs')){
			log.info 'Loading i18n files for language: '+lang
			if(!langSet.contains(lang)){
				throw new IllegalArgumentException("Unsupported language: $lang")
			}
			String propsResourceName = '/'+SysConfig.get('i18n.loadBasename')+'_'+lang+'.properities'
			InputStream propsInStream = getClass().getResourceAsStream(propsResourceName)
//			Resource propsResource = resourceLoader.getResource(SysConfig.get('i18n.loadBasename')+'_'+lang+'.properties')
			if(propsInStream){
				log.info 'Found resource: '+propsResourceName
				Properties props = new Properties()
				Reader reader = new InputStreamReader(propsInStream,'UTF-8')
				props.load(reader)
				Enumeration<String> propNames = props.propertyNames()
				while(propNames.hasMoreElements()){
					String code = propNames.nextElement()
					String text = props.getProperty(code)
					updateMessage(lang, code, text)
				}
				IOUtils.closeQuietly(reader)
			}

			String txtResourceName = '/'+SysConfig.get('i18n.loadBasename')+'_'+lang+'.txt'
			InputStream txtInStream = getClass().getResourceAsStream(txtResourceName)
//			Resource txtResource = resourceLoader.getResource(SysConfig.get('i18n.loadBasename')+'_'+lang+'.txt')
			if(txtInStream){
				log.info 'Found resource: '+txtResourceName
				BufferedReader reader = new BufferedReader(new InputStreamReader(txtInStream,'UTF-8'))
				String line = reader.readLine()
				while( (line = reader.readLine())!=null ){
					int eqPos = line.indexOf('=')
					if(eqPos!=-1){
						String code = line.substring(0, eqPos)
						String text = line.substring(eqPos+1, line.length())
						updateMessage(lang, code, text)
					}
				}
				IOUtils.closeQuietly(reader)
			}
			
		}
	}
	
	private void updateMessage(String lang, String code, String text){
		Message instance = Message.findByLanguageAndCode(lang, code)
		if(instance){
			if(instance.text != text){
				instance.text = text
			}
		}else{
			instance = new Message([language:lang, code: code, text:text])
		}
		try{
			instance.save()
		}catch(Exception e){
			log.warn("Could not insert message: $instance")
		}
	}
}
