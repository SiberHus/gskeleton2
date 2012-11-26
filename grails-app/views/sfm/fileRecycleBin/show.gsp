<%@ page import="com.siberhus.gskeleton.sfm.FileRecycleBin" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'fileRecycleBin', default: 'File RecycleBin')}" />
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
									<gs:message code="fileRecycleBin.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.uid" default="Uid" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="uid"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.directoryNode" default="Directory Node" />:
								</td>
								<td valign="top" class="value">
									<g:link controller="directoryNode" action="show" id="${instance?.directoryNode?.id}">
										${instance?.directoryNode?.encodeAsHTML()}
									</g:link>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.originalPath" default="Original Path" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="originalPath"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.fileName" default="File Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="fileName"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.fileType" default="File Type" />:
								</td>
								<td valign="top" class="value">
									<g:if test="${instance?.fileType=='D'}">
										<gs:message code="fileRecycleBin.fileType.directory" default="Directory" />
									</g:if>
									<g:else>
										<gs:message code="fileRecycleBin.fileType.file" default="File" />
									</g:else>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.checksum" default="Checksum" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="checksum"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="fileRecycleBin.deletedDate" default="Deleted Date" />:
								</td>
								<td valign="top" class="value"><gs:formatDatetime date="${instance?.deletedDate}" /></td>
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
