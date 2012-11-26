<%@ page import="com.siberhus.gskeleton.web.UserSessionMonitor; com.siberhus.gskeleton.base.Message" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'message', default: 'Message')}" />
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
									<label for="language">
										<gs:message code="message.language" default="Language" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="language" from="${application['_languageMap']}"
										optionKey="key" optionValue="value"
										value="${instance?.language?:UserSessionMonitor.get(session).getLanguage()}"
										noSelection="${session.noSelection}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="code">
										<gs:message code="message.code" default="Code" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="code" value="${instance?.code}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="text">
										<gs:message code="message.text" default="Text" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="text" value="${instance?.text}" />
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
				   		<g:sortableColumn property="language" title="Language" titleKey="message.language" params="${params }" style="width:100px"/>
				   		<g:sortableColumn property="code" title="Code" titleKey="message.code" params="${params }" style="width:25%"/>
				   		<g:sortableColumn property="text" title="Text" titleKey="message.text" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>${application['_languageMap'][instance?.language]}</td>
							<td><g:fieldValue bean="${instance}" field="code"/></td>
							<td><g:fieldValue bean="${instance}" field="text"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['message.count']}</span>)
			</div>
		</div>
	</body>
</html>
