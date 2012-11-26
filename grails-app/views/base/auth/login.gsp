<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><g:message code="login" default="Login"/> </title>
	<wp:style name="reset"/>
	<wp:style name="typography"/>
	<wp:script name="jquery"/>
	<wp:script name="jquery.cookie"/>
	<wp:script name="browser-detect"/>
	<wp:style name="jquery-ui-${SysConfig.get('webUi.theme')}"/>
	<wp:script name="jquery-ui"/>
	<script type="text/javascript">
		var keyboard_png_path ="${gs.resource(dir:'ui/keyboard/assets',file:'keyboard.png')}";
		$(document).ready(function(){
			if(BrowserDetect.browser=='Explorer' && BrowserDetect.version<=6){
				alert('This site does not support Internet Explorer 6 or lower');
			}
			$('input[name=userAgent]').val(BrowserDetect.browser);
			$("input:submit", ".buttons").button();
			$('#lang').change(function(){
				var expiryDate = new Date();
				expiryDate.setYear(expiryDate.getYear()+2);
				$.cookie('gs_user_lang', $(this).val(), { expires: expiryDate, path: '/'});
			});
			var userLang = $.cookie('gs_user_lang');
			if(userLang!=null){
				$('#lang').val(userLang);
			}
		});
	</script>
	<wp:style name="keyboard"/>
	<wp:script name="keyboard"/>
</head>
<body>
<g:if test="${grails.util.GrailsUtil.isDevelopmentEnv()}">
	<g:set var="username" value="admin"/>
	<g:set var="password" value="password"/>
</g:if>

<g:form action="signIn">
	<input type="hidden" name="targetUri" value="${targetUri}" />
	<input type="hidden" name="userAgent"/>
	<div align="center" class="dialog" style="margin-top: 100px;">
		<g:if test="${flash.message}">
			<div class="ui-widget" style="width:400px;text-align:left;margin-bottom:15px;">
				<div class="ui-state-error ui-corner-all" style="margin-top: 15px;">
					<div style="margin-top: 7px;">
						<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
						<h6><gs:message code="message.error"/></h6>
					</div>
					${flash.message}
				</div>
			</div>
		</g:if>
		<table style="border: 1px solid #ccc;padding: 10px;">
			<tbody>
				<tr>
					<td>
						<label for="username">
							<g:message code="login.username" default="Username"/>
						</label>
					</td>
					<td><input id="username" type="text" name="username" value="${username}" /></td>
				</tr>
				<tr>
					<td>
						<label for="password">
							<g:message code="login.password" default="Password"/>
						</label>
					</td>
					<td>
						<input id="password" type="password" name="password" value="${password }" class="keyboardInput"/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="lang">
							<g:message code="login.langauge" default="Language"/>
						</label>
					</td>
					<td>
						<g:select name="lang" from="${application['_languageMap']}"
							optionKey="key" optionValue="value"
							value="${params.lang?:request.locale.language}" />
					</td>
				</tr>
				<g:if test="${com.siberhus.gskeleton.config.SysConfig.get('security.authc.rememberMe')}">
				<tr>
					<td>
						<label for="rememberMe">
							<g:message code="login.rememberMe" default="Remember me?"/>
						</label>
					</td>
					<td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
				</tr>
				</g:if>
				<tr>
					<td>&nbsp;</td>
					<td>
						<br/>
						<div class="buttons">
							<input type="submit" value="${message(code:'login.signin',default:'Sign in') }" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</g:form>

</body>
</html>
