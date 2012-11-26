<% 
import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events
import org.codehaus.groovy.grails.commons.ApplicationHolder
%>
<%=packageName%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="\${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}', default: '${className}')}" />
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
			<%
				def realClass = domainClass.clazz
				def includedProps = []
				if(realClass.metaClass.hasProperty(realClass,'searchFields')){
			%>
			<div class="searchbox">
			<div class="searchbox-header"><gs:message code="searchBox" default="Search Box"/></div>
			<div class="searchbox-content">
			<div class="dialog">
				<g:form method="post">
				<gs:includePopupFields/>
					<table>
						<tbody>
						<%  
							realClass.searchFields.keySet().each{
								if(it.endsWith('id')){
									def sFieldParts = it.split('\\.')
									if(sFieldParts.length==2){
										includedProps << sFieldParts[0]
									}
								}else{
									includedProps << it
								}
							}
							props = domainClass.properties.findAll { includedProps.contains(it.name) }
							Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
							props.each { p ->
								cp = domainClass.constrainedProperties[p.name]
								display = (cp ? cp.display : true)
								if (display) { %>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="${p.name}">
										<gs:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" />
									</label>
								</td>
								<td valign="top" class="value">
									${renderEditor(p)}
									<%if(realClass.searchFields[p.name]=='between'){ %>[between!!]<%} %>
								</td>
							</tr>
						<%  }   } %>
						</tbody>
					</table>
					<g:render template="/commons/crud/searchControls" plugin="gskeleton-two"/>
				</g:form>
			</div>
			</div>
			</div>
			<%} %>
			<g:form name="bulkDeleteForm" action="bulkDelete">
			<g:render template="/commons/crud/bulkDeleteButton" plugin="gskeleton-two"/>
			
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
							<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="\${params }"/>
						<%
							if(realClass.metaClass.hasProperty(realClass,'listFields')){
								props = domainClass.properties.findAll { realClass.listFields.contains(it.name) && it.type != Set.class }
							}else{
								excludedProps = ["version","id","dateCreated","lastUpdated",
											"createdDate","createdBy","modifiedDate","modifiedBy",
											 Events.ONLOAD_EVENT,
											 Events.BEFORE_INSERT_EVENT,
											 Events.BEFORE_UPDATE_EVENT,
											 Events.BEFORE_DELETE_EVENT]
								props = domainClass.properties.findAll { !excludedProps.contains(it.name) && it.type != Set.class }
							}
							Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
							props.eachWithIndex { p, i ->
							if (i < 6) {
								if (p.isAssociation()) { %>
							<th><gs:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" /></th>
						<%	} else { %>
							<g:sortableColumn property="${p.name}" title="${p.naturalName}" titleKey="${domainClass.propertyName}.${p.name}" params="\${params }"/>
						<%  }   }   } %>
						</tr>
					</thead>
					<tbody>
					<g:each in="\${instanceList}" status="i" var="instance">
						<tr>
						<g:render template="/commons/crud/listItemAction" model="[instance:instance]" plugin="gskeleton-two"/>
						<%  props.eachWithIndex { p, i ->
								if (i < 6) {
									if (p.type == Boolean.class || p.type == boolean.class) { %>
							<td><g:formatBoolean boolean="\${instance.${p.name}}" /></td>
						<%		  } else if (p.type == Date.class || p.type == java.sql.Date.class){ %>
							<td><gs:formatDate date="\${instance.${p.name}}" /></td>
						<%		  } else if (p.type == java.sql.Timestamp.class || p.type == java.util.Calendar.class){ %>
							<td><gs:formatDatetime date="\${instance.${p.name}}" /></td>
						<%		  } else if (p.type == java.sql.Time.class){ %>
							<td><gs:formatTime date="\${instance.${p.name}}" /></td>
						<%		  } else if (BigDecimal.class.isAssignableFrom(p.type)) { %>
							<td><g:formatNumber number="\${instance.${p.name}}" /></td>
						<%		  } else { %>
							<td><g:fieldValue bean="\${instance}" field="${p.name}"/></td>
						<%  }   }   } %>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="\${instanceTotal}" params="\${params }"/>
				(<span id='resultTotals'>\${session['${domainClass.propertyName}.count']}</span>)
			</div>
		</div>
	</body>
</html>
