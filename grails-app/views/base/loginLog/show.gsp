<%@ page import="com.siberhus.gskeleton.base.LoginLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'loginLog', default: 'Login Log')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.show.label" args="[entityName]" /></h2>
			<g:form>
				<g:hiddenField name="id" value="${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.username" default="Username" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="username"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.ipAddress" default="Ip Address" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="ipAddress"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.language" default="Language" />:
								</td>
								<td valign="top" class="value">${application['_languageMap'][instance.language]}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.userAgent" default="User Agent" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="userAgent"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.loginDate" default="Login Date" />:
								</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.loginDate}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.logoutDate" default="Logout Date" />:
								</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.logoutDate}" /></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginLog.manLogout" default="Man Logout" />:
								</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.manLogout}" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
