<%@ page import="com.siberhus.gskeleton.job.Job; com.siberhus.gskeleton.job.JobGroup" %>

<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="jobGroup.id">
						<gs:message code="job.jobGroup" default="Job Group" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:select name="jobGroup.id" from="${JobGroup.list()}"
						value="${instance?.jobGroup?.id}" optionKey="id" optionValue="name" />
				</td>
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="job.name" default="Job Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" class="letter" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="serviceName">
						<gs:message code="job.serviceName" default="Service Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'serviceName', 'errors')}">
					<g:textField name="serviceName" value="${instance?.serviceName}" />
				</td>
				<td valign="top" class="name">
					<label for="methodName">
						<gs:message code="job.methodName" default="Method Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'methodName', 'errors')}">
					<g:textField name="methodName" value="${instance?.methodName}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="concurrent">
						<gs:message code="job.concurrent" default="Concurrent" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'concurrent', 'errors')}">
					<g:checkBox name="concurrent" value="${instance?.concurrent}" />
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="triggerType">
						<gs:message code="job.triggerType" default="Trigger Type" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'triggerType', 'errors')}">
					<g:select name="triggerType" from="${instance.constraints.triggerType.inList}" 
						value="${instance.triggerType}" valueMessagePrefix="job.triggerType"
						noSelection="${session.noSelection}" />
				</td>
			</tr>
			<tr class="prop cronField">
				<td valign="top" class="name">
					<label for="cronExp">
						<gs:message code="job.cronExp" default="Cron Exp" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'cronExp', 'errors')}">
					<g:textField name="cronExp" value="${instance?.cronExp}" />
					<gs:image id="cronButton" icon="clock" style="cursor:pointer;"/>
				</td>
			</tr>
			<tr class="prop repeatField">
				<td valign="top" class="name">
					<label for="repeatInterval">
						<gs:message code="job.repeatInterval" default="Repeat Interval" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'repeatInterval', 'errors')}">
					<g:textField name="repeatInterval" value="${instance?.repeatInterval}" class="numeral" style="width:130px"/>
					<g:select name="timeUnit" from="${instance.constraints.timeUnit.inList}" 
						value="${instance.timeUnit}" valueMessagePrefix="timeUnit" style="width:75px"/>
				</td>
				<td valign="top" class="name">
					<label for="repeatCount">
						<gs:message code="job.repeatCount" default="Repeat Count" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'repeatCount', 'errors')}">
					<g:textField name="repeatCount" value="${instance?.repeatCount}" class="integer" />
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="startTime">
						<gs:message code="job.startTime" default="Start Time" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'startTime', 'errors')}">
					<g:textField name="startTime" value="${instance?.startTime}" class="timestamp" />
				</td>
				<td valign="top" class="name">
					<label for="endTime">
						<gs:message code="job.endTime" default="End Time" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'endTime', 'errors')}">
					<g:textField name="endTime" value="${instance?.endTime}" class="timestamp" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="job.description" default="Description" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${Job.constraints.status.inList}" 
						value="${instance?.status}" valueMessagePrefix="status"/>
				</td>
			</tr>
		
		</tbody>
	</table>
</div>