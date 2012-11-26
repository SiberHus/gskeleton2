<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminLayout" />
		<title><g:message code="customConfig.theme" default="Theme" /></title>
		<style type="text/css">
			table.themeTbl td{
				text-align: center;
			}
		</style>
	</head>
	<body>
		<div class="body">
			<h2><gs:message code="customConfig.theme" default="Theme" /></h2>
			<g:set var="currentTheme" value="${SysConfig.get('webUi.theme')}"/>
			<div class="ui-widget ui-state-highlight ui-corner-all">
				<gs:message code="customConfig.currentTheme" default="Current Theme :"/>&nbsp;
				<gs:message code="theme.${currentTheme}" default="${currentTheme}"/>
			</div>
			<br/>
			<%
				def themes = [
					'ui-lightness','ui-darkness','smoothness','start',
					'redmond','sunny','overcast','le-frog',
					'flick','pepper-grinder','eggplant','dark-hive',
					'cupertino','south-street','blitzer','humanity',
					'hot-sneaks','excite-bike','vader','dot-luv',
					'mint-choc','black-tie','trontastic','swanky-purse'
				]
			%>
			<g:form>
				<g:set var="themeImgDir" value="/ui/jquery-ui/assets/images" />
				<div class="list">
					<table class="themeTbl">
						<tbody>
							<g:each in="${themes}" status="i" var="theme">
							<g:if test="${(i % 4) == 0}"><tr></g:if>
								<td class="${currentTheme==theme?'ui-state-highlight ui-corner-all':''}">
									<image src="${resource(dir:themeImgDir,file:theme+'.png')}"/>
									<br/>
									<input type="radio" id="${theme}" value="${theme}"
										name="theme" ${currentTheme==theme?'checked="checked"':''}/>
									<label for="${theme}">
										<gs:message code="theme.${theme}" default="${theme}"/> 
									</label>
								</td>
							<g:if test="${(i % 4) == 3}"></tr></g:if>
							</g:each>
						</tbody>
					</table>
				</div>
				<br/>
				<gs:buttonBar>
					<gs:linkSubmitButton action="updateTheme" valueKey="btn.update" value="Update" icon="database_save" />
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
