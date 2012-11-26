<%@ page import="com.siberhus.gskeleton.job.ServiceExecutor" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutor', default: 'Service Executor')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
			<gs:linkButton action="create" class="create" icon="database_add">
				<gs:message code="default.new.label" args="[entityName]" />
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
									<gs:message code="serviceExecutor.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.name" default="Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="name"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.serviceName" default="Service Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="serviceName"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.methodName" default="Method Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="methodName"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.concurrent" default="Concurrent" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="concurrent"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.description" default="Description" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="description"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutor.serviceParameters" default="Service Parameters" />:
								</td>
								
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${instance?.serviceParameters}" var="serviceParameterInstance">
										<li>${serviceParameterInstance.encodeAsHTML()}</li>
									</g:each>
									</ul>
								</td>
								
							</tr>
							<g:render template="/commons/crud/showAuditFields" />
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" valueKey="btn.edit" value="Edit"
						icon="database_edit" />&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
