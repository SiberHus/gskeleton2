
<%@ page import="foo.bar.BreedType" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'breedType', default: 'BreedType')}" />
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
									<gs:message code="breedType.id" default="Id" />:
								</td>
								
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="id"/></td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="breedType.code" default="Code" />:
								</td>
								
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="code"/></td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="breedType.name" default="Name" />:
								</td>
								
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="name"/></td>
								
							</tr>
							
							
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" valueKey="crud.edit" value="Edit"
						icon="database_edit" />&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="crud.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
