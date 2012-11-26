<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder; com.siberhus.gskeleton.dashboard.Widget" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="widget.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="contentPath">
						<gs:message code="widget.contentPath" default="Content Path" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'contentPath', 'errors')}">
					<g:select name="contentPath" from="${ConfigurationHolder.config.gskeleton.dashboard.widgetContentPaths}"
						value="${instance?.contentPath}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="widget.description" default="Description" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textField name="description" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="widget.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${Widget.constraints.status.inList}"
						value="${instance?.status}" valueMessagePrefix="status" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="defaultPosition">
						<gs:message code="widget.defaultPosition" default="Default Position" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'defaultPosition', 'errors')}">
					<g:select name="defaultPosition" from="${Widget.constraints.defaultPosition.inList}"
						value="${instance?.defaultPosition}" valueMessagePrefix="widget.defaultPosition" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="roles">
						<gs:message code="widget.roles" default="Roles" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'roles', 'errors')}">
					<g:select name="roles" from="${com.siberhus.gskeleton.base.Role.list()}"
						noSelection="${session.noSelection}" size="5" multiple="yes" optionKey="id"
						value="${instance?.roles?.id}" class="gs_multiSelect" />
				</td>
			</tr>
		</tbody>
	</table>
</div>