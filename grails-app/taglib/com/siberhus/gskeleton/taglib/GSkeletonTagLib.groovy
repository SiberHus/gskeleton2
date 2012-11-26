package com.siberhus.gskeleton.taglib

import com.siberhus.gskeleton.config.SysConfig
import com.siberhus.gskeleton.base.AdminMenu
import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.apache.commons.lang.StringUtils

import org.springframework.web.servlet.support.RequestContextUtils as RCU
import com.siberhus.gskeleton.spring.DatabaseMessageSource
import java.text.MessageFormat

/**
 * Built-in variables: controllerName, actionName
 *
 *
 * Note that Grails Taglib is singleton bean
 */
class GSkeletonTagLib {

	static final ADMIN_TREE_MENU_ATTR = '_adminMenu'
	static final PLUGIN_NAME = 'gskeleton-two'
	static namespace = 'gs'
	
	def siteUrl = {attrs->
		String siteUrl = request.isSecure()?SysConfig.get('siteUrl.https'):SysConfig.get('siteUrl')
		if(!siteUrl.endsWith('/')){
			siteUrl = siteUrl + '/'
			if(request.isSecure()){
				SysConfig.set('siteUrl.https',siteUrl)
			}else{
				SysConfig.set('siteUrl',siteUrl)
			}
		}
		String uri = attrs['uri']
		if(uri){
			if(uri.startsWith('/')){
				uri = uri.substring(1)
			}
			out << siteUrl + uri
		}
		out << siteUrl
	}
	
	def formatDate = { attrs ->
		attrs['format'] = SysConfig.get('converter.datePattern')
		if(!attrs['date']){
			return
		}
		out << g.formatDate(attrs)
	}

	def formatTime = { attrs ->
		attrs['format'] = SysConfig.get('converter.timePattern')
		if(!attrs['date']){
			return
		}
		out << g.formatDate(attrs)
	}

	def formatDatetime = { attrs ->
		attrs['format'] = SysConfig.get('converter.datetimePattern')
		if(!attrs['date']){
			return
		}
		out << g.formatDate(attrs)
//		out << DateFormatUtils.format(attrs['date'],
//				attrs['format'], SysConfig.get('converter.dateLocale')
	}

