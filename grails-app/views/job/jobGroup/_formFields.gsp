
<%@ page import="com.siberhus.gskeleton.job.JobGroup" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="jobGroup.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" class="letter" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="jobGroup.description" default="Description" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="jobGroup.jobs" default="Jobs" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'jobs', 'errors')}">
					<ul>
					<g:each in="${instance?.jobs}" var="jobInstance">
						<li>
							<g:link controller="jobScheduler" action="show" id="${jobInstance?.id}">
								${jobInstance?.encodeAsHTML()}
							</g:link>
						</li>
					</g:each>
					</ul>
					<g:link controller="jobScheduler" params="['jobGroup?.id': instance?.id]" action="create">
						<g:message code="job.new" default="New Job" />
					</g:link>
				</td>
			</tr>
		</tbody>
	</table>
</div>