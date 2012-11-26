<%@ page import="com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminLayout" />
		<g:set var="entityName" value="${message(code: 'user', default: 'User')}" />
	</head>
	<body>
		<g:render template="/base/personalProfile/personalBar" />
		<div class="body">
			<h2><gs:message code="default.edit.label" args="[entityName]" /></h2>
			<g:uploadForm method="post" >
				<g:hiddenField name="id" value="${instance?.id}" />
				<g:hiddenField name="version" value="${instance?.version}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="user.username" default="Username" />
								</td>
								<td valign="top" class="value">
									${instance?.username}
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="user.password" default="Password" />
								</td>
								<td valign="top" class="value">
									<g:link action="changePassword">
										<gs:message code="user.changePassword" default="Change Password" />
									</g:link>
									&nbsp;&nbsp;
									(<gs:formatDate date="${instance?.pwdChangedDate}"/>)
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="firstName">
										<gs:message code="user.firstName" default="First Name" />
									</label>
									<span style="color:red;">*</span>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'firstName', 'errors')}">
									<g:textField name="firstName" value="${instance?.firstName}" />
								</td>
								<td valign="top" class="name">
									<label for="lastName">
										<gs:message code="user.lastName" default="Last Name" />
									</label>
									<span style="color:red;">*</span>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'lastName', 'errors')}">
									<g:textField name="lastName" value="${instance?.lastName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="email">
										<gs:message code="user.email" default="Email" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'email', 'errors')}">
									<g:textField name="email" value="${instance?.email}" />
								</td>
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name">
									<label for="mobilePhone">
										<gs:message code="user.mobilePhone" default="Mobile Telephone" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'mobilePhone', 'errors')}">
									<g:textField name="mobilePhone" value="${instance?.mobilePhone}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="workPhone">
										<gs:message code="user.workPhone" default="Work Telephone" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'workPhone', 'errors')}">
									<g:textField name="workPhone" value="${instance?.workPhone}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="homePhone">
										<gs:message code="user.homePhone" default="Home Telephone" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'homePhone', 'errors')}">
									<g:textField name="homePhone" value="${instance?.homePhone}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="addressLine1">
										<gs:message code="user.addressLine1" default="Address Line1" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'addressLine1', 'errors')}">
									<g:textField style="width:100%" name="addressLine1" value="${instance?.addressLine1}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="addressLine2">
										<gs:message code="user.addressLine2" default="Address Line2" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'addressLine2', 'errors')}">
									<g:textField style="width:100%" name="addressLine2" value="${instance?.addressLine2}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="city">
										<gs:message code="user.city" default="City/District" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'city', 'errors')}">
									<g:textField name="city" value="${instance?.city}" />
								</td>
								<td valign="top" class="name">
									<label for="state">
										<gs:message code="user.state" default="State/Province" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'state', 'errors')}">
									<g:textField name="state" value="${instance?.state}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="postalCode">
										<gs:message code="user.postalCode" default="Postal Code" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'postalCode', 'errors')}">
									<g:textField name="postalCode" value="${instance?.postalCode}" />
								</td>
								<td valign="top" class="name">
									<label for="country">
										<gs:message code="user.country" default="Country" />
									</label>
								</td>
								<td valign="top" class="value ${hasErrors(bean: instance, field: 'country', 'errors')}">
									<g:textField name="country" value="${instance?.country}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="photoImg">
										<gs:message code="user.photoImg" default="Photo Image" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'photoImgPath', 'errors')}">
									<input type="file" id="photoImg" name="photoImg" value="${instance.photoImgPath }"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="description">
										<gs:message code="user.description" default="Description" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
									<g:textArea style="width:100%" name="description" rows="5" cols="40" value="${instance?.description}" />
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.pwdAge" default="Password Age" />:</td>
								<td valign="top" class="value">
									<g:if test="${instance?.pwdAge==-1}">
										<gs:message code="user.pwdNeverExire" default="Password Never Expire"/>
									</g:if>
									<g:else>${instance?.pwdAge}</g:else>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="user.expiryDate" default="Expiry Date" />:</td>
								<td valign="top" class="value"><gs:formatDate date="${instance?.expiryDate}" /></td>
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
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="updateUser" valueKey="btn.update" value="Update" icon="database_save" />
				</gs:buttonBar>
			</g:uploadForm>
		</div>
	</body>
</html>
