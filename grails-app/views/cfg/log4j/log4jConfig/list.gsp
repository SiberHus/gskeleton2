<%@ page import="org.apache.log4j.Logger; com.siberhus.gskeleton.cfg.log4j.Log4jConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'log4j', default: 'Log4j')}" />
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
			<div class="ui-state-highlight">
				<gs:message code="log4jConfig.rootLogger.level" default="Root Logger Level :"/>&nbsp;
				<strong>${Logger.getRootLogger().getLevel()}</strong>
				<br/>
				<gs:message code="log4jConfig.currentLogImpl" default="Current Log Implementation is : "/>
				<strong>${logImpl}</strong><br/>
				<gs:message code="log4jConfig.expectedLogImpl" default="Expected Log Implementation is : "/>
				<strong>${org.apache.log4j.Logger.class.name}</strong>
			</div><br/>
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton"/>
			
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="name" title="Name" titleKey="log4jConfig.name" params="${params }"/>
							<g:sortableColumn property="level" title="Level" titleKey="log4jConfig.level" params="${params }"/>
						</tr>
					</thead>
					<tbody>
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td><g:fieldValue bean="${instance}" field="name"/></td>
							<td><g:fieldValue bean="${instance}" field="level"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['log4jConfig.count']}</span>)
			</div>
		</div>
	</body>
</html>
