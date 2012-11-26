<%@ page import="com.siberhus.gskeleton.base.User" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="username">
						<gs:message code="user.username" default="Username" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'username', 'errors')}">
					<g:textField name="username" value="${instance?.username}" />
				</td>
				<td valign="top" class="name">
					<label for="systemAdmin">
						<gs:message code="user.systemAdmin" default="System Admin?" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'username', 'errors')}">
					<g:checkBox name="systemAdmin" value="${instance?.systemAdmin}"/>
				</td>
			</tr>
			<g:if test="${actionName=='edit'||actionName=='update'}">
				<tr class="prop">
					<td valign="top" class="name">
						<label for="newPassword">
							<gs:message code="user.newPassword" default="New Password" />
						</label>
					</td>
					<td valign="top" class="value">
						<g:passwordField name="newPassword" value="${params.newPassword}" />
					</td>
					<td valign="top" class="name">
						<label for="newPassword2">
							<gs:message code="user.newPassword2" default="Confirm New Password" />
						</label>
					</td>
					<td valign="top" class="value">
						<g:passwordField name="newPassword2" value="${params.newPassword2}" />
					</td>
				</tr>
			</g:if>
			<g:elseif test="${actionName=='create'||actionName=='save'}">
				<tr class="prop">
					<td valign="top" class="name">
						<label for="password">
							<gs:message code="user.password" default="Password" />
						</label>
						<span style="color:red;">*</span>
					</td>
					<td valign="top" class="value ${hasErrors(bean: instance, field: 'password', 'errors')}">
						<g:passwordField name="password" value="${instance?.password}" />
					</td>
				</tr>
			</g:elseif>
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
					<span style="color:red;">*</span>
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
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">
					<label for="auditTrail">
						<gs:message code="user.auditTrail" default="Audit Trail" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'auditTrail', 'errors')}">
					<g:checkBox name="auditTrail" value="${instance?.auditTrail}" />
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">
					<label for="pwdAge">
						<gs:message code="user.pwdAge" default="Password Age" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'pwdAge', 'errors')}">
					<g:textField name="pwdAge" value="${instance.pwdAge}" class="decimal" />
				</td>
				<td colspan="2" valign="top" class="name">
					<input type="checkbox" id="pwdNeverExpire" ${instance.pwdAge==-1?'checked="checked"':''}/>
					<gs:message code="user.passwordNeverExpire" default="Never Expire"/>
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">
					<label for="expiryDate">
						<gs:message code="user.expiryDate" default="Expiry Date" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'expiryDate', 'errors')}">
					<g:textField name="expiryDate" value="${gs.formatDate(date:instance.expiryDate)}" class="date" />
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">
					<label for="roles">
						<gs:message code="user.roles" default="Roles" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'roles', 'errors')}">
					<gs:listLookup name="roles" from="${instance.roles}" value="${instance?.roles?.id}"
						lookupUrl="${gs.createLink(controller:'role',action:'list')}"/>
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="user.permissions" default="Permissions" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'permissions', 'errors')}">
					<table id="permissionTbl" class="dynamicValueComp" style="width:100%">
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
					<label for="status">
						<gs:message code="user.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${User.constraints.status.inList}"
						value="${instance.status}" valueMessagePrefix="status" />
				</td>
			</tr>
		</tbody>
	</table>
</div>