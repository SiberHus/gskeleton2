<%@ page import="org.apache.commons.lang.StringUtils; com.siberhus.gskeleton.util.Log4jAppenderFactory; com.siberhus.gskeleton.cfg.log4j.Log4jAppender" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'log4jAppender', default: 'Log4j Appender')}" />
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
								<td valign="top" class="name">
									<gs:message code="log4jAppender.id" default="Id" />:
								</td>
								<td valign="top" class="value">${instance?.id}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="log4jAppender.name" default="Name" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="name"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="log4jAppender.type" default="Type" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="type"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="log4jAppender.threshold" default="Threshold" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="threshold"/></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="log4jAppender.conversionPattern" default="Conversion Pattern" />:
								</td>
								<td valign="top" class="value"><g:fieldValue bean="${instance}" field="conversionPattern"/></td>
							</tr>
						</tbody>
					</table>
					<table style="width: 80%">
						<caption>
							<g:if test="${type==Log4jAppenderFactory.SMTP}">
								<gs:message code="log4jAppender.smtp.props" default="SMTP Properties"/>
							</g:if>
							<g:else>
								<gs:message code="log4jAppender.file.props" default="File Properties"/>
							</g:else>
						</caption>
						<tbody>
							<g:each var="prop" in="${instance?.props}">
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="log4jAppender.props.${prop.key}" default="${StringUtils.capitalize(prop.key)}"/>
								</td>
								<td valign="top" class="value">
									${prop.value}
								</td>
							</tr>
							</g:each>
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
