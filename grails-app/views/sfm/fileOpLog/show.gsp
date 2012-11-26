<%@ page import="com.siberhus.gskeleton.sfm.FileOpLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'fileOpLog', default: 'File Operation Log')}" />
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
									<gs:message code="fileOpLog.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.filePath" default="File Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="filePath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.user" default="User" />:
								</td>
								<td valign="top" class="value">
									<g:link controller="user" action="show" id="${instance?.user?.id}">
										${instance?.user?.encodeAsHTML()}
									</g:link>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.operation" default="Operation" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="operation"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.operationDate" default="Operation Date" />:
								</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.operationDate}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.oldFilePath" default="Old File Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="oldFilePath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileOpLog.checksum" default="Checksum" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="checksum"/></td>
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
