<%@ page import="com.siberhus.gskeleton.cfg.SystemConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'systemConfig', default: 'System Config')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.edit.label" args="[entityName]" /></h2>
			<g:form method="post" >
				<g:hiddenField name="id" value="${instance?.id}" />
				<g:hiddenField name="version" value="${instance?.version}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="name">
										<gs:message code="systemConfig.name" default="Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:hiddenField name="name" value="${fieldValue(bean: instance, field: 'name')}"/>
									${fieldValue(bean: instance, field: 'name')}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="value">
										<gs:message code="systemConfig.value" default="Value" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'value', 'errors')}">
									<g:textArea rows="7"  name="value" value="${instance?.value}" style="width:500px"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="systemConfig.description" default="Description" />
									</label>
								</td>
								<td valign="top" class="value" style="white-space: normal;">
									${fieldValue(bean: instance, field: 'description')}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="systemConfig.type" default="Type" />
									</label>
								</td>
								<td valign="top" class="value">
									${instance?.type}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="systemConfig.required" default="Required" />
									</label>
								</td>
								<td valign="top" class="value">
									${instance?.required}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="systemConfig.multiValues" default="Multi Values" />
									</label>
								</td>
								<td valign="top" class="value">
									${instance?.multiValues}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="systemConfig.needRestart" default="Need Restart" />
									</label>
								</td>
								<td valign="top" class="value">
									${instance?.needRestart}
								</td>
							</tr>
							
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="update" valueKey="btn.update" value="Update" icon="database_save"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
