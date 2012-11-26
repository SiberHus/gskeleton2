<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="userConfig.username" default="Username" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'username', 'errors')}">
					<g:textField name="username" value="${instance?.username}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="userConfig.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="type">
						<gs:message code="userConfig.type" default="Type" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'type', 'errors')}">
					<g:textField name="type" value="${instance?.type}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="value">
						<gs:message code="userConfig.value" default="Value" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'value', 'errors')}">
					<g:textField name="value" value="${instance?.value}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="value">
						<gs:message code="userConfig.description" default="Description" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" value="${instance?.description}" style="width:100%"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>