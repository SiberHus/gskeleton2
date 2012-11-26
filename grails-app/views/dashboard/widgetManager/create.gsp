<%@ page import="com.siberhus.gskeleton.dashboard.Widget" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'widget', default: 'Widget')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.create.label" args="[entityName]" /></h2>
			<g:form action="save" method="post" >
				<g:render template="/dashboard/widgetManager/formFields"/>
				<gs:buttonBar>
					<gs:linkSubmitButton action="save" valueKey="btn.create" value="Create" icon="database_save"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
