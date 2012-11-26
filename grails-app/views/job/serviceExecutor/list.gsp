<%@ page import="com.siberhus.gskeleton.job.ServiceExecutionThread; com.siberhus.gskeleton.job.ServiceExecutor" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutor', default: 'Service Executor')}" />
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
										<gs:message code="serviceExecutor.name" default="Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="name" value="${instance?.name}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="serviceName">
										<gs:message code="serviceExecutor.serviceName" default="Service Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="serviceName" value="${instance?.serviceName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="methodName">
										<gs:message code="serviceExecutor.methodName" default="Method Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="methodName" value="${instance?.methodName}" />
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
							<th style="width:80px;"><gs:message code="job.commands" default="Commands"/></th>
							<g:sortableColumn property="name" title="Name" titleKey="serviceExecutor.name" params="${params }"/>
							<g:sortableColumn property="serviceName" title="Service Name" titleKey="serviceExecutor.serviceName" params="${params }"/>
							<g:sortableColumn property="methodName" title="Method Name" titleKey="serviceExecutor.methodName" params="${params }"/>
							<th style="width:100px;text-align:center;"><gs:message code="serviceExecutor.lastResult" default="Last Result"/></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td style="text-align:center;">
								<gs:linkButton action="prepareExecute" id="${instance.id}" icon="cog"
									title="${message(code:'job.execute',default:'Execute')}"/>
							</td>
							<td><g:fieldValue bean="${instance}" field="name"/></td>
							<td><g:fieldValue bean="${instance}" field="serviceName"/></td>
							<td><g:fieldValue bean="${instance}" field="methodName"/></td>
							<td style="text-align:center">
								<g:if test="${ServiceExecutionThread.ERROR_MESSAGES.containsKey(instance?.name)}">
									<gs:image icon="circle_red"/>&nbsp;
									<g:link action="prepareExecute" id="${instance.id}" params="[showerr:true]">
										<gs:message code="serviceExecution.result.error" default="ERROR"/>
									</g:link>
								</g:if>
								<g:else>
									<gs:image icon="circle_green"/>&nbsp;
									<gs:message code="serviceExecution.result.ok" default="OK"/>
								</g:else>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['serviceExecutor.count']}</span>)
			</div>
		</div>
	</body>
</html>
