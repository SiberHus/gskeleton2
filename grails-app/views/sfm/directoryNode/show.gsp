<%@ page import="com.siberhus.gskeleton.sfm.DirectoryNode" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'directoryNode', default: 'Directory Node')}" />
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
									<gs:message code="directoryNode.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.name" default="Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="name"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.directoryPath" default="Directory Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="directoryPath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.recycleBinPath" default="Recycle Bin Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="recycleBinPath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.description" default="Description" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="description"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.acceptFileExts" default="Accept File Exts" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="acceptFileExts"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.status" default="Status" />:
								</td>
								<td valign="top" class="value"><gs:message code="status.${instance?.status}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="directoryNode.roles" default="Roles" />:
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
