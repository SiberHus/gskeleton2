<%@ page import="com.siberhus.gskeleton.doc.Faq" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'faq', default: 'FAQ')}" />
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
			<h2><gs:message code="default.show.label" args="[entityName]" /></h2>
			<g:form>
				<g:hiddenField name="id" value="${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.id" default="Id" />:</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.question" default="Question" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "question")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.answer" default="Answer" />:</td>
								<td valign="top" class="value">
									<div style="border-style: dotted;border-color: green;border-width: thin;">
										${instance?.answer}
									</div>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.pinned" default="Pinned" />:</td>
								<td valign="top" class="value"><g:formatBoolean boolean="${instance?.pinned}" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.displayOrder" default="Display Order" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "displayOrder")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="faq.readCount" default="Read Count" />:</td>
								<td valign="top" class="value">${fieldValue(bean: instance, field: "readCount")}</td>
							</tr>
							<g:render template="/commons/crud/showAuditFields" />
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" valueKey="btn.edit" value="Edit"
						icon="database_edit" />&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="btn.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar> 
			</g:form>
		</div>
	</body>
</html>
