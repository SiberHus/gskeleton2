<%@ page import="com.siberhus.gskeleton.job.ServiceExecutionLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutionLog', default: 'Service Execution Log')}" />
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
									<label for="serviceExecutorName">
										<gs:message code="serviceExecutionLog.serviceExecutorName" default="Service Executor Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="serviceExecutorName" value="${instance?.serviceExecutorName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="requestedBy">
										<gs:message code="serviceExecutionLog.requestedBy" default="Requested By" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="requestedBy" value="${instance?.requestedBy}" />
								</td>
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="serviceExecutionLog.status" default="Status" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="status" from="${ServiceExecutionLog.constraints.status.inList}"
										value="${instance?.status}" valueMessagePrefix="serviceExecutionLog.status"
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
							<g:sortableColumn property="serviceExecutorName" title="Service Executor Name" titleKey="serviceExecutionLog.serviceExecutorName" params="${params }"/>
							<g:sortableColumn property="requestedBy" title="Requested By" titleKey="serviceExecutionLog.requestedBy" params="${params }"/>
							<g:sortableColumn property="status" title="Status" titleKey="serviceExecutionLog.status" params="${params }"/>
							<g:sortableColumn property="createdDate" title="Start Date/Time" titleKey="serviceExecutionLog.startDatetime" params="${params }"/>
							<g:sortableColumn property="modifiedDate" title="Finish Date/Time" titleKey="serviceExecutionLog.finishDatetime" params="${params }"/>
						</tr>
					</thead>
					<tbody>
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
							<td class="action">
								<gs:linkButton action="show" id="${instance.id}" icon="eye" params="${[offset:params.offset,max:params.max]}"
								title="${message(code:'crud.list.show',default:'show')}"/>
							</td>
							<td><g:fieldValue bean="${instance}" field="serviceExecutorName"/></td>
							<td><g:fieldValue bean="${instance}" field="requestedBy"/></td>
							<td><gs:message code="status.${instance?.status}"/></td>
							<td><gs:formatDatetime date="${instance?.createdDate}"/></td>
							<td><gs:formatDatetime date="${instance?.modifiedDate}"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['serviceExecutionLog.count']}</span>)
			</div>
		</div>
	</body>
</html>
