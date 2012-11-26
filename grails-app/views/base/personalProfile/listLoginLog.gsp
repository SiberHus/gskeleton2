
<%@ page import="com.siberhus.gskeleton.base.LoginLog" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminLayout" />
		<title><g:message code="loginLog.list" default="LoginLog List" /></title>
	</head>
	<body>
		<g:render template="/base/personalProfile/personalBar" />
		<div class="body">
			<h2><gs:message code="loginLog.list" default="LoginLog List" /></h2>
			<div class="list">
				<table>
					<thead>
						<tr>
                   	    <g:sortableColumn property="id" title="Id" titleKey="loginLog.id"/>
				   		<g:sortableColumn property="username" title="Username" titleKey="loginLog.username" params="${params }"/>						
				   		<g:sortableColumn property="ipAddress" title="Ip Address" titleKey="loginLog.ipAddress" params="${params }"/>						
				   		<g:sortableColumn property="language" title="Language" titleKey="loginLog.language" params="${params }"/>						
				   		<g:sortableColumn property="userAgent" title="User Agent" titleKey="loginLog.userAgent" params="${params }"/>						
				   		<g:sortableColumn property="loginDate" title="Login Date" titleKey="loginLog.loginDate" params="${params }"/>						
				   		<g:sortableColumn property="logoutDate" title="Logout Date" titleKey="loginLog.logoutDate" params="${params }"/>						
						</tr>
					</thead>
					<tbody>
					<g:each in="${loginLogInstanceList}" status="i" var="loginLogInstance">
						<tr>
						<td>${loginLogInstance.id}</td>
						<td>${loginLogInstance.username}</td>
						<td>${loginLogInstance.ipAddress}</td>
						<td>${application['_languageMap'][loginLogInstance.language]}</td>
						<td>${loginLogInstance.userAgent}</td>
						<td><gs:formatDatetime date="${loginLogInstance.loginDate}"/></td>
						<td><gs:formatDatetime date="${loginLogInstance.logoutDate}" /></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			<div class="paginateButtons">
				<g:paginate total="${loginLogInstanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${loginLogInstanceTotal}</span>)
			</div>
		</div>
	</body>
</html>
