<%@ page import="com.siberhus.gskeleton.sfm.DirectoryNode" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'directoryNode', default: 'Directory Node')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton"/>
			<gs:ifNotPopupPage>
				<gs:linkButton action="create" icon="database_add">
					<gs:message code="default.new.label" args="[entityName]" />
				</gs:linkButton>
			</gs:ifNotPopupPage>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="crud.searchBox"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<gs:includePopupFields/>
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="name">
										<gs:message code="directoryNode.name" default="Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="name" value="${instance?.name}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="directoryPath">
										<gs:message code="directoryNode.directoryPath" default="Directory Path" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="directoryPath" value="${instance?.directoryPath}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="directoryNode.status" default="Status" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="status" from="${DirectoryNode.constraints.status.inList}"
										value="${instance?.status}" valueMessagePrefix="status"
										noSelection="${session.noSelection}" />
								</td>
							</tr>
						</tbody>
					</table>
					<g:render template="/commons/crud/searchControls" />
				</g:form>
			</div>
			</div>
			</div>
			
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton"/>
			
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="name" title="Name" titleKey="directoryNode.name" params="${params }"/>
							<g:sortableColumn property="directoryPath" title="Directory Path" titleKey="directoryNode.directoryPath" params="${params }"/>
							<g:sortableColumn property="acceptFileExts" title="Accept File Exts" titleKey="directoryNode.acceptFileExts" params="${params }"/>
							<g:sortableColumn property="status" title="Status" titleKey="directoryNode.status" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td><g:fieldValue bean="${instance}" field="name"/></td>
							<td><g:fieldValue bean="${instance}" field="directoryPath"/></td>
							<td><g:fieldValue bean="${instance}" field="acceptFileExts"/></td>
							<td><gs:message code="status.${instance?.status}"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['directoryNode.count']}</span>)
			</div>
		</div>
	</body>
</html>
