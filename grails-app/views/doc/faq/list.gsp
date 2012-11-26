<%@ page import="com.siberhus.gskeleton.doc.FaqCategory; com.siberhus.gskeleton.doc.Faq" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminListLayout" />
		<g:set var="entityName" value="${message(code: 'faq', default: 'FAQ')}" />
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton" />
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
									<label for="question">
										<gs:message code="faq.category" default="Category" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:select name="category.id" from="${FaqCategory.list()}"
										optionKey="id" optionValue="name" value="${instance?.category?.id}"
										noSelection="${session.noSelection}"/>
									&nbsp;&nbsp;
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="question">
										<gs:message code="faq.question" default="Question" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="question" value="${instance?.question}" />
									&nbsp;&nbsp;
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
				   		<g:sortableColumn property="question" title="Question" titleKey="faq.question" params="${params }"/>
				   		<g:sortableColumn property="pinned" title="Pinned" titleKey="faq.pinned" params="${params }"/>
				   		<g:sortableColumn property="readCount" title="Read Count" titleKey="faq.readCount" params="${params }"/>	
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<g:render template="/commons/crud/listItemAction" model="[instance:instance]"/>
							<td>${fieldValue(bean: instance, field: "question")}</td>
							<td><g:formatBoolean boolean="${instance.pinned}" /></td>
							<td>${fieldValue(bean: instance, field: "readCount")}</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['faq.count']}</span>)
			</div>
		</div>
	</body>
</html>
