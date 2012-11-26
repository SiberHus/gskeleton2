<%@ page import="com.siberhus.gskeleton.base.Ipv4Filter" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="ipv4Filter.ipAddress" default="IP Address" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value">
					<g:textField name="part1" value="${instance?.part1}" class="decimal" style="width:35px" maxlength="3"/>.
					<g:textField name="part2" value="${instance?.part2}" class="decimal" style="width:35px" maxlength="3"/>.
					<g:textField name="part3" value="${instance?.part3}" class="decimal" style="width:35px" maxlength="3"/>.
					<g:textField name="part4" value="${instance?.part4}" class="decimal" style="width:35px" maxlength="3"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="http">
						<gs:message code="ipv4Filter.http" default="Http" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'http', 'errors')}">
					<g:checkBox name="http" value="${instance?.http}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="https">
						<gs:message code="ipv4Filter.https" default="Https" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'https', 'errors')}">
					<g:checkBox name="https" value="${instance?.https}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="matchingSeq">
						<gs:message code="ipv4Filter.matchingSeq" default="Matching Sequence" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'matchingSeq', 'errors')}">
					<g:textField name="matchingSeq" value="${instance?.matchingSeq}" class="integer" />
				</td>
			</tr>
		</tbody>
	</table>
</div>