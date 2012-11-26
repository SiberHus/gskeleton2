<%@ page import="com.siberhus.gskeleton.base.AdminMenu" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'adminMenu', default: 'Admin Menu')}" />
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
									<gs:message code="adminMenu.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.code" default="Code" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="code"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.parent" default="Parent" />:
								</td>
								<td valign="top" class="value"><g:link controller="adminMenu" action="show" id="${instance?.parent?.id}">${instance?.parent?.encodeAsHTML()}</g:link></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.label" default="Default Label" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="label"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.labelKey" default="Label Key" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="labelKey"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.imageIcon" default="Image Icon" />:
								</td>
								<td valign="top" class="value">
									<g:if test="${instance.imageIcon}">
										<img src="${g.resource(file:instance.imageIcon)}"/>
									</g:if>
								</td>
							</tr>
							<tr class="prop">
							<g:if test="${instance.targetUrl}">
								<td valign="top" class="name">
									<gs:message code="adminMenu.targetUrl" default="Target Url" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="targetUrl"/></td>
							</g:if>
							<g:else>
								<td valign="top" class="name">
									<gs:message code="adminMenu.controllerName" default="Controller" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="controllerName"/></td>
								<td valign="top" class="name">
									<gs:message code="adminMenu.actionName" default="Action" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="actionName"/></td>
							</g:else>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.targetName" default="Target Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="targetName"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.menuOrder" default="Order" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="menuOrder"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.description" default="Description" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="description"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.status" default="Status" />:
								</td>
								<td valign="top" class="value"><gs:message code="status.${instance?.status}"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.children" default="Children" />:
								</td>
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${instance?.children}" var="adminMenuInstance">
										<li><g:link controller="adminMenu" action="show" id="${adminMenuInstance.id}">${adminMenuInstance.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="adminMenu.roles" default="Roles" />:
								</td>
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${instance?.roles}" var="roleInstance">
										<li><g:link controller="role" action="show" id="${roleInstance.id}">${roleInstance.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
							</tr>
							<g:render template="/commons/crud/showAuditFields" />
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
