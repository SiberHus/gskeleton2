
<%@ page import="foo.bar.BreedType" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'breedType', default: 'BreedType')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton" plugin="gskeleton-two"/>
			<gs:ifNotPopupPage>
				<gs:linkButton action="create" icon="database_add">
					<gs:message code="default.new.label" args="[entityName]" />
				</gs:linkButton>
			</gs:ifNotPopupPage>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="searchBox" default="Search Box"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<gs:includePopupFields/>
					<table>
						<tbody>
						
							<tr class="prop">
								<td valign="top" class="name">
									<label for="code">
										<gs:message code="breedType.code" default="Code" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="code" value="${instance?.code}" />

									
								</td>
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name">
									<label for="name">
										<gs:message code="breedType.name" default="Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="name" value="${instance?.name}" />

									
								</td>
							</tr>
						
						</tbody>
					</table>
					<g:render template="/commons/crud/searchControls" plugin="gskeleton-two"/>
				</g:form>
			</div>
			</div>
			</div>
			
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton" plugin="gskeleton-two"/>
			
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
						
							<g:sortableColumn property="code" title="Code" titleKey="breedType.code" params="${params }"/>
						
							<g:sortableColumn property="name" title="Name" titleKey="breedType.name" params="${params }"/>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
						<g:render template="/commons/crud/listItemAction" model="[instance:instance]" plugin="gskeleton-two"/>
						
							<td><g:fieldValue bean="${instance}" field="code"/></td>
						
							<td><g:fieldValue bean="${instance}" field="name"/></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['breedType.count']}</span>)
			</div>
		</div>
	</body>
</html>
