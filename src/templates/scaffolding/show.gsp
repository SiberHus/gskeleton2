<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}', default: '${className}')}" />
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
				<g:hiddenField name="id" value="\${instance?.id}" />
				<div class="dialog">
					<table>
						<tbody>
						<%  
							def realClass = domainClass.clazz
							excludedProps = ["version","dateCreated","lastUpdated",
									"createdDate","createdBy","modifiedDate","modifiedBy",
									Events.ONLOAD_EVENT,
									Events.BEFORE_INSERT_EVENT,
									Events.BEFORE_UPDATE_EVENT,
									Events.BEFORE_DELETE_EVENT]
							if(realClass.metaClass.hasProperty(realClass,'transients')){
								excludedProps.addAll(realClass.transients)
							}
							props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
							Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
							props.each { p -> %>
							<tr class="prop">
								<td valign="top" class="name">
									<gs:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" />:
								</td>
								<%  if (p.isEnum()) { %>
								<td valign="top" class="value">\${instance?.${p.name}?.encodeAsHTML()}</td>
								<%  } else if (p.oneToMany || p.manyToMany) { %>
								<td  valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="\${instance?.${p.name}}" var="${p.referencedDomainClass?.propertyName}Instance">
										<li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.referencedDomainClass?.propertyName}Instance.id}">\${${p.referencedDomainClass?.propertyName}Instance.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
								<%  } else if (p.manyToOne || p.oneToOne) { %>
								<td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${instance?.${p.name}?.id}">\${instance?.${p.name}?.encodeAsHTML()}</g:link></td>
								<%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
								<td valign="top" class="value"><g:formatBoolean boolean="\${instance?.${p.name}}" /></td>
								<%  } else if (p.type == Date.class || p.type == java.sql.Date.class ){ %>
								<td valign="top" class="value"><gs:formatDate date="\${instance?.${p.name}}" /></td>
								<%  } else if (p.type == java.sql.Timestamp.class || p.type == java.util.Calendar.class) { %>
								<td valign="top" class="value"><gs:formatDatetime date="\${instance?.${p.name}}" /></td>
								<%  } else if (p.type == java.sql.Time.class ) { %>
								<td valign="top" class="value"><gs:formatTime date="\${instance?.${p.name}}" /></td>
								<%  } else if (BigDecimal.class.isAssignableFrom(p.type)) { %>
								<td valign="top" class="value"><g:formatNumber number="\${instance?.${p.name}}" /></td>
								<%  } else if (Collection.class.isAssignableFrom(p.type)) { %>
								<td valign="top" class="value">
									<ul>
										<g:each in="\${instance?.${p.name}}">
										<li>\${it}</li>
										</g:each>
									</ul>
								</td>
								<%  } else { %>
								<td valign="top" class="value"><g:fieldValue bean="\${instance}" field="${p.name}"/></td>
								<%  } %>
							</tr>
							<%  } %>
							
						</tbody>
					</table>
				</div>
				<gs:buttonBar>
					<gs:linkSubmitButton action="edit" valueKey="crud.edit" value="Edit"
						icon="database_edit" />&nbsp;&nbsp;
					<gs:linkSubmitButton action="delete" valueKey="crud.delete" value="Delete"
						confirm="true" icon="database_delete"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
