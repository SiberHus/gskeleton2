<%@ page import="org.apache.commons.io.FilenameUtils" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<title><g:message code="simpleFileManager.list" default="SimpleFileManager List" /></title>
		<script type="text/javascript">
			var renameButtons = {};
			renameButtons[I18N.lang('btn.ok')] = function() { $('#renameForm').submit(); };
			renameButtons[I18N.lang('btn.cancel')] = function() { $(this).dialog("close"); };

			var newFileButtons = {};
			newFileButtons[I18N.lang('btn.ok')] = function() { $('#newFileForm').submit(); };
			newFileButtons[I18N.lang('btn.cancel')] = function() { $(this).dialog("close"); };

			var archiveButtons = {};
			archiveButtons[I18N.lang('btn.ok')] = function() {
				var actionForm = document.getElementById('bulkActionForm');
				Form.createField(actionForm, 'input',{
					'type':'hidden','name':'archiveName','value':$('#archiveName').val()
				});
				Form.createField(actionForm, 'input',{
					'type':'hidden','name':'replace','value':$('#archiveReplace').val()
				});
				submitAction(actionForm, 'bulkArchive');
			};
			archiveButtons[I18N.lang('btn.cancel')] = function() { $(this).dialog("close"); };
			
			$(function(){
				$('#renameDialog').dialog({
					modal: true,autoOpen: false,width: 300,
					buttons: renameButtons
				});
				$('#newFileDialog').dialog({
					modal: true,autoOpen: false,width: 300,
					buttons: newFileButtons
				});
				$('#archiveDialog').dialog({
					modal: true,autoOpen: false,width: 300,
					buttons: archiveButtons
				});
				$('a.deleteLink').click(function(){
					return confirm(I18N.lang('simpleFileManager.delete.confirm'));
				});
				$('a.renameLink').click(function(){
					var actionUrl = "${gs.createLink(action:'rename')}"+'?dirNodeName='+$(this).attr('dirNodeName')+
						'&pdir='+$(this).attr('pdir')+'&file='+$(this).attr('file');
					$('#renameForm').attr('action',actionUrl);
					$('#renameFrom').val($(this).attr('file'));
					$('#renameDialog').dialog('open');
				});
				$('#newFileLink').click(function(){
					var actionUrl = "${gs.createLink(action:'create')}?dirNodeName=${params.dirNodeName}&pdir=${pdir}";
					$('#newFileForm').attr('action',actionUrl);
					$('#newFileDialog').dialog('open');
				});
				$('#archiveLink').click(function(){
					$('#archiveDialog').dialog('open');
				});
			});
		</script>
	</head>
	<body>
		<gs:buttonBar>
			<g:render template="/commons/crud/closeWindowButton" plugin="gskeleton-two"/>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="simpleFileManager.list" default="SimpleFileManager List" /></h2>
			<div class="ui-widget-content ui-corner-all ui-helper-clearfix">
				&nbsp;
				<gs:image icon="folder_star"/>
				<g:link action="index">
					<gs:message code="simpleFileManager.rootNode" default="Root"/>
				</g:link>
				&nbsp;/&nbsp;
				&nbsp;
				<gs:image icon="folder"/>
				<g:link action="list" params="${[dirNodeName:params.dirNodeName]}">
					${params.dirNodeName}
				</g:link>
				&nbsp;/&nbsp;
				<g:each in="${linkList}" var="link">
					<gs:image icon="folder"/> ${link} &nbsp;/&nbsp;
				</g:each>
			</div>
			<br/>
			<g:if test="${!rootNode}">
				<g:uploadForm name="uploadForm" action="upload">
					<g:hiddenField name="dirNodeName" value="${params.dirNodeName}"/>
					<g:hiddenField name="pdir" value="${params.pdir}"/>
					<div class="ui-widget-content ui-corner-all ui-helper-clearfix">
						<input type="file" name="uploadFile"/>
						&nbsp;&nbsp;
						<input type="checkbox" id="override" name="override" value="true" ${override?'checked="checked"':''}/>
						<label for="override"><gs:message code="simpleFileManager.override" default="Override"/></label>
						&nbsp;&nbsp;
						<g:submitButton name="uploadBtn" value="${message(code:'simpleFileManager.action.upload',default:'Upload')}"/>
					</div>
				</g:uploadForm>
				<br/>
			</g:if>
			<g:form name="bulkActionForm">
			<input type="hidden" name="pdir" value="${params.pdir}"/>
			<input type="hidden" name="dirNodeName" value="${params.dirNodeName}"/>
			<g:if test="${!rootNode}">
				<gs:ifNotPopupPage>
					<gs:buttonBar>
						<gs:linkButton icon="page_refresh" action="list" params="${params}">
							<gs:message code="simpleFileManager.action.refresh" default="Refresh"/>
						</gs:linkButton>
						<gs:linkButton icon="page" id="newFileLink" url="#">
							<gs:message code="simpleFileManager.action.new" default="New"/>
						</gs:linkButton>
						<gs:linkSubmitButton icon="page_delete" form="bulkActionForm" action="bulkDelete">
							<gs:message code="simpleFileManager.action.delete" default="Delete"/>
						</gs:linkSubmitButton>
						<gs:linkSubmitButton icon="cut" form="bulkActionForm" action="bulkCut">
							<gs:message code="simpleFileManager.action.cut" default="Cut"/>
						</gs:linkSubmitButton>
						<gs:linkSubmitButton icon="page_copy" form="bulkActionForm" action="bulkCopy">
							<gs:message code="simpleFileManager.action.copy" default="Copy"/>
						</gs:linkSubmitButton>
						<gs:linkSubmitButton icon="page_paste" form="bulkActionForm" action="bulkPaste">
							<gs:message code="simpleFileManager.action.paste" default="Paste"/>
						</gs:linkSubmitButton>
						<gs:linkButton icon="compress" id="archiveLink" url="#">
							<gs:message code="simpleFileManager.action.archive" default="Archive"/>
						</gs:linkButton>
					</gs:buttonBar>
				</gs:ifNotPopupPage>
			</g:if>
			<br/>
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
							<g:if test="${rootNode}">
								<th><gs:message code="simpleFileManager.dirNodeName" default="Name"/></th>
								<th><gs:message code="simpleFileManager.nodeDesc" default="Description"/></th>
							</g:if>
							<g:else>
								<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
								<th style="width:20px;text-align:center"><gs:message code="list.action" default="Action"/></th>
								<th><gs:message code="simpleFileManager.fileName" default="Name"/></th>
								<th><gs:message code="simpleFileManager.fileSize" default="Size"/></th>
								<th><gs:message code="simpleFileManager.fileType" default="Type"/></th>
								<th><gs:message code="simpleFileManager.fileAttrs" default="Attributes"/></th>
								<th><gs:message code="simpleFileManager.fileDate" default="Date Modified"/></th>
							</g:else>
						</tr>
					</thead>
					<tbody>
					<g:if test="${rootNode}">
					<g:each in="${nodeMap.values()}" status="i" var="node">
						<tr>
							<td>
								<gs:image icon="folder_star"/>&nbsp; 
								<g:link action="list" params="${[dirNodeName:node.name]}">
									${node.name}
								</g:link>
							</td>
							<td>${node.description}</td>
						</tr>
					</g:each>
					</g:if>
					<g:else>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>
								<gs:image icon="folder"/>&nbsp;
								<g:if test="${pdir && pdir!='/'}">
									<g:link action="list" params="[dirNodeName:params.dirNodeName,pdir:pdir,goUp:true]">..</g:link>
								</g:if>
								<g:else>
									<g:link action="index">..</g:link>
								</g:else>
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					<g:each in="${fileList}" status="i" var="file">
						<tr>
							<td class="idcheck"><g:checkBox name="ids" value="${file.name}" checked="false"/></td>
							<td class="action">
							<gs:ifPopupPage>
								<gs:chooseLink refValue="${file.absolutePath}" refLabel="${file.name}"/>
							</gs:ifPopupPage>
							<gs:ifNotPopupPage>
								<gs:linkButton class="deleteLink" action="delete" params="[dirNodeName:params.dirNodeName,pdir:pdir,file:file.name]"
										icon="cross" title="${message(code:'simpleFileManager.action.delete',default:'Delete')}"/>
								&nbsp;&nbsp;
								<a name="${file.name}"/>
								<gs:linkButton class="renameLink" url="#${file.name}" dirNodeName="${params.dirNodeName}" pdir="${pdir}" file="${file.name}"
										icon="fonts" title="${message(code:'simpleFileManager.action.rename',default:'Rename')}"/>
							</gs:ifNotPopupPage>
							</td>
							<td>
								<g:if test="${file.isDirectory()}">
									<gs:image icon="folder"/>&nbsp;
									<g:link action="list" params="[dirNodeName:params.dirNodeName,pdir:pdir,file:file.name]">
										${file.name}
									</g:link>
								</g:if>
								<g:else>
									<gs:image icon="page"/>&nbsp;
									<g:link action="download" params="[dirNodeName:params.dirNodeName,pdir:pdir,file:file.name]"> 
										${file.name}
									</g:link>
								</g:else>
							</td>
							<td>
								${Math.ceil(file.length()>0?file.length()/1024:0) as int}
								<gs:message code="simpleFileManager.size.kb" default="KB"/>
							</td>
							<td>
								<g:if test="${file.isDirectory()}">
									<gs:message code="simpleFileManager.directory" default="File Folder"/>
								</g:if>
								<g:else>
									<gs:message code="simpleFileManager.file.${FilenameUtils.getExtension(file.name)}" default="File"/>
								</g:else>
							</td>
							<td>-</td>
							<td><gs:formatDatetime date="${file.lastModified()}" /></td>
						</tr>
					</g:each>
					</g:else>
					</tbody>
				</table>
			</div>
			</g:form>
		</div>


		<!-- Dialogs -->

		<div id="renameDialog" title="${message(code:'simpleFileManager.renameFile',default:'Rename File') }" class="hidden">
			<form id="renameForm" method="post" >
				<fieldset>
					<label>
						<gs:message code="simpleFileManager.rename.fromName" default="From Name " />:
					</label>
					<g:textField name="renameFrom" style="width:100%;" readonly="readonly"/>
					<label>
						<gs:message code="simpleFileManager.rename.toName" default="To Name " />:
					</label>
					<g:textField name="renameTo" style="width:100%"/>
				</fieldset>
			</form>
		</div>
		<div id="newFileDialog" title="${message(code:'simpleFileManager.newFileOrDir',default:'New File/Directory') }">
			<form id="newFileForm" method="post" />
				<fieldset>
					<div style="color:red">
						<gs:message code="simpleFileManager.separatorAdvice" args="${[File.separator]}"
							default="Use / (Forward slash) as file separator" />
					</div>
					<label>
						<gs:message code="simpleFileManager.fileName" default="File Name " />:
					</label>
					<g:textField name="newFileName" style="width:100%"/>
					<label>
						<gs:message code="simpleFileManager.fileType" default="File Type" />:
					</label>
					<g:radio name="newFileType" value="F"/>&nbsp;<gs:message code="simpleFileManager.file" default="File"/>&nbsp;&nbsp;
					<g:radio name="newFileType" value="D" checked="true"/>&nbsp;<gs:message code="simpleFileManager.directory" default="Directory"/>
					<br/><br/>
					<g:checkBox name="createParents" value="true"/>
					<gs:message code="simpleFileManager.createParentsAsNeeded" default="Create parents as needed " />:
				</fieldset>
			</form>
		</div>
		<div id="archiveDialog" title="${message(code:'simpleFileManager.newArchive',default:'New Archive') }">
			<form id="archiveForm" method="post" />
				<fieldset>
					<label>
						<gs:message code="simpleFileManager.archiveName" default="Archive Name " />:
					</label>
					<g:textField name="archiveName" style="width:100%"/>
					<br/><br/>
					<g:checkBox name="archiveReplace" value="true"/>
					<gs:message code="simpleFileManager.replaceExisting" default="Replace Existing File" />:
				</fieldset>
			</form>
		</div>
	</body>
</html>
