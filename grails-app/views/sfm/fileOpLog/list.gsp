<%@ page import="com.siberhus.gskeleton.sfm.FileOpLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'fileOpLog', default: 'File Operation Log')}" />
	</head>
	<body>
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
									<label for="filePath">
										<gs:message code="fileOpLog.filePath" default="File Path" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="filePath" value="${instance?.filePath}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="user.id">
										<gs:message code="fileOpLog.user" default="User" />
									</label>
								</td>
								<td valign="top" class="value">
									<gs:fieldLookup name="user.id" lookupUrl="${createLink(controller:'user')}"
										value="${instance?.user?.id}" labelValue="${instance?.user?.username}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="operation">
										<gs:message code="fileOpLog.operation" default="Operation" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="operation" from="${FileOpLog.constraints.operation.inList}" 
										value="${instance?.operation}" valueMessagePrefix="fileOpLog.operation"
										noSelection="${session.noSelection}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="operationDate">
										<gs:message code="fileOpLog.operationDate" default="Operation Date" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="operationDate" value="${gs.formatDatetime(date:instance?.operationDate)}" class="datetime" />
									<strong>-</strong>
									<g:textField name="operationDate_" value="${gs.formatDatetime(date:instance?.operationDate_)}" class="datetime" />
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
			
			<%
				params.remove('user')
			%>
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="filePath" title="File Path" titleKey="fileOpLog.filePath" params="${params }"/>
							<g:sortableColumn property="oldFilePath" title="Old File Path" titleKey="fileOpLog.oldFilePath" params="${params }"/>
							<g:sortableColumn property="operation" title="Operation" titleKey="fileOpLog.operation" params="${params }"/>
							<th><gs:message code="fileOpLog.user" default="User" /></th>
							<g:sortableColumn property="operationDate" title="Operation Date" titleKey="fileOpLog.operationDate" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
							<td class="action">
							<gs:ifPopupPage>
								<gs:chooseLink refValue="${instance.id}" refLabel="${instance}"/>
							</gs:ifPopupPage>
							<gs:ifNotPopupPage>
								<gs:linkButton action="show" id="${instance.id}" icon="eye" title="${message(code:'crud.list.show',default:'show')}"/>
							</gs:ifNotPopupPage>
							</td>
							<td><g:fieldValue bean="${instance}" field="filePath"/></td>
							<td><g:fieldValue bean="${instance}" field="oldFilePath"/></td>
							<td><g:fieldValue bean="${instance}" field="operation"/></td>
							<td><g:fieldValue bean="${instance}" field="user"/></td>
							<td><gs:formatDatetime date="${instance.operationDate}" /></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['fileOpLog.count']}</span>)
			</div>
		</div>
	</body>
</html>
