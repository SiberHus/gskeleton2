<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}', default: '${className}')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.create.label" args="[entityName]" /></h2>
			<g:form action="save" method="post" <%= multiPart ? " enctype=\"multipart/form-data\"" : "" %>>
				<g:render template="formFields"/>
				<gs:buttonBar>
					<gs:linkSubmitButton action="save" valueKey="crud.create" value="Create" icon="database_save"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
