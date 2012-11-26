<%@ page import="com.siberhus.gskeleton.base.Ipv4Filter" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'ipv4Filter', default: 'IPv4 Filter')}" />
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
			<gs:linkButton action="create" class="create" icon="database_add">
				<gs:message code="default.new.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.show.label" args="[entityName]" /></h2>
			<g:form>
				<g:hiddenField name="id" value="${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="ipv4Filter.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="ipv4Filter.ipAddress" default="IP Address" />:
								</td>
								<td valign="top" class="value">${instance?.toString()}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="ipv4Filter.http" default="Http" />:
								</td>
								<td valign="top" class="value">
									<g:if test="${instance?.http}">
										<g:message code="fieldValue.enabled" default="Enabled"/>
									</g:if>
									<g:else>
										<g:message code="fieldValue.disabled" default="Disabled"/>
									</g:else>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="ipv4Filter.https" default="Https" />:
								</td>
								<td valign="top" class="value">
									<g:if test="${instance?.https}">
										<g:message code="fieldValue.enabled" default="Enabled"/>
									</g:if>
									<g:else>
										<g:message code="fieldValue.disabled" default="Disabled"/>
									</g:else>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="ipv4Filter.matchingSeq" default="Matching Sequence" />:
								</td>
								<td valign="top" class="value">
									${instance?.matchingSeq}
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" valueKey="btn.edit" value="Edit"
						icon="database_edit" />&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
