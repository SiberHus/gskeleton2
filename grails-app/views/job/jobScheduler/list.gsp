<%@ page import="com.siberhus.gskeleton.job.JobGroup; com.siberhus.gskeleton.util.State" %>
<%@ page import="com.siberhus.gskeleton.job.Job" %>
<%@page import="com.siberhus.gskeleton.service.JobManagerService"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="refresh" content="${params.refreshInterval?:60}; url=${createLink(action:'list', params:params)}">
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'job', default: 'Job')}" />
		<script type="text/javascript">
			$(function(){
				$('#schedulerControl').dialog({
					bgiframe: true,autoOpen: false,modal:true,
					width: 340,height: 150
				});
			});
		</script>
	</head>
	<body>
		<div id="schedulerControl" class="dialog" title="${message(code:'job.schedulerControl',default:'Scheduler Control')}">
			<table style="width:100%" class="list">
				<thead class="ui-widget-header">
					<tr>
						<th style="width:40%">&nbsp;</th>
						<th style="width:30%"><strong>Status</strong></th>
						<th style="width:30%"><strong>Action</strong></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><gs:message code="job.triggers" default="Triggers"/></td>
						<g:if test="${State.get('scheduler.allTriggers.state')=='paused'}">
							<td>
								<gs:message code="job.triggerState.paused" default="Paused"/>
							</td>
							<td>
								<gs:linkButton action="resumeAllTriggers" icon="control_play" style="width:70px">
									<gs:message code="job.resumeAll" default="Resume All" />
								</gs:linkButton>
							</td>
						</g:if>
						<g:else>
							<td>
								<gs:message code="job.triggerState.normal" default="Normal"/>
							</td>
							<td>
								<gs:linkButton action="pauseAllTriggers" icon="control_pause" style="width:70px">
									<gs:message code="job.pauseAll" default="Pause All" />
								</gs:linkButton>
							</td>
						</g:else>
					</tr>
					<tr>
						<td><gs:message code="job.scheduler" default="Scheduler"/></td>
						<g:if test="${State.get('scheduler.state')=='standby'}">
							<td>
								<gs:message code="job.schedulerState.standby" default="Standby"/>
							</td>
							<td>
								<gs:linkButton action="restartScheduler" icon="control_play" style="width:70px">
									<gs:message code="job.restart" default="Restart" />
								</gs:linkButton>
							</td>
						</g:if>
						<g:else>
							<td>
								<gs:message code="job.schedulerState.started" default="Started"/>
							</td>
							<td>
								<gs:linkButton action="standbyScheduler" icon="control_pause" style="width:70px">
									<gs:message code="job.standby" default="Standby" />
								</gs:linkButton>
							</td>
						</g:else>
					</tr>
				</tbody>
			</table>
		</div>
		<gs:buttonBar>
			<gs:linkButton action="create" icon="database_add">
				<gs:message code="default.new.label" args="[entityName]" />
			</gs:linkButton>
			<gs:linkButton url="#" icon="clock" onclick="\$('#schedulerControl').dialog('open');">
				<gs:message code="job.schedulerControl" default="Scheduler Control" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2>
				<gs:message code="jobScheduler" default="Job Scheduler" />
				&nbsp;&nbsp;&nbsp;
				<span style="color:${State.get('scheduler.state')=='started'?'black':'red'}">
					<g:if test="${State.get('scheduler.state')=='started'}">
						<gs:message code="job.schedulerState.started" default="STARTED"/>
					</g:if>
					<g:elseif test="${State.get('scheduler.state')=='standby'}">
						<gs:message code="job.schedulerState.standby" default="STANDBY"/>
					</g:elseif>
					<g:else>
						<gs:message code="job.schedulerState.shutdown" default="SHUTDOWN"/>
					</g:else>
				</span>
			</h2>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="crud.searchBox"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="jobGroup.id">
									<gs:message code="job.jobGroup" default="Job Group" />
								</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
								<g:select name="jobGroup.id" from="${JobGroup.list()}"
									value="${instance?.jobGroup?.id}" optionKey="id" optionValue="name" />
							</td>
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.name" default="Job Name" />
								</label>
							</td>
							<td valign="top" class="value">
								<g:textField name="name" value="${instance?.name}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.serviceName" default="Service Name" />
								</label>
							</td>
							<td valign="top" class="value">
								<g:textField name="serviceName" value="${instance?.serviceName}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.triggerType" default="Trigger Type" />
								</label>
							</td>
							<td valign="top" class="value">
								<g:select name="triggerType" from="${Job.constraints.triggerType.inList}"
									value="${instance.triggerType}" valueMessagePrefix="job.triggerType" 
									noSelection="${session.noSelection}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.startTime" default="Start Time" />
								</label>
							</td>
							<td colspan="3" valign="top" class="value">
								<g:textField name="startTime" value="${gs.formatDatetime(date:instance.startTime)}" class="timestamp" style="width:150px"/>
								<strong>-</strong>
								<g:textField name="startTime_" value="${gs.formatDatetime(date:instance.startTime_)}" class="timestamp" style="width:150px"/>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.endTime" default="End Time" />
								</label>
							</td>
							<td colspan="3" valign="top" class="value">
								<g:textField name="endTime" value="${gs.formatDatetime(date:instance.endTime)}" class="timestamp" style="width:150px"/>
								<strong>-</strong>
								<g:textField name="endTime_" value="${gs.formatDatetime(date:instance.endTime_)}" class="timestamp" style="width:150px"/>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<gs:message code="job.refreshInterval" default="Refresh Interval" />
								</label>
							</td>
							<td valign="top" class="value">
								<g:textField name="refreshInterval" value="${params.refreshInterval?:60}" style="width:50px"/>
								<gs:message code="seconds" default="seconds"/>
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
						<th style="width:90px;text-align: center;"><gs:message code="job.commands" default="Commands"/></th>
				   		<g:sortableColumn property="name" title="Name" titleKey="job.name" params="${params }" style="width:20%;"/>
				   		<g:sortableColumn property="triggerType" title="Trigger Type" titleKey="job.triggerType" params="${params }" style="width:80px;"/>
				   		<g:sortableColumn property="triggerState" title="State" titleKey="job.triggerState" params="${params }" style="width:80px;"/>
				   		<th><gs:message code="job.previousFireTime" default="Previous Fire Time"/></th>
						<th><gs:message code="job.nextFireTime" default="Next Fire Time"/></th>
				   		<g:sortableColumn property="status" title="Status" titleKey="job.status" params="${params }" style="width:80px;"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td style="text-align: center">
								<g:if test="${JobManagerService.isJobRunning(instance)}">
									<g:if test="${instance.concurrent}">
										<gs:linkButton action="execute" id="${instance.id}" icon="cog_go"
											onclick="return confirm('Are you sure to execute this job');"
											title="${message(code:'job.execute',default:'Execute')}"/>
									</g:if>
									<g:else>
										<gs:image icon="cog_go" title="${message(code:'job.execute',default:'Execute')}"/>
									</g:else>
								</g:if>
								<g:else>
									<gs:linkButton action="execute" id="${instance.id}" icon="cog"
										onclick="return confirm('Are you sure to execute this job');"
										title="${message(code:'job.execute',default:'Execute')}"/>
								</g:else>&nbsp;
								<g:link action="togglePause" id="${instance.id}">
									<g:if test="${instance.triggerState=='PAUSED' }">
										<gs:image icon="clock_play" title="${message(code:'job.resume',default:'Resume')}"/>
									</g:if>
									<g:else>
										<gs:image icon="clock_stop" title="${message(code:'job.pause',default:'Pause')}"/>
									</g:else>
								</g:link>&nbsp;
								<gs:linkButton controller="jobLog" action="findByJob" params="[jobName:instance.name]"
										icon="comment" title="${message(code:'job.showLogs',default:'Show Logs')}"/>
							</td>
							<td>${fieldValue(bean: instance, field: "name")}</td>
							<td>${instance.triggerType}</td>
							<td><gs:message code="job.triggerState.${instance.triggerState}" default="${instance.triggerState}"/></td>
							<td>${gs.formatDatetime(date:instance.previousFireTime)}</td>
							<td>${gs.formatDatetime(date:instance.nextFireTime)}</td>
							<td><gs:message code="status.${instance.status}"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['job.count']}</span>)
			</div>
		</div>
	</body>
</html>