	def image = { attrs ->
		if(!attrs['border']){
			attrs['border'] = 0;
		}
		if(attrs['icon']){
			if(!attrs['alt']){
				attrs['alt'] = attrs['icon']
			}
			String iconFile = attrs['icon']
			if(!iconFile.contains('.')){
				iconFile+='.png'
			}
			attrs['width'] = '16'
			attrs['height'] = '16'
			out << "<img src=\"${g.resource(dir:'/images/icons',file:iconFile,plugin:attrs['plugin'])}\""
		}else{
			out << "<img src=\"${g.resource(dir:attrs['dir'], file:attrs['file'],plugin:attrs['plugin'])}\""
		}
		out << "${attrs.collect {k, v -> " $k=\"$v\"" }.join('')}>"
	}
	
	def message = { attrs ->
		if(attrs.args){
			out << "<span class=\"text\" code=\"${attrs.code}\" hasArgs=\"true\">"
		}else{
			out << "<span class=\"text\" code=\"${attrs.code}\">"
		}
		out << messageImpl(attrs)
		out << "</span>"
	}

	def buttonBar = { attrs, body ->
		if(!attrs.widget){
			attrs.widget= 'content'
		}
		out << "<div class=\"ui-widget-${attrs.widget} ui-corner-all ui-helper-clearfix\">"
		out << "<div class=\"buttons\">"
		out << body()
		out << "</div>\n</div>"
	}

	def link = {attrs ->
		def controller = attrs['controller']?:controllerName
		def action = attrs['action']?:actionName

		if(hasPermission(attrs, controller, action)){
			out << g.link(attrs)
		}
	}

	def linkSubmitButton = {attrs, body ->

		def form = attrs.remove('form')
		def action = attrs['action']?:actionName
		def icon = attrs.remove('icon')
		def onclick = attrs.remove('onclick')
		def confirm = attrs.remove('confirm')?true:false
		def confirmMessage = attrs.remove('confirmMessage')?:g.message(code:'crud.action.confirm',default:'Are you sure you want to perform this action?')
		def value = attrs.remove('value')
		def valueKey = attrs.remove('valueKey')

		if(!hasPermission(attrs, controllerName, action)){
			return
		}
		if(valueKey){
			value = gs.message([code:valueKey, default:value])
		}
		if(!attrs['class']){
			attrs['class'] = action
		}
		String onclickEvt =""
		if(confirm){
			onclickEvt = "if(!confirm('${confirmMessage}'))return false;"
		}		
		if(form){
			if(action){
				onclickEvt += "submitAction(document.getElementById('${form}'),'${action}');"
			}else{
				onclickEvt += "submitAction(document.getElementById('${form}'),null);"
			}
		}else{
			if(action){
				onclickEvt += "submitAction(document.forms[0],'${action}');"
			}else{
				onclickEvt += "document.forms[0].submit();"
			}
		}
		if(onclick){
			attrs['onclick'] = attrs['onclick']+';'+onclickEvt
		}else{
			attrs['onclick'] = onclickEvt
		}
		if(attrs['style']){
			attrs['style'] = attrs['style']+ ';cursor:pointer;'
		}else{
			attrs['style'] = 'cursor:pointer;'
		}
		out << "<a "
		out << "${attrs.collect {k, v -> " $k=\"$v\"" }.join('')}>"

		if(icon){
			if(!icon.contains('.')){
				icon+='.png'
			}
			out << "<img src=\"${g.resource(dir:'/images/icons',file:icon)}\"/>&nbsp;"
		}
		/*
		if(attrs['value']){
			if(attrs['valueDefault']){
				out << g.message(code:attrs['value'], default:attrs['valueDefault'])
			}else{
				out << g.message(code:attrs['value'])
			}
		}
		*/
		if(value){
			out << value
		}
		out << body()
		out << "</a>"
	}

	def linkButton = {attrs, body ->
		def controller = attrs['controller']?:controllerName
		def action = attrs['action']?:actionName
		def url = attrs['url']
		def icon = attrs.remove('icon')
		def confirm = attrs.remove('confirm')?true:false
		def confirmMessage = attrs.remove('confirmMessage')?:g.message(code:'crud.action.confirm',default:'Are you sure you want to perform this action?')
		def value = attrs.remove('value')
		def valueKey = attrs.remove('valueKey')
		if(!hasPermission(attrs, controller, action)){
			return
		}
		if(valueKey){
			value = gs.message([code:valueKey, default:value])
		}
		if(confirm){
			if(attrs['onclick'])
				attrs['onclick'] += ";if(!confirm('${confirmMessage}'))return false;"
			else
				attrs['onclick'] = "if(!confirm('${confirmMessage}'))return false;"
		}
		if(attrs['style']){
			attrs['style'] = attrs['style']+ ';cursor:pointer;'
		}else{
			attrs['style'] = 'cursor:pointer;'
		}
		if(url){
			out << "<a href=\"${url.encodeAsHTML()}\""
		}else{
			out <<  "<a href=\"${createLink(attrs).encodeAsHTML()}\" "
		}
		out << "${attrs.collect {k, v -> " $k=\"$v\"" }.join('')}>"
		if(icon){
			if(!icon.contains('.')){
				icon+='.png'
			}
			out << "<img src=\"${g.resource(dir:'/images/icons',file:icon)}\"/>"
		}
		if(value){
			out << value
		}
		out << body()
		out << "</a>"
	}
	
	def actionSubmit = {attrs ->
		def controller = attrs['controller']?:controllerName
		def action = attrs['action']?:actionName
		
		if(hasPermission(attrs, controller, action)){
			out << g.actionSubmit(attrs)
		}
	}

	def createLink = {attrs ->
		def controller = attrs['controller']?:controllerName
		def action = attrs['action']?:actionName

		if(hasPermission(attrs, controller, action)){
			out << g.createLink(attrs)
		}
	}
	
	def submitButton = {attrs ->
		def controller = attrs['controller']?:controllerName
		def action = attrs['action']?:actionName
		if(!attrs['name']){
			attrs['name'] = action
		}
		if(hasPermission(attrs, controller, action)){
			out << g.submitButton(attrs)
		}
	}

	def radio = {attrs ->
		def label = attrs.remove('label')
		def labelKey = attrs.remove('labelKey')
		def id = attrs['id']
		if(!id){
			id = attrs['name']+'.'+attrs['value']
			attrs['id'] = id
		}
		out << g.radio(attrs)
		if(labelKey){
			label = gs.message([code:labelKey, default:label])
		}
		if(label){
			out << "&nbsp;<label for=\"$id\">$label</label>"
		}
	}

	def checkbox = {attrs ->
		def label = attrs.remove('label')
		def labelKey = attrs.remove('labelKey')
		def id = attrs['id']
		if(!id){
			id = attrs['name']+'.'+attrs['value']
			attrs['id'] = id
		}
		out << g.checkbox(attrs)
		if(labelKey){
			label = gs.message([code:labelKey, default:label])
		}
		if(label){
			out << "&nbsp;<label for=\"$id\">$label</label>"
		}
	}

	def textArea = {attrs, body ->
		def value = attrs.remove('value')
		if(!value){
			attrs['value'] = body().trim()
		}
		out << g.textArea(attrs)
	}
	
	def layout = {attrs ->
		if(params.gs_popup){
			out << attrs['popup']
		}else{
			out << attrs['main']
		}
	}
	
	def ifPopupPage = {attrs, body ->
		if(params.gs_popup){
			out << body()
		}
	}

	def ifNotPopupPage = {attrs, body ->
		if(!params.gs_popup){
			out << body()
		}
	}

	def chooseLink = {attrs, body->
		def refValue = attrs.remove('refValue')
		def refLabel = attrs.remove('refLabel')
		def linkName = 'gs_chooseLink-'+refValue
		if(!refValue){
			throw new GrailsTagException('Missing required attribute "refValue"')
		}
		if(!refLabel){
			throw new GrailsTagException('Missing required attribute "refLabel"')
		}
		out << "<a class=\"gs_chooseItem\" name=\"${linkName}\" style=\"cursor:pointer;\" refValue=\"${refValue}\" refLabel=\"${refLabel}\">"
		if(attrs['icon']){
			out << gs.image(icon:attrs['icon'])
		}else{
			out << gs.image(icon:'mouse')
		}
		out << body()
		out << "</a>"
	}

	def fieldLookup = {attrs ->
		def name = attrs.remove('name')
		def value = attrs.remove('value')?:''
		def id = attrs.remove('id')?:name
		def type = attrs.remove('type')?:'text'
		def labelId = attrs.remove('labelId')?:id+'_label'
		def labelValue = attrs.remove('labelValue')?:value
		def lookupUrl = attrs.remove('lookupUrl')
		def readonly = attrs.remove('readonly')
		if(!name){
			throw new GrailsTagException('Missing required attribute "name"')
		}
		if(!lookupUrl){
			throw new GrailsTagException('Missing required attribute "lookupUrl"')
		}
		if(!labelValue){
			labelValue = ''
		}
		if(readonly){
			attrs['readonly'] = 'readonly'
		}
		out << "<input type=\"hidden\" id=\"${id}\" name=\"${name}\" value=\"${value}\"/>"
		if(type=='text'){
//			out << "<input type=\"text\" id=\"${labelId}\" value=\"${labelValue}\""
			out << "<input type=\"text\" id=\""+labelId+"\" value=\""+labelValue+"\""
			out << "${attrs.collect {k, v -> " $k=\"$v\"" }.join('')} />"
		}else{
			out << "<span id=\"${labelId}\""
			out << "${attrs.collect {k, v -> " $k=\"$v\"" }.join('')}>"
			out << "${labelValue}</span>"
		}
		out << "<a style=\"cursor:pointer;\" class=\"gs_unsetItem\" refvid=\"${id}\" reflid=\"${labelId}\">"
		out << "<img src=\"${resource(dir:'/images/icons',file:'delete.png')}\" border=\"0\"></a>"
		out << "<a style=\"cursor:pointer;\" class=\"gs_setItem\" refvid=\"${id}\" reflid=\"${labelId}\" lookupUrl=\"${lookupUrl}\">"
		out << "<img src=\"${resource(dir:'/images/icons',file:'add.png')}\" border=\"0\"></a>"
	}

	def listLookup = {attrs ->
		def lookupUrl = attrs.remove('lookupUrl')
		def refvid = attrs.remove('refvid')?:attrs['id']?:attrs['name']
		if(!lookupUrl){
			throw new GrailsTagException('Missing required attribute "lookupUrl"')
		}
		attrs['multiple'] = 'yes'
		if(!attrs['size']){
			attrs['size'] = 5
		}
		if(!attrs['optionKey']){
			attrs['optionKey'] = 'id'
		}
		if(attrs['class']){
			attrs['class'] = attrs['class']+ ' gs_multiLookup'
		}else{
			attrs['class'] = 'gs_multiLookup'
		}
		if(attrs['style']){
			attrs['style'] = attrs['style']+ ';cursor:pointer;'
		}else{
			attrs['style'] = 'cursor:pointer;'
		}

		out << "<table><tr><td>" << g.select(attrs) << "</td>"
		out << "<td><a class=\"gs_removeItem\" style=\"cursor:pointer;\" refvid=\"${refvid}\">"
		out << "<img src=\"${g.resource(dir:'/images/icons', file:'delete.png')}\"/></a>&nbsp;"
		out << "<a class=\"gs_addItem\" style=\"cursor:pointer;\" refvid=\"" << refvid << "\" lookupUrl=\""
		out << "${lookupUrl}\"><img src=\"${g.resource(dir:'/images/icons', file:'add.png')}\"/></a>"
		out << "</td></tr></table>"

	}
	
	def includePopupFields = {attrs->
		out << g.hiddenField(name:"gs_popup",value:"${params.gs_popup?'true':''}")
		out << g.hiddenField(name:"gs_multiselect",value:"${params.gs_multiselect?:'true' }")
		out << g.hiddenField(name:"gs_parentValueId",value:"${params.gs_parentValueId }")
		out << g.hiddenField(name:"gs_parentLabelId",value:"${params.gs_parentLabelId }")
	}

	def adminTreeMenu = {attrs->
		def sessionStore = attrs.remove('session')
		if(Boolean.valueOf(sessionStore?:'false') && controllerName != 'adminMenu'){
			def html = session[ADMIN_TREE_MENU_ATTR]
			if(html){
				out << html
			}else{
				html = generateAdminTreeMenu()
				session[ADMIN_TREE_MENU_ATTR] = html
				out << html
			}
		}else{
			out << generateAdminTreeMenu()
		}
	}

	def adminBreadCrumbMenu = {attrs->
		def sep = attrs.remove('sep')?:'&nbsp;>>&nbsp;'
		def html = new StringBuilder()
		def menus = AdminMenu.executeQuery('from AdminMenu am where am.controllerName = ? and am.actionName = ?',
					[controllerName, actionName])
		if(!menus){
			menus =  AdminMenu.executeQuery('from AdminMenu am where am.controllerName = ?',[controllerName])
			if(!menus){
				def url = StringUtils.substringBefore(request.servletPath,'?')
				menus = AdminMenu.executeQuery('from AdminMenu am where am.targetUrl like ?',[url+'%'])
				if(!menus){
					if(request.servletPath.startsWith('/')){
						url = '/'+StringUtils.substringBefore(request.servletPath.substring(1),'/')
						menus = AdminMenu.executeQuery('from AdminMenu am where am.targetUrl like ?',[url+'%'])
					}
				}
			}
		}
		if(menus){
			def menu = menus[0]
			while(true){
				if(!menu){
					break
				}
				String url = getAdminMenuUrl(menu)
				String label = gs.message([code:menu.labelKey,default:menu.label])
				String menuStr = "${sep}<a href=\"${url}\" target=\"_self\">${label}</a>"
				html.insert(0, menuStr)
				menu = menu.parent
			}
		}
		out << html
	}

	def resource = {attrs->
		attrs['plugin'] = PLUGIN_NAME
		out << g.resource(attrs)
	}

	def javascript = {attrs->
		attrs['plugin'] = PLUGIN_NAME
		out << g.javascript(attrs)
	}

	//*********************************** METHODS ****************************************//
	def messageImpl(attrs) {
		def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
		def locale = attrs.locale ?: RCU.getLocale(request)
		def text
		//we don't resolve error because it is intentionally used inside Grails framework only.
		if (attrs['code']) {
			def code = attrs['code']
			def args = attrs['args']
			def defaultMessage = attrs['default'] != null ? attrs['default'] : code
			if(messageSource instanceof DatabaseMessageSource){
				if(args==null){
					text = messageSource.resolveCodeWithoutArguments(code, locale)
				}else{
					MessageFormat messageFormat = messageSource.resolveCode(code, locale)
					if (messageFormat != null) {
						synchronized (messageFormat) {
							text = messageFormat.format(args.toArray());
						}
					}
				}
				if(text==null){
					if(args==null) messageSource.setMessageWithoutArguments(code, locale, defaultMessage)
					else messageSource.setMessage(code, locale, defaultMessage)
					text = defaultMessage
				}
			}else{
				def message = messageSource.getMessage(code, args == null ? null : args.toArray(),
					defaultMessage, locale)
				if (message != null) {
					text = message
				}else {
					text = defaultMessage
				}
			}
		}
		if (text) {
			return (attrs.encodeAs ? text."encodeAs${attrs.encodeAs}"() : text)
		}
		return ''
	}

	def generateAdminTreeMenu(){
		def adminMenues = AdminMenu.executeQuery('from AdminMenu am where am.parent is null order by am.menuOrder asc')
		def html = new StringBuilder()
		html << "<ul id=\"adminMenu\">"
		if(controllerName=='adminMenu'){
			html << "<span class=\"editMode\">${gs.message(code:'adminMenu.editMode',default:'Edit Mode')}</span>"
		}

		for(menu in adminMenues){
			addAdminTreeMenuItem(menu, html)
		}
		return "${html}</ul>"
	}

	def addAdminTreeMenuItem(menu, html){
		def editMode = false
		if(controllerName == 'adminMenu'){
			editMode = true
		}
		def roles = []
		menu.roles.each{
			roles << it.name
		}
		if(roles){
			if(!SecurityUtils.subject.hasRoles(roles).any()){
				return
			}
		}
		if(!editMode && menu.status=='H'){
			return
		}
		html<<"<li id='${menu.id}'>"
		String label = gs.message([code:menu.labelKey,default:menu.label])
		String url = null
		String targetName = null
		if(editMode){
			targetName = '_self'
			url = g.createLink([controller:'adminMenu',action:'edit',id:menu.id])
		}else{
			targetName = menu.targetName
			url = getAdminMenuUrl(menu)
		}

		def status
		if(editMode)
			if(menu.status=='A') status = 'a'
			else if(menu.status=='I') status = 'i'
			else status = 'h'
		html<<"<a class='menu $status' href='${url}' "
		if(targetName){
			html<<"target='${targetName}'"
		}
		html << ">"
		if(menu.imageIcon){
			html << "<img src=\"${g.resource(file:menu.imageIcon)}\"/>"
		}
		html << "${label}</a>"
		if(menu.children){
			html<<"<ul>"
			def menuChildren = AdminMenu.findAllByParent(menu, [sort:'menuOrder',order:'asc'])
			for(child in menuChildren){
				addAdminTreeMenuItem(child, html)
			}
			html<<"</ul>"
		}
		html<<"</li>"
	}

	def getAdminMenuUrl(def menu){
		def url
		if(menu.targetUrl){
			url = menu.targetUrl
			if(menu.status=='I'){
				url = '#'
			}
			if(url.startsWith('/')){
				url = servletContext.contextPath+url
			}
			if(url.contains('?')){
				String parameters = StringUtils.substringAfter(url, "?");
				if(parameters!=null){
					url = StringUtils.substringBefore(url, "?");
					try {
						parameters = URLEncoder.encode(parameters,"UTF-8");
					} catch (UnsupportedEncodingException e) {}
					url = url+"?"+parameters;
				}
			}
		}else{
			url = g.createLink([controller:menu.controllerName,action:menu.actionName])
		}
		return url
	}

	static boolean hasPermission(attrs, controllerName, actionName){
		def permission;
		if(!attrs['controller']){
			permission = controllerName
		}else{
			permission = attrs['controller']
		}
		if(!attrs['action']){
			permission += ':'+actionName
		}else{
			permission += ':'+attrs['action']
		}
		attrs['permission'] = permission
		return SecurityUtils.subject.isPermitted(permission)
	}
}