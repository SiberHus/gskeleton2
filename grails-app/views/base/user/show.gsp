
<%@ page import="com.siberhus.gskeleton.util.WebResourceUtils; com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'user', default: 'User')}" />
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
			<div style="float:right;margin-right:10%;border: 3px coral solid;">
				<div style="margin: 15px">
					<g:if test="${instance?.photoImgPath}">
						<img src="${WebResourceUtils.getUserResourceWebPath(instance.username+'.jpg')}" alt="User Photo"/>
					</g:if>
					<g:else>
						<img src="${gs.resource(dir:'images',file:'photo_not_available.png')}" alt="User Photo"/>
					</g:else>
				</div>
			</div>
			<g:form>
				<g:hiddenField name="id" value="${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.id" default="Id" />:</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.username" default="Username" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "username")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.fullName" default="Full Name" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "fullName")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.pwdChangedDate" default="Last Password Changed" />:</td>
								<td valign="top" class="value"><gs:formatDate date="${instance?.pwdChangedDate}" /></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.email" default="Email" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "email")}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.mobilePhone" default="Mobile Telephone" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "mobilePhone")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.workPhone" default="Work Telephone" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "workPhone")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.homePhone" default="Home Telephone" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "homePhone")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.addressLine1" default="Address Line1" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "addressLine1")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.addressLine2" default="Address Line2" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "addressLine2")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.city" default="City/District" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "city")}</td>
								<td valign="top" class="name"><gs:message code="user.state" default="State/Province" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "state")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.postalCode" default="Postal Code" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "postalCode")}</td>
								<td valign="top" class="name"><gs:message code="user.country" default="Country" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "country")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.description" default="Description" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "description")}</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.auditTrail" default="Audit Trail" />:</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.auditTrail}" /></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.pwdAge" default="Password Age" />:</td>
								<td valign="top" class="value">
									<g:if test="${instance.pwdAge==-1}">
										<gs:message code="user.passwordNeverExpire" default="Never Expire"/>
									</g:if>
									<g:else>
										${instance.pwdAge}
									</g:else>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.expiryDate" default="Expiry Date" />:</td>
								<td valign="top" class="value"><gs:formatDate date="${instance?.expiryDate}"  /></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.roles" default="Roles" />:</td>
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${instance?.roles}" var="roleInstance">
										<li><g:link controller="role" action="show" id="${roleInstance.id}">${roleInstance.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.permissions" default="Permissions" />:</td>
								<td valign="top" class="value">
									<ul>
										<g:each in="${instance?.permissions}">
										<li>${it}</li>
										</g:each>
									</ul>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.status" default="Status" />:</td>
								<td valign="top" class="value"><gs:message code="status.${instance.status}"/> </td>
							</tr>
							
							<g:render template="/commons/crud/showAuditFields" />
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" value="${message(code: 'btn.edit', 'default': 'Edit')}"
						icon="database_edit" />
					<gs:linkSubmitButton action="delete" value="${message(code: 'btn.delete', 'default': 'Delete')}" 
						confirm="true" icon="database_delete" class="negative"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
