<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<div class="dialog">
	<table>
		<tbody>
		<%
			def realClass = domainClass.clazz
			def lookupProps = [:]
			if(realClass.metaClass.hasProperty(realClass,'lookupFields')){
				lookupProps = realClass.lookupFields
			}
			excludedProps = ["version","id","dateCreated","lastUpdated",
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
			props.each { p ->
				cp = domainClass.constrainedProperties[p.name]
				display = (cp ? cp.display : true)
				if (display) { %>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="${p.name}">
						<gs:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" />
					</label>
					<% if(!domainClass.constraints[p.name].nullable){%><span style="color:red;">*</span><% } %>
				</td>
				<td valign="top" class="value \${hasErrors(bean: instance, field: '${p.name}', 'errors')}">
					<%	if(lookupProps.containsKey(p.name)){
							if(java.util.Collection.isAssignableFrom(domainClass.getPropertyByName(p.name).type)){
					%>
					<gs:listLookup name="${p.name}" from="\${instance.${p.name}}"
						optionKey="id" value="\${instance?.${p.name}?.id}"
						lookupUrl="\${createLink(controller:'${lookupProps[p.name]}',action:'list')}"/>
					<%}else{%>
					<gs:fieldLookup name="${p.name}" value="\${instance?.${p.name}?.id}"
						lookupUrl="\${createLink(controller:'${lookupProps[p.name]}',action:'list')}"/>
					<%}}else{%>
					${renderEditor(p)}<%}%>
				</td>
			</tr>
			<%}}%>
		</tbody>
	</table>
</div>