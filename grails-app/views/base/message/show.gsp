<%@ page import="com.siberhus.gskeleton.base.Message" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
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
			<h2><gs:message code="default.show.label" args="[entityName]" /></h2>
			<g:form>
				<g:hiddenField name="id" value="${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="message.id" default="Id" />:
								</td>
									<td valign="top" class="value">${instance?.id}</td>
								</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="message.language" default="Language" />:
								</td>
									<td valign="top" class="value">${application['_languageMap'][instance?.language]}</td>
								</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="message.code" default="Code" />:
								</td>
									<td valign="top" class="value"><g:fieldValue bean="${instance}" field="code"/></td>
								</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="message.text" default="Text" />:
								</td>
									<td valign="top" class="value"><g:fieldValue bean="${instance}" field="text"/></td>
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
