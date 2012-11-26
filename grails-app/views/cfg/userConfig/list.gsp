<%@ page import="com.siberhus.gskeleton.cfg.UserConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'userConfig', default: 'User Config')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton" />
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
									<label for="name"><gs:message code="userConfig.username" default="Username" /></label>
								</td>
								<td valign="top" class="value">
									<g:textField name="username" value="${instance?.username}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="name"><gs:message code="userConfig.name" default="Name" /></label>
								</td>
								<td valign="top" class="value">
									<g:textField name="name" value="${instance?.name}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="type"><gs:message code="userConfig.type" default="Type" /></label>
								</td>
								<td valign="top" class="value">
									<g:textField name="type" value="${instance?.type}" />
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
							<g:sortableColumn property="username" title="Name" titleKey="userConfig.username" params="${params }"/>
							<g:sortableColumn property="name" title="Name" titleKey="userConfig.name" params="${params }"/>
							<g:sortableColumn property="type" title="Type" titleKey="userConfig.type" params="${params }"/>
							<g:sortableColumn property="value" title="Value" titleKey="userConfig.value" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>${fieldValue(bean: instance, field: "username")}</td>
							<td>${fieldValue(bean: instance, field: "name")}</td>
							<td>${fieldValue(bean: instance, field: "type")}</td>
							<td>${fieldValue(bean: instance, field: "value")}</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['userConfig.count']}</span>)
			</div>
		</div>
	</body>
</html>
