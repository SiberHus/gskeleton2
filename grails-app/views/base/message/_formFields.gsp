<%@ page import="com.siberhus.gskeleton.web.UserSessionMonitor; com.siberhus.gskeleton.base.Message" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="language">
						<gs:message code="message.language" default="Language" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'language', 'errors')}">
					<g:select name="language" from="${application['_languageMap']}"
						optionKey="key" optionValue="value"
						value="${instance?.language?:UserSessionMonitor.get(session).getLanguage()}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="code">
						<gs:message code="message.code" default="Code" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'code', 'errors')}">
					<g:textField name="code" value="${instance?.code}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="message">
						<gs:message code="message.text" default="Text" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'text', 'errors')}">
					<g:textField name="text" value="${instance?.text}" />
				</td>
			</tr>
		</tbody>
	</table>
</div>