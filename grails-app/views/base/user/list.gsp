
<%@ page import="com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'user', default: 'User')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton"/>
			<gs:ifNotPopupPage>
				<gs:linkButton action="create" icon="database_add">
					<gs:message code="default.new.label" args="[entityName]" />
				</gs:linkButton>
			</gs:ifNotPopupPage>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="crud.searchBox"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<gs:includePopupFields/>
				<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="username">
										<gs:message code="user.username" default="Username" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="username" value="${instance?.username}" />
								</td>
								<td valign="top" class="name">
									<label for="systemAdmin">
										<gs:message code="user.systemAdmin" default="System Admin" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="systemAdmin" value="${instance?.systemAdmin}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="firstName">
										<gs:message code="user.firstName" default="First Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="firstName" value="${instance?.firstName}" />
								</td>
								<td valign="top" class="name">
									<label for="lastName">
										<gs:message code="user.lastName" default="Last Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="lastName" value="${instance?.lastName}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="email">
										<gs:message code="user.email" default="Email" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="email" value="${instance?.email}" class="email" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="expiryDate">
										<gs:message code="user.expiryDate" default="Expiry Date" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="expiryDate" value="${gs.formatDate(date:instance?.expiryDate)}" class="date"/>
									<strong>-</strong>
									<g:textField name="expiryDate_" value="${gs.formatDate(date:instance?.expiryDate_)}" class="date"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="status">
										<gs:message code="user.status" default="Status" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:select name="status" from="${User.constraints.status.inList}" 
										value="${instance?.status}" valueMessagePrefix="status"
										noSelection="${session.noSelection}"/>
								</td>
							</tr>
						</tbody>
					</table>
					<g:render template="/commons/crud/searchControls" />
				</g:form>
			</div>
			</div>
			</div>
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton"/>
			
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<g:sortableColumn property="username" title="Username" titleKey="user.username" params="${params }"/>
							<g:sortableColumn property="fullName" title="FullName" titleKey="user.fullName" params="${params }"/>
							<g:sortableColumn property="email" title="Email" titleKey="user.email" params="${params }"/>
							<g:sortableColumn property="auditTrail" title="Audit Trail" titleKey="user.auditTrail" params="${params }"/>
							<g:sortableColumn property="expiryDate" title="Expiry Date" titleKey="user.expiryDate" params="${params }"/>
							<g:sortableColumn property="status" title="Status" titleKey="user.status" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>
								${fieldValue(bean: instance, field: "username")}
								<g:if test="${instance.status!='A'}">
									&nbsp;<gs:image icon="lock"/>
								</g:if>
							</td>
							<td>${fieldValue(bean: instance, field: "fullName")}</td>
							<td>${fieldValue(bean: instance, field: "email")}</td>
							<td>${fieldValue(bean: instance, field: "auditTrail")}</td>
							<td>${fieldValue(bean: instance, field: "expiryDate")}</td>
							<td><gs:message code="status.${instance.status}"/></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['user.count']}</span>)
			</div>
		</div>
	</body>
</html>
