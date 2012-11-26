<%@ page import="com.siberhus.gskeleton.job.Job" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'job', default: 'Job')}" />
		<g:render template="/job/jobScheduler/resources" />
		<g:render template="/job/jobScheduler/cron/resources" />
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
			<h2><gs:message code="job.edit" default="Edit Job" /></h2>
			<g:render template="/job/jobScheduler/cron/builder" />
			<g:form method="post" >
				<g:hiddenField name="id" value="${instance?.id}" />
				<g:hiddenField name="version" value="${instance?.version}" />
				<g:render template="/job/jobScheduler/formFields" />
				<gs:buttonBar>
					<gs:linkSubmitButton action="update" valueKey="btn.update" value="Update" icon="database_save" />
					&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
