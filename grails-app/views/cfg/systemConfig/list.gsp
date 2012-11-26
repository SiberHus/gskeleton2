<%@ page import="com.siberhus.gskeleton.cfg.SystemConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'systemConfig', default: 'System Config')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton" />
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
										<gs:message code="systemConfig.name" default="Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="name" value="${instance?.name}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="type">
										<gs:message code="systemConfig.type" default="Type" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="type" from="${SystemConfig.constraints.type.inList}"
									value="${instance?.type}" valueMessagePrefix="systemConfig.type"
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
			<br/>
			
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="name" title="Name" titleKey="systemConfig.name" params="${params }"/>
							<g:sortableColumn property="value" title="Value" titleKey="systemConfig.value" params="${params }"/>
							<g:sortableColumn property="type" title="Type" titleKey="systemConfig.type" params="${params }"/>
							<g:sortableColumn property="required" title="Required" titleKey="systemConfig.required" params="${params }"/>
							<g:sortableColumn property="multiValues" title="Multi Values" titleKey="systemConfig.multiValues" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>${fieldValue(bean: instance, field: "name")}</td>
							<td>${fieldValue(bean: instance, field: "value")}</td>
							<td>${fieldValue(bean: instance, field: "type")}</td>
							<td><g:formatBoolean boolean="${instance.required}" /></td>
							<td><g:formatBoolean boolean="${instance.multiValues}" /></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['systemConfig.count']}</span>)
			</div>
		</div>
	</body>
</html>
