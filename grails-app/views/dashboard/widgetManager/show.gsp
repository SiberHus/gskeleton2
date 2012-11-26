<%@ page import="com.siberhus.gskeleton.dashboard.Widget" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'widget', default: 'Widget')}" />
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
									<gs:message code="widget.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.code" default="Code" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="code"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.name" default="Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="name"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.contentPath" default="Content Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="contentPath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.description" default="Description" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="description"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.status" default="Status" />:
								</td>
								<td valign="top" class="value"><gs:message code="status.${instance?.status}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.defaultPosition" default="Default Position" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="defaultPosition"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="widget.roles" default="Roles" />:
								</td>
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${instance?.roles}" var="roleInstance">
										<li><g:link controller="role" action="show" id="${roleInstance.id}">${roleInstance.encodeAsHTML()}</g:link></li>
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