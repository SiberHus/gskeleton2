<%@ page import="com.siberhus.gskeleton.base.Message" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'message', default: 'Message')}" />
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
			<h2><gs:message code="default.edit.label" args="[entityName]" /></h2>
			<g:form method="post" >
				<g:hiddenField name="id" value="${instance?.id}" />
				<g:hiddenField name="version" value="${instance?.version}" />
				<g:render template="/base/message/formFields"/>
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
