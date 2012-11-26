
<%@ page import="com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminLayout" />
		<title><g:message code="user.edit" default="Edit User" /></title>
	</head>
	<body>
		<g:render template="/base/personalProfile/personalBar" />
		<div class="body">
			<h2><gs:message code="user.changePassword" default="Change Password" /></h2>
			<g:form method="post" >
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
									<gs:message code="user.pwdChangedDate" default="Last Password Changed" />:
								</td>
								<td valign="top" class="value"><gs:formatDate date="${instance?.pwdChangedDate}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="newPassword">
										<gs:message code="user.newPassword" default="New Password" />
									</label>
									<span style="color:red;">*</span>
								</td>
								<td valign="top" class="value">
									<g:passwordField name="newPassword" value="${params.newPassword}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="newPassword2">
										<gs:message code="user.newPassword2" default="Confirm New Password" />
									</label>
									<span style="color:red;">*</span>
								</td>
								<td valign="top" class="value">
									<g:passwordField name="newPassword2" value="${params.newPassword2}" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="updatePassword" valueKey="btn.update" value="Update" icon="database_save" />
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
