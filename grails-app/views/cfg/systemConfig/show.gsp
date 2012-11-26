<%@ page import="com.siberhus.gskeleton.cfg.SystemConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'systemConfig', default: 'System Config')}" />
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
									<gs:message code="systemConfig.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.name" default="Name" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "name")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.value" default="Value" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "value")}</td>	
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.description" default="Description" />:
								</td>
								<td valign="top" class="value" style="white-space: normal;">${fieldValue(bean: instance, field: "description")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.type" default="Type" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "type")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.required" default="Required" />:
								</td>	
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.required}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.multiValues" default="Multi Values" />:
								</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.multiValues}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="systemConfig.needRestart" default="Need Restart" />:
								</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.needRestart}" /></td>
							</tr>
							<g:render template="/commons/crud/showAuditFields" />
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit"  valueKey="btn.edit" value="Edit" icon="database_edit"/>
					&nbsp;&nbsp;
					<gs:linkSubmitButton action="list"  valueKey="btn.ok" value="OK" icon="database_go"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
