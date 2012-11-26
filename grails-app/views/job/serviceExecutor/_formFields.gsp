
<script type="text/javascript">
	function generateTypeSelect(id, targetId, selectedVal){
		var html = "<select id='"+id+"' name='paramType' targetId='"+targetId+"'>";
		var types = ['string','int','long','float','double','boolean','date','time','datetime'];
		for(var i in types){
			html += "<option value='"+types[i]+"'";
			if(types[i]==selectedVal){
				html += " selected='selected'";
			}
			html += ">"+types[i]+"</option>";
		}
		html += "</select>";
		return html;
	}
	function addParameterRow(paramName, paramType, defaultValue, paramDesc){
		TableUI.addRow('serviceParameterTbl', [
			"<input type='text' id='paramName_"+rowNum+"' name='paramName' value='"+paramName+"'/>&nbsp;",
			generateTypeSelect('paramType_'+rowNum, 'paramValue_'+rowNum, paramType)+"&nbsp;",
			"<input type='text' id='paramValue_"+rowNum+"' name='defaultValue' value='"+defaultValue+"'/>&nbsp;",
			"<input type='text' id='paramDesc_"+rowNum+"' name='paramDesc' value='"+paramDesc+"'/>&nbsp;",
			"<a style='cursor:pointer;' onclick='TableUI.deleteRow(this);'>"+'${gs.image(icon:'delete')}'+"</a>"
		],function(){
		});
	}
	$(function(){
		<g:each in="${instance?.serviceParameters}" var="serviceParameter">
			addParameterRow('${serviceParameter.name}','${serviceParameter.type}','${serviceParameter.defaultValue?.encodeAsJavaScript()}','${serviceParameter.description}');
		</g:each>
	});
</script>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="serviceExecutor.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="serviceName">
						<gs:message code="serviceExecutor.serviceName" default="Service Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'serviceName', 'errors')}">
					<g:textField name="serviceName" value="${instance?.serviceName}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="methodName">
						<gs:message code="serviceExecutor.methodName" default="Method Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'methodName', 'errors')}">
					<g:textField name="methodName" value="${instance?.methodName}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="concurrent">
						<gs:message code="serviceExecutor.concurrent" default="Concurrent" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'concurrent', 'errors')}">
					<g:checkBox name="concurrent" value="${instance?.concurrent}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="serviceExecutor.description" default="Description" />
					</label>
				</td>
				<td colspan="3" valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="serviceExecutor.serviceParameters" default="Job Parameters" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'serviceParameters', 'errors')}">
					<table id="serviceParameterTbl" style="width:100%">
						<tr>
							<td colspan="5">
								<input type="button" onclick="addParameterRow('','','','');" value="+"/>
							</td>
						</tr>
						<tr class="ui-widget-header">
							<th><gs:message code="serviceParameter.name" default="Parameter Name"/></th>
							<th><gs:message code="serviceParameter.type" default="Parameter Type"/></th>
							<th><gs:message code="serviceParameter.defaultValue" default="Default Value"/></th>
							<th><gs:message code="serviceParameter.desc" default="Description"/></th>
							<th style="width:25px">&nbsp;</th>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>