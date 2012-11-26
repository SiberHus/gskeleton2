<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'loginFailureLog', default: 'Login Failure Log')}" />
	</head>
	<body>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			<g:if test="${!SysConfig.get('security.log.loginFailure')}"> 
				<div class="ui-state-highlight ui-corner-all">
					<gs:message code="loginFailureLog.disabledMessage" default="Login Failure Log is disabled"/>
				</div>
			</g:if>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="crud.searchBox"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="username">
										<gs:message code="loginFailureLog.username" default="Username" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="username" value="${instance?.username}" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="ipAddress">
										<gs:message code="loginFailureLog.ipAddress" default="Ip Address" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="ipAddress" value="${instance?.ipAddress}" />
								</td>
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name">
									<label for="language">
										<gs:message code="loginFailureLog.language" default="Language" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="language" from="${application['_languageMap']}"
										optionKey="key" optionValue="value" value="${instance?.language}" 
										noSelection="${session.noSelection}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="userAgent">
										<gs:message code="loginFailureLog.userAgent" default="User Agent" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="userAgent" value="${instance?.userAgent}" />
									&nbsp;&nbsp;
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="tryDate">
										<gs:message code="loginFailureLog.tryDate" default="Try Date" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="tryDate" value="${gs.formatDatetime(date: instance?.tryDate)}" class="datetime" />
									<strong>-</strong>
									<g:textField name="tryDate_" value="${gs.formatDatetime(date: instance?.tryDate_)}" class="datetime" />
									&nbsp;(${SysConfig.get('converter.datetimePattern')})
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
				   		<g:sortableColumn property="username" title="Username" titleKey="loginFailureLog.username" params="${params }"/>
				   		<g:sortableColumn property="ipAddress" title="Ip Address" titleKey="loginFailureLog.ipAddress" params="${params }"/>
				   		<g:sortableColumn property="language" title="Language" titleKey="loginFailureLog.language" params="${params }"/>
				   		<g:sortableColumn property="userAgent" title="User Agent" titleKey="loginFailureLog.userAgent" params="${params }"/>
				   		<g:sortableColumn property="tryDate" title="Try Date" titleKey="loginFailureLog.tryDate" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
						<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
						<td class="action">
							<gs:linkButton action="show" id="${instance.id}" icon="eye" title="${message(code:'crud.list.show',default:'show')}"/>&nbsp;&nbsp;
						</td>
							<td>${fieldValue(bean: instance, field: "username")}</td>
							<td>${instance.ipAddress}</td>
							<td>${application['_languageMap'][instance.language]}</td>
							<td>${instance.userAgent}</td>
							<td><gs:formatDatetime date="${instance.tryDate}"  /></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['loginFailureLog.count']}</span>)
			</div>
		</div>
	</body>
</html>
