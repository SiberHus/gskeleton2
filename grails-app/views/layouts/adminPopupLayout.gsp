<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><g:meta name="app.name"/> - ${controllerName }</title>
		<link rel="shortcut icon" href="${gs.resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<link href="${gs.resource(dir:'css',file:'reset.css')}" rel="stylesheet" type="text/css" />
		<link href="${gs.resource(dir:'css',file:'typography.css')}" rel="stylesheet" type="text/css" />
		<link href="${gs.resource(dir:'css',file:'admin_layout.css')}" rel="stylesheet" type="text/css" />
		<link href="${gs.resource(dir:'css',file:'admin_style.css')}" rel="stylesheet" type="text/css" />
		<g:render template="/layouts/baseResources" plugin="gskeleton-two"/>
		
		<!-- Multiselect Widget -->
		<link href="${gs.resource(dir:'ui/multiselect/assets',file:'ui.multiselect.css')}" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${gs.resource(dir:'ui/multiselect/plugins/localisation',file:'jquery.localisation.js')}"></script>
		<script type="text/javascript" src="${gs.resource(dir:'ui/multiselect/plugins/scrollTo',file:'jquery.scrollTo.js')}"></script>
		<script type="text/javascript" src="${gs.resource(dir:'ui/multiselect',file:'ui.multiselect.js')}"></script>
		
		<g:layoutHead />
	</head>
	<body>
		<div id="wrapper">
			<div id="content_popup">
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
		</div>
	</body>
</html>