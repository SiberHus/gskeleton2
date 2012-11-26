<%@ page import="com.siberhus.gskeleton.cfg.log4j.Log4jAppender" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'log4jAppender', default: 'Log4j Appender')}" />
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
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton"/>
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="name" title="Name" titleKey="log4jAppender.name" params="${params }"/>
							<g:sortableColumn property="type" title="Type" titleKey="log4jAppender.type" params="${params }"/>
							<g:sortableColumn property="threshold" title="Threshold" titleKey="log4jAppender.threshold" params="${params }"/>
							<g:sortableColumn property="conversionPattern" title="Conversion Pattern" titleKey="log4jAppender.conversionPattern" params="${params }"/>
						</tr>
					</thead>
					<tbody>
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td><g:fieldValue bean="${instance}" field="name"/></td>
							<td><g:fieldValue bean="${instance}" field="type"/></td>
							<td><g:fieldValue bean="${instance}" field="threshold"/></td>
							<td><g:fieldValue bean="${instance}" field="conversionPattern"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['log4jAppender.count']}</span>)
			</div>
		</div>
	</body>
</html>
