<%@ page import="com.siberhus.commons.util.ElapsedTimeUtils; com.siberhus.gskeleton.job.ServiceExecutionLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutionLog', default: 'Service Execution Log')}" />
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
									<gs:message code="serviceExecutionLog.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutionLog.serviceExecutorName" default="Service Executor Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="serviceExecutorName"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutionLog.serviceParameters" default="Service Parameters" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="serviceParameters"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutionLog.requestedBy" default="Requested By" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="requestedBy"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutionLog.status" default="Status" />:
								</td>
								<td valign="top" class="value"><gs:message code="status.${instance?.status}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="serviceExecutionLog.errorMessage" default="Error Message" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="errorMessage"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutionLog.startDatetime" default="Start Date/Time" />:</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.createdDate}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutionLog.finishDatetime" default="Finish Date/Time" />:</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.modifiedDate}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutionLog.elapseTime" default="Elapsed Time" />:</td>
								<td valign="top" class="value">
									<g:if test="${instance?.modifiedDate}">
										<%
											def elapsedTime = (instance?.modifiedDate?.time - instance?.createdDate.time)
										%>
										${ElapsedTimeUtils.formatTime(elapsedTime, ElapsedTimeUtils.FORMAT_MEDIUM)}
									</g:if>
								</td>
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
