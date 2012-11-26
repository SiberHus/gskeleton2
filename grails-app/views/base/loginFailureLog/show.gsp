<%@ page import="com.siberhus.gskeleton.base.LoginFailureLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'loginFailureLog', default: 'Login Failure Log')}" />
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
									<gs:message code="loginFailureLog.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginFailureLog.username" default="Username" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "username")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginFailureLog.ipAddress" default="Ip Address" />:
								</td>
								<td valign="top" class="value">${instance.ipAddress}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginFailureLog.language" default="Language" />:
								</td>
								<td valign="top" class="value">${application['_languageMap'][instance.language]}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginFailureLog.userAgent" default="User Agent" />:
								</td>
								<td valign="top" class="value">${instance.userAgent}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="loginFailureLog.tryDate" default="Try Date" />:
								</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.tryDate}"/></td>
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
