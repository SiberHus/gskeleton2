
<%@ page import="com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminLayout" />
		<title><g:message code="preferences" default="Preferences" /></title>
		<script type="text/javascript">
			$(function(){
				$('#language').change(function(){
					window.location.href = '${gs.createLink(action:"editPreferences",id:'?')}'
						+ '?lang='+$(this).val();
				});
			});
		</script>
	</head>
	<body>
		<g:render template="/base/personalProfile/personalBar" />
		<div class="body">
			<h2><gs:message code="personal.preferences" default="Preferences" /></h2>
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="personal.language" default="Language" />
								</td>
								<td valign="top" class="value">
									<g:select name="language" from="${application['_languageMap']}"
										value="${messageSourceInstance?.language?:response.locale.language}"
										optionKey="key" optionValue="value"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="personal.theme" default="Theme" />:
								</td>
								<td valign="top" class="value">
									<div id="themeswitcher" class="fg-buttonset fg-buttonset-multi"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
		</div>
	</body>
</html>
