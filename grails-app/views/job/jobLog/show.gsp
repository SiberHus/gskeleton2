<%@ page import="com.siberhus.gskeleton.job.JobLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'jobLog', default: 'Job Log')}" />
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
									<gs:message code="jobLog.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="jobLog.jobGroup" default="Job Group" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "jobGroup")}</td>
								<td valign="top" class="name">
									<gs:message code="jobLog.jobName" default="Job Name" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "jobName")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="jobLog.dateCreated" default="Start Date" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "createdDate")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="jobLog.lastUpdated" default="End Date" />:
								</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "modifiedDate")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="jobLog.status" default="Status" />:
								</td>
								<td valign="top" class="value">
									<strong>
										<g:if test="${instance?.status=='ERROR'}">
											<span style="color:red;"><gs:message code="jobLog.error" default="Error"/></span>
										</g:if>
										<g:elseif test="${instance?.status=='SUCCESS'}">
											<span style="color:blue;"><gs:message code="jobLog.success" default="Success"/></span>
										</g:elseif>
										<g:else>
											<gs:message code="jobLog.running" default="Running"/>
										</g:else>
									</strong>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="jobLog.message" default="Message" />:
								</td>
								<td valign="top" class="value" style="white-space: normal;">${fieldValue(bean: instance, field: "message")}</td>
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
