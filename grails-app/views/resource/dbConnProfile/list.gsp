<%@ page import="org.apache.commons.lang.StringUtils; com.siberhus.gskeleton.resource.DbConnProfile" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'dbConnProfile', default: 'Connection Profile')}" />
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
									<label for="profileName">
										<gs:message code="dbConnProfile.profileName" default="Profile Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="profileName" value="${instance?.profileName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="dbUsername">
										<gs:message code="dbConnProfile.dbUsername" default="Db Username" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="dbUsername" value="${instance?.dbUsername}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="dbDriver">
										<gs:message code="dbConnProfile.dbDriver" default="Db Driver" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="dbDriver" value="${instance?.dbDriver}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="description">
										<gs:message code="dbConnProfile.description" default="Description" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="description" value="${instance?.description}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="dbConnProfile.status" default="Status" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="status" from="${DbConnProfile.constraints.status.inList}"
										value="${instance?.status}" valueMessagePrefix="status"
										noSelection="${session.noSelection}"/>
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
							<g:sortableColumn property="profileName" title="Profile Name" titleKey="dbConnProfile.profileName" params="${params }"/>
							<g:sortableColumn property="description" title="Description" titleKey="dbConnProfile.description" params="${params }"/>
							<g:sortableColumn property="status" title="Status" titleKey="dbConnProfile.status" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
						<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td><g:fieldValue bean="${instance}" field="profileName"/></td>
							<td>
								${StringUtils.abbreviate(instance.description,30)}
							</td>
							<td><gs:message code="status.${instance?.status}"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['dbConnProfile.count']}</span>)
			</div>
		</div>
	</body>
</html>
