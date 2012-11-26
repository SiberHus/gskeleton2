<script type="text/javascript">
	$(function(){
		$('#controllerName').change(function(){
			$('#wait_actionName').show();
			SelectUI.clear('actionName');
			$.getJSON('${gs.createLink(controller:"system",action:"jsonFindAllActionsByController")}',
				{controllerName:$(this).val()}
				,function(data){
					$.each(data, function(){
						SelectUI.addOption('actionName',this,this);
					});
					$('#wait_actionName').hide();
				}
			);
		});
		<g:if test="${instance.targetUrl}">
			$('#destRouteSysTr').hide();
			$('#destRouteCusTr').show();
		</g:if>
		$('#destRouteSys').click(function(){
			$('#destRouteSysTr').show();
			$('#destRouteCusTr').hide();
		});
		$('#destRouteCus').click(function(){
			$('#destRouteSysTr').hide();
			$('#destRouteCusTr').show();
		});
	});
</script>
<%@ page import="com.siberhus.gskeleton.base.AdminMenu" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="code">
						<gs:message code="adminMenu.code" default="Code" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'code', 'errors')}">
					<g:textField name="code" value="${instance?.code}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="adminMenu.parent" default="Parent" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'parent', 'errors')}">
					<gs:fieldLookup name="parent.id" value="${instance?.parent?.id}"
						labelValue="${instance?.parent?.code}"
						lookupUrl="${createLink(controller:'adminMenu',action:'list')}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="adminMenu.children" default="Children" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'children', 'errors')}">
					<ul>
						<g:each in="${instance?.children}" var="adminMenuInstance">
							<li><g:link controller="adminMenu" action="show" id="${adminMenuInstance?.id}">${adminMenuInstance?.encodeAsHTML()}</g:link></li>
						</g:each>
					</ul>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="labelKey">
						<gs:message code="adminMenu.labelKey" default="Label Key" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'labelKey', 'errors')}">
					<g:textField name="labelKey" value="${instance?.labelKey}" />
				</td>
				<td valign="top" class="name">
					<label for="label">
						<gs:message code="adminMenu.label" default="Default Label" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'label', 'errors')}">
					<g:textField name="label" value="${instance?.label}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="imageIcon">
						<gs:message code="adminMenu.imageIcon" default="Image Icon" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'imageIcon', 'errors')}">
					<g:textField name="imageIcon" value="${instance?.imageIcon}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="adminMenu.destinationRoute" default="Destination Route" />
					</label>
				</td>
				<td valign="top" class="value">
					<input id="destRouteSys" type="radio" name="destRoute" value="system" ${!instance?.targetUrl?'checked="checked"':''}/>
					<label for="destRouteSys"><gs:message code="adminMenu.destRoute.system" default="System"/></label>&nbsp;&nbsp;
					<input id="destRouteCus" type="radio" name="destRoute" value="custom" ${instance?.targetUrl?'checked="checked"':''}/>
					<label for="destRouteCus"><gs:message code="adminMenu.destRoute.custom" default="Custom"/></label>
				</td>
			</tr>
			<tr id="destRouteSysTr" class="prop">
				<td valign="top" class="name">
					<label for="controllerName">
						<gs:message code="adminMenu.controllerName" default="Controller" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'controllerName', 'errors')}">
					<%
						def controllerNames = grailsApplication.controllerClasses*.logicalPropertyName
						Collections.sort(controllerNames)
					%>
					<g:select name="controllerName" from="${controllerNames}" value="${instance?.controllerName}"
						noSelection="${session.noSelection}" class="combo"/>
				</td>
				<td valign="top" class="name">
					<label for="actionName">
						<gs:message code="adminMenu.actionName" default="Action" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'actionName', 'errors')}">
					<span id="wait_actionName" class="spinner hidden">&nbsp;</span>
					<select id="actionName" name="actionName" />
				</td>
			</tr>
			<tr id="destRouteCusTr" class="prop hidden">
				<td valign="top" class="name">
					<label for="targetUrl">
						<gs:message code="adminMenu.targetUrl" default="Target Url" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'targetUrl', 'errors')}">
					<g:textField name="targetUrl" value="${instance?.targetUrl}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="targetName">
						<gs:message code="adminMenu.targetName" default="Target Name" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'targetName', 'errors')}">
					<g:select name="targetName" from="${AdminMenu.constraints.targetName.inList}"
							value="${instance.targetName}" valueMessagePrefix="adminMenu.targetName"
							noSelection="${session.noSelection}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="menuOrder">
						<gs:message code="adminMenu.menuOrder" default="Order" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'menuOrder', 'errors')}">
					<g:textField name="menuOrder" value="${instance?.menuOrder}" class="decimal" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="adminMenu.description" default="Description" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="adminMenu.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${AdminMenu.constraints.status.inList}" value="${instance.status}"
						valueMessagePrefix="status"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="roles">
						<gs:message code="adminMenu.roles" default="Roles" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'roles', 'errors')}">
					<g:select name="roles" from="${com.siberhus.gskeleton.base.Role.list()}"
						size="5" multiple="yes" optionKey="id" value="${instance?.roles?.id}"
						noSelection="${session.noSelection}" class="gs_multiSelect"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>