
<%@ page import="com.siberhus.gskeleton.job.Job" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'job', default: 'Job')}" />
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
								<td valign="top" class="name"><gs:message code="job.id" default="Id" />:</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.name" default="Name" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "name")}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.serviceName" default="Service Name" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "serviceName")}</td>
								<td valign="top" class="name"><gs:message code="job.methodName" default="Method Name" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "methodName")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.concurrent" default="Concurrent" />:</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.concurrent}" /></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.triggerType" default="Trigger Type" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "triggerType")}</td>
							</tr>
							
							<g:if test="${instance.triggerType=='cron'}">
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.cronExp" default="Cron Exp" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "cronExp")}</td>
							</tr>
							</g:if>
							
							<g:if test="${instance.triggerType=='repeat'}">
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.repeatInterval" default="Repeat Interval" />:</td>
								<td valign="top" class="value">
									${instance.repeatInterval}&nbsp;
									${instance.timeUnit}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.repeatCount" default="Repeat Count" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "repeatCount")}</td>
							</tr>
							</g:if>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.startTime" default="Start Time" />:</td>
								<td valign="top" class="value">${gs.formatDatetime(date:instance.startTime)}</td>
								<td valign="top" class="name"><gs:message code="job.endTime" default="End Time" />:</td>
								<td valign="top" class="value">${gs.formatDatetime(date:instance.endTime)}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="job.description" default="Description" />:</td>
								<td colspan="3" valign="top" class="value">${fieldValue(bean: instance, field: "description")}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="status" default="Status" />:</td>
								<td valign="top" class="value"><gs:message code="status.${instance.status}"/> </td>
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
