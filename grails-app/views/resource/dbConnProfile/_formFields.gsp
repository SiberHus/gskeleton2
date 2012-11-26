
<%@ page import="com.siberhus.gskeleton.base.Role; com.siberhus.gskeleton.resource.DbConnProfile" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="profileName">
						<gs:message code="dbConnProfile.profileName" default="Profile Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'profileName', 'errors')}">
					<g:textField name="profileName" value="${instance?.profileName}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="dbUsername">
						<gs:message code="dbConnProfile.dbUsername" default="Db Username" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'dbUsername', 'errors')}">
					<g:textField name="dbUsername" value="${instance?.dbUsername}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="dbPassword">
						<gs:message code="dbConnProfile.dbPassword" default="Db Password" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'dbPassword', 'errors')}">
					<g:textField name="dbPassword" value="${instance?.dbPassword}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="dbUrl">
						<gs:message code="dbConnProfile.dbUrl" default="Db Url" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'dbUrl', 'errors')}">
					<g:textField name="dbUrl" value="${instance?.dbUrl}"  style="width:100%"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="dbDriver">
						<gs:message code="dbConnProfile.dbDriver" default="Db Driver" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'dbDriver', 'errors')}">
					<g:textField name="dbDriver" value="${instance?.dbDriver}"  style="width:100%"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="dbDriverPath">
						<gs:message code="dbConnProfile.dbDriverPath" default="Db Driver Path" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'dbDriverPath', 'errors')}">
					<g:textField name="dbDriverPath" value="${instance?.dbDriverPath}" style="width:100%"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="dbConnProfile.description" default="Description" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40"
						value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="roles">
						<gs:message code="dbConnProfile.roles" default="Roles" />
					</label>
					
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'roles', 'errors')}">
					<g:select name="roles" from="${Role.list()}" size="5"
						multiple="yes" optionKey="id" value="${instance?.roles?.id}"
						noSelection="${session.noSelection}" class="gs_multiSelect" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="dbConnProfile.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${DbConnProfile.constraints.status.inList}"
						value="${instance?.status}" valueMessagePrefix="status"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>