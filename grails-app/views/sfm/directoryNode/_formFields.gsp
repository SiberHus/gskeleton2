<script type="text/javascript">
	$(function(){
		<g:if test="${!instance.recycleBinPath}">
			$('#disabledRecycleBin').attr('checked','checked');
			$('#recycleBinPath').val('').attr('disabled','disabled');
		</g:if>
		$('#disabledRecycleBin').click(function(){
			if($(this).attr('checked')){
				$('#recycleBinPath').val('').attr('disabled','disabled');
			}else{
				$('#recycleBinPath').removeAttr('disabled');
			}
		});
	});
</script>
<%@ page import="com.siberhus.gskeleton.base.Role; com.siberhus.gskeleton.sfm.DirectoryNode" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="directoryNode.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="directoryPath">
						<gs:message code="directoryNode.directoryPath" default="Directory Path" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'directoryPath', 'errors')}">
					<g:textField name="directoryPath" value="${instance?.directoryPath}" />
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="recycleBinPath">
						<gs:message code="directoryNode.recycleBinPath" default="Recycle Bin Path" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'recycleBinPath', 'errors')}">
					<g:textField name="recycleBinPath" value="${instance?.recycleBinPath}" />
					<input id="disabledRecycleBin" type="checkbox" />
					<label for="disabledRecycleBin">
						<gs:message code="directoryNode.disabledRecycleBin" default="Disabled"/>
					</label>
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="directoryNode.description" default="Description" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="acceptFileExts">
						<gs:message code="directoryNode.acceptFileExts" default="Accept File Exts" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'acceptFileExts', 'errors')}">
					<g:textField name="acceptFileExts" value="${instance?.acceptFileExts}" />
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="status">
						<gs:message code="directoryNode.status" default="Status" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'status', 'errors')}">
					<g:select name="status" from="${DirectoryNode.constraints.status.inList}"
						value="${instance?.status}" valueMessagePrefix="status" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="roles">
						<gs:message code="directoryNode.roles" default="Roles" />
					</label>
				</td>
				<td colspan="4" valign="top" class="value ${hasErrors(bean: instance, field: 'roles', 'errors')}">
					<g:select name="roles" from="${Role.list()}" size="5" multiple="yes"
						optionKey="id" value="${instance?.roles?.id}" noSelection="${session.noSelection}" class="gs_multiSelect" />
				</td>
			</tr>
		</tbody>
	</table>
</div>