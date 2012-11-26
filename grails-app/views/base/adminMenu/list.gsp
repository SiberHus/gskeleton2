<%@ page import="com.siberhus.gskeleton.base.AdminMenu" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'adminMenu', default: 'Admin Menu')}" />
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
									<label for="code">
										<gs:message code="adminMenu.code" default="Code" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="code" value="${instance?.code}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="label">
										<gs:message code="adminMenu.label" default="Label" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="label" value="${instance?.label}" />
								</td>
								<td valign="top" class="name">
									<label for="labelKey">
										<gs:message code="adminMenu.labelKey" default="Label Key" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="labelKey" value="${instance?.labelKey}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="targetUrl">
										<gs:message code="adminMenu.targetUrl" default="Target Url" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="targetUrl" value="${instance?.targetUrl}" />
								</td>
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="adminMenu.status" default="Status" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="status" from="${AdminMenu.constraints.status.inList}"
										value="${instance.status}" valueMessagePrefix="status"
										noSelection="${session.noSelection}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="description">
										<gs:message code="adminMenu.description" default="Description" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="description" value="${instance?.description}" style="width:350px"/>
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
				   		<g:sortableColumn property="code" title="Code" titleKey="adminMenu.code" params="${params }"/>
				   		<th><gs:message code="adminMenu.parent" default="Parent" /></th>
						<g:sortableColumn property="labelKey" title="Label Key" titleKey="adminMenu.labelKey" params="${params }"/>
				   		<g:sortableColumn property="label" title="Label" titleKey="adminMenu.label" params="${params }"/>
						<g:sortableColumn property="targetUrl" title="Target Url" titleKey="adminMenu.targetUrl" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td><g:fieldValue bean="${instance}" field="code"/></td>
							<td><g:fieldValue bean="${instance}" field="parent"/></td>
						    <td><g:fieldValue bean="${instance}" field="labelKey"/></td>
							<td><g:fieldValue bean="${instance}" field="label"/></td>
							<td><g:fieldValue bean="${instance}" field="targetUrl"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['adminMenu.count']}</span>)
			</div>
		</div>
	</body>
</html>
