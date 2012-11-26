
<%@ page import="com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'user', default: 'User')}" />
		<g:render template="/base/user/script" />
		<g:render template="/base/permission/script" />
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
			<h2><gs:message code="default.edit.label" args="[entityName]" /></h2>
			<g:uploadForm method="post">
				<g:hiddenField name="id" value="${instance?.id}" />
				<g:hiddenField name="version" value="${instance?.version}" />
				<g:render template="/base/user/formFields" />
				<br/><br/>
				<gs:buttonBar>
					<gs:linkSubmitButton action="update" valueKey="btn.update" value="Update" icon="database_save" />
					&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
					&nbsp;&nbsp;
					<gs:linkSubmitButton action="unlock" valueKey="btn.unlock" value="Unlock"
						confirm="true" confirmMessage="${message(code:'_warn.user.unlockDoesNotSave',default:'Unlocking does not save any user data')}"
						icon="lock_open"/>
				</gs:buttonBar>
			</g:uploadForm>
		</div>
	</body>
</html>
