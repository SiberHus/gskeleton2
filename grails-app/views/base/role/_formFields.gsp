<%@ page import="com.siberhus.gskeleton.base.Role" %>

<div class="dialog">
	<table style="width:100%;">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name"><gs:message code="role.name" default="Role Name" />:</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label><gs:message code="role.permissions" default="Permissions" />:</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'permissions', 'errors')}">
					<table id="permissionTbl" class="dynamicValueComp" style="width:500px">
						<tr>
							<td colspan="3">
								<input type="button" onclick="addPermissionRow('');" value="+"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description"><gs:message code="role.description" default="Description" />:</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="role.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${Role.constraints.status.inList}"
						value="${instance.status}" valueMessagePrefix="status" />
				</td>

			</tr>
		</tbody>
	</table>
</div>