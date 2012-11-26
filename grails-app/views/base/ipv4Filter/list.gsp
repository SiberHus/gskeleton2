<%@ page import="com.siberhus.gskeleton.base.Ipv4Filter" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'ipv4Filter', default: 'IPv4 Filter')}" />
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
			<gs:message code="ipv4Filter.yourIp" default="Your IP Address"/> &nbsp;:&nbsp;
			${ (request.remoteAddr=='0:0:0:0:0:0:0:1' || request.remoteAddr=='127.0.0.1')?'loopback':request.remoteAddr}
			<br/><br/>
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton"/>
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
							<th><gs:message code="ipv4Filter.ipAddress" default="IP Address"/></th>
							<g:sortableColumn property="http" title="HTTP" titleKey="ipv4Filter.http" params="${params }"/>
							<g:sortableColumn property="https" title="HTTPS" titleKey="ipv4Filter.https" params="${params }"/>
							<g:sortableColumn property="matchingSeq" title="Matching Sequence" titleKey="ipv4Filter.matchingSeq" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
						<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>${instance.toString()}</td>
							<td>
								<g:if test="${instance.http}">
									<g:message code="fieldValue.enabled" default="Enabled"/>
								</g:if>
								<g:else>
									<g:message code="fieldValue.disabled" default="Disabled"/>
								</g:else>
							</td>
							<td>
								<g:if test="${instance.https}">
									<g:message code="fieldValue.enabled" default="Enabled"/>
								</g:if>
								<g:else>
									<g:message code="fieldValue.disabled" default="Disabled"/>
								</g:else>
							</td>
							<td>${instance.matchingSeq}</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['ipv4Filter.count']}</span>)
			</div>
		</div>
	</body>
</html>
