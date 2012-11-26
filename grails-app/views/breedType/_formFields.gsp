
<%@ page import="foo.bar.BreedType" %>
<div class="dialog">
	<table>
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name">
					<label for="code">
						<gs:message code="breedType.code" default="Code" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'code', 'errors')}">
					
					<g:textField name="code" value="${instance?.code}" />

				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="breedType.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					
					<g:textField name="name" value="${instance?.name}" />

				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="foo.helloWorld">
						<gs:message code="breedType.foo.helloWorld" default="Hello World" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'foo.helloWorld', 'errors')}">

					<g:textField name="foo.helloWorld" value="${instance?.foo?.helloWorld}" />

				</td>
			</tr>
		</tbody>
	</table>
</div>