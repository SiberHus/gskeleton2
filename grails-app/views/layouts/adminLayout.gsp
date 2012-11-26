<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><g:meta name="app.name"/> - ${controllerName }</title>
		<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<wp:styleBundle name="baseStyles" merge="true"/>
		<g:render template="/layouts/baseResources" plugin="gskeleton-two"/>
		<style type="text/css">
			#adminMenu li img{
				padding-right: 5px;
			}
			#adminMenu span.editMode{
				background-color: #fa8072;
				text-decoration: underline;
			}
		</style>
		<%-- ContextMenu Widget --%>
		<wp:style name="jquery.contextmenu"/>
		<wp:script name="jquery.contextmenu"/>
		<%-- Multiselect Widget --%>
		<wp:style name="jquery.multiselect"/>
		<wp:scriptBundle name="multiselectScripts"/>
		<%-- TreeView Widget  --%>
		<wp:style name="jquery.treeview"/>
		<wp:script name="jquery.treeview"/>
		<%--
		<!-- Date picker widget -->
		<link  href="${resource(dir:'widgets/anytime/assets',file:'anytimec.css')}" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${resource(dir:'widgets/anytime',file:'anytimec.js')}"></script>
		--%>
		<script type="text/javascript">
			$(function(){
				/* Script to provide the navigation menu with functionality */
				$('#adminMenu').treeview({
					cookie_name: 'gskeleton_adminMenu'
				});
				var openLinkCtxMenu = {};
				openLinkCtxMenu[I18N.lang('contextMenu.openLink')] = function(menuItem,menu) {
					var link = $(this).parent('a:has(span.text)');
					var href = link.attr('href');
					if(href){
						window.location.href = href;
					}
				};
				var i18nCtxMenu;
				<shiro:hasPermission permission="messageSource:*">
				i18nCtxMenu = {};
				i18nCtxMenu[I18N.lang('contextMenu.i18n')] = function(menuItem,menu) {
						textElem = $(this);
						$('#i18nCode').val($(this).attr('code'));
						var message = $.trim($(this).html());
						$('#i18nText').val(message);
						if($(this).attr('hasArgs')){
							$('#i18nHasArgs').val('true');
						}
						$('#i18nDialog').dialog('open');
				};
				var textElem;
				var i18nButtons = {};
				i18nButtons[I18N.lang('btn.close')] = function(){ $(this).dialog('close'); };
				i18nButtons[I18N.lang('btn.save')] = function(){
					$.post('${createLink(controller:'message',action:'ajaxSetMessage')}',{
						language:$('#i18nLanguage').val(),code:$('#i18nCode').val(),
						hasArgs:$('#i18nHasArgs').val(),text:$('#i18nText').val()
					},function(data){
						if(data=='ok'){
							$(textElem).html($('#i18nText').val());
						}
					});
					$(this).dialog('close');
				};
				$('#i18nDialog').dialog({
					modal: true, bgiframe: true, autoOpen: false,
					width: 400, height: 250,
					buttons: i18nButtons
				});
				</shiro:hasPermission>
				var contextMenu = [
					openLinkCtxMenu,
					$.contextMenu.separator,
					i18nCtxMenu,
					{'${message(code:'contextMenu.lookupDesc',default:'Look up description')}':function(menuItem,menu) { alert("Have not implemented yet"); } }
				];
				$(function() {
					$('span.text').contextMenu(contextMenu,{theme:'vista'});
				});
			});
		</script>
		<%
		    if(!session.noSelection){
				session.noSelection = ['':g.message(code:'crud.select.pleaseSelect',default:'Please Select...')]
				session.noSelection2 = ['null':g.message(code:'crud.select.pleaseSelect',default:'Please Select...')]
			}
		%>
		<g:layoutHead />
	</head>
	<body>
		<div id="wrapper">
			<div id="header" class="ui-widget-header">
				<div id="site">
					<a href="${gs.siteUrl()}" target="_self">
						<gs:message code="siteName" default="Site Name"/>
					</a>
				</div>
				<div id="info">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${createLink(controller:'auth',action:'signOut')}">
						<gs:message code="auth.signOut" default="Logout"/>
					</a>
				</div>
			</div>
			<div id="navigation" class="ui-widget-content">
				<br/>
				<gs:adminTreeMenu session="true"/>
				<br/><br/>
			</div>
			<div id="breadcrumb" class="ui-widget-content">
				<gs:adminBreadCrumbMenu/>
			</div>
			<div id="content">
				<g:if test="${flash.message}">
					<div class="ui-state-${flash.messageType=='error'?'error':'highlight'} ui-widget ui-corner-all" style="margin-top: 15px;">
						<div style="margin-top: 7px;">
							<span class="ui-icon ui-icon-${flash.messageType=='error'?'alert':'info'}" style="float: left; margin-right: .3em;"></span>
							<h6><gs:message code="message.${flash.messageType}"/></h6>
						</div>
						<ul>
							<li><gs:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></li>
						</ul>
					</div>
				</g:if>
				<g:else>
					<g:hasErrors bean="${instance}">
						<div class="ui-state-error ui-widget ui-corner-all" style="margin-top: 15px;">
							<div style="margin-top: 7px;">
								<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
								<h6><gs:message code="message.error"/></h6>
							</div>
							<g:renderErrors bean="${instance}" as="list" plugin="gskeleton-two"/>
						</div>
					</g:hasErrors>
				</g:else>
				<g:layoutBody />
				<br style="clear: both" />
			</div>
			<div id="footer">
				<div id="copyright">
					<a href="http://www.siberhus.com">SiberHus</a> &copy; Copyright 2010 - SiberHus Company</a> -  All rights Reserved
				</div>
				<div id="version">
					<a href="#top"><gs:message code="top" default="Top"/></a> |
					<a href="#"><gs:message code="document" default="Document"/></a> |
					Version <g:meta name="app.version"/>
				</div>
			</div>
			
			<div id="i18nDialog" title="Internationalization" class="dialog ui-widget hidden">
				<input type="hidden" id="i18nHasArgs" name="hasArgs" value="false"/>
				<table class="ui-widget-content" style="width:100%">
					<tr>
						<td><label><gs:message code="messageSource.language" default="Language" />:</label></td>
						<td>
							<input type="hidden" id="i18nLanguage" name="language"
								value="${response.locale.language}"/>
									${application['_languageMap'][response.locale.language] }
						</td>
					</tr>
					<tr>
						<td><label for="i18nCode"><gs:message code="message.code" default="Code" />:</label></td>
						<td><input id="i18nCode" type="text" style="width:100%" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><label for="i18nText"><gs:message code="message.message" default="Text" />:</label></td>
						<td><textarea id="i18nText" cols="20" rows="5" style="width:100%"></textarea></td>
					</tr>
				</table>
			</div>
		</div>	
	</body>
</html>