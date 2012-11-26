<%@ page import="com.siberhus.gskeleton.config.SysConfig; com.siberhus.gskeleton.job.JobGroup; com.siberhus.gskeleton.job.JobLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'jobLog', default: 'Job Log')}" />
	</head>
	<body>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			<g:if test="${!SysConfig.get('jobScheduler.jobLog')}"> 
				<div class="ui-state-highlight ui-corner-all">
					<gs:message code="jobLog.disabledMessage" default="Job Log is disabled"/>
				</div>
			</g:if>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="crud.searchBox"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="jobGroup">
										<gs:message code="job.jobGroup" default="Job Group" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
									<g:select name="jobGroup" from="${JobGroup.list()}" value="${instance?.jobGroup}" />
								</td>
								<td valign="top" class="name">
									<label for="jobName">
										<gs:message code="jobLog.jobName" default="Job Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="jobName" value="${instance?.jobName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="jobLog.status" default="Status" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:select name="status" from="${JobLog.constraints.status.inList}" 
										value="${instance.status}" valueMessagePrefix="status" 
										noSelection="${session.noSelection}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="createdDate">
										<gs:message code="jobLog.createdDate" default="Created Date" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="createdDate" value="${ gs.formatDatetime(date:instance?.createdDate)}" class="datetime" />
									<strong>-</strong>
									<g:textField name="createdDate_" value="${ gs.formatDatetime(date:instance?.createdDate_)}" class="datetime" />
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
							<th style="width:20px;"><input id="allIdsChk" type="checkbox"/></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" style="width:40px;text-align:center;" params="${params }"/>
							<g:sortableColumn property="jobGroup" title="Job Group" titleKey="jobLog.jobGroup" params="${params }"/>
							<g:sortableColumn property="jobName" title="Job Name" titleKey="jobLog.jobName" params="${params }"/>
							<g:sortableColumn property="createdDate" title="Created Date" titleKey="jobLog.createdDate" params="${params }"/>
							<g:sortableColumn property="modifiedDate" title="Modified Date" titleKey="jobLog.modifiedDate" params="${params }"/>
							<g:sortableColumn property="status" title="Status" titleKey="jobLog.status" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
							<td class="action">
								<gs:linkButton action="show" id="${instance.id}" icon="eye" title="${message(code:'crud.list.show',default:'show')}"/>
							</td>
							<td>${fieldValue(bean: instance, field: "jobGroup")}</td>
							<td>${fieldValue(bean: instance, field: "jobName")}</td>
							<td><gs:formatDatetime date="${instance.createdDate}" /></td>
							<td><gs:formatDatetime date="${instance.modifiedDate}" /></td>
							<td>
								<strong>
									<g:if test="${instance.status=='ERROR'}">
										<span style="color:red;"><gs:message code="jobLog.error" default="Error"/></span>
									</g:if>
									<g:elseif test="${instance.status=='SUCCESS'}">
										<span style="color:blue;"><gs:message code="jobLog.success" default="Success"/></span>
									</g:elseif>
									<g:else>
										<gs:message code="jobLog.running" default="Running"/>
									</g:else>
								</strong>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['jobLog.count']}</span>)
			</div>
		</div>
	</body>
</html>
