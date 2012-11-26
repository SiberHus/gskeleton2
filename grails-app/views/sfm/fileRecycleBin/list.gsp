<%@ page import="com.siberhus.gskeleton.sfm.FileRecycleBin" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="${gs.layout(popup:'adminPopup',main:'adminList')}Layout" />
		<g:set var="entityName" value="${message(code: 'fileRecycleBin', default: 'File RecycleBin')}" />
		<script type="text/javascript">
			$(function(){
				$('a.restoreLink').click(function(){
					return confirm(I18N.lang('fileRecycleBin.restore.confirm'));
				});
			});
		</script>
	</head>
	<body>
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
									<label for="directoryNode.id">
										<gs:message code="fileRecycleBin.directoryNode" default="Directory Node" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:select name="directoryNode.id" from="${com.siberhus.gskeleton.sfm.DirectoryNode.list()}"
										optionKey="id" value="${instance?.directoryNode?.id}" noSelection="['': 'Select One...']" class="combo" />
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="fileName">
										<gs:message code="fileRecycleBin.fileName" default="File Name" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:textField name="fileName" value="${instance?.fileName}" />
								</td>
								<td valign="top" class="name">
									<label>
										<gs:message code="fileRecycleBin.fileType" default="File Type" />
									</label>
								</td>
								<td valign="top" class="value">
									<g:radio id="fileType.directory" value="D" name="fileType" checked="${instance?.fileType=='D'}"/>
									<label for="fileType.directory">
										<gs:message code="fileRecycleBin.fileType.directory" default="Directory" />
									</label>
									<g:radio id="fileType.file" value="F" name="fileType" checked="${instance?.fileType=='F'}"/>
									<label for="fileType.file">
										<gs:message code="fileRecycleBin.fileType.file" default="File" />
									</label>
									<g:radio id="fileType.all" value="" name="fileType" checked="${instance?.fileType==null}"/>
									<label for="fileType.all">
										<gs:message code="fileRecycleBin.fileType.all" default="All" />
									</label>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="deletedDate">
										<gs:message code="fileRecycleBin.deletedDate" default="Deleted Date" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="deletedDate" value="${ gs.formatDatetime(date:instance?.deletedDate)}" class="datetime" />
									<strong>-</strong>
									<g:textField name="deletedDate_" value="${ gs.formatDatetime(date:instance?.deletedDate_)}" class="datetime" />
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
			<%
				params.remove('directoryNode')
			%>
			<div class="list">
				<table>
					<thead class="ui-widget-header">
						<tr>
						<th style="width:20px;"><input id="allIdsChk" type="checkbox" /></th>
						<g:sortableColumn property="id" title="Action" titleKey="list.action" class="action" params="${params }"/>
						<%--<th><gs:message code="fileRecycleBin.directoryNode" default="Directory Node" /></th>--%>
						<g:sortableColumn property="directoryNode.id" title="Directory Node" titleKey="fileRecycleBin.directoryNode" params="${params }"/>
						<g:sortableColumn property="originalPath" title="File Path" titleKey="fileRecycleBin.originalPath" params="${params }"/>
						<g:sortableColumn property="fileType" title="File Type" titleKey="fileRecycleBin.fileType" params="${params }"/>
						<g:sortableColumn property="checksum" title="Checksum" titleKey="fileRecycleBin.checksum" params="${params }"/>
				   		<g:sortableColumn property="deletedDate" title="Deleted Date" titleKey="fileRecycleBin.deletedDate" params="${params }"/>
						</tr>
					</thead>
					<tbody class="ui-widget-content">
					<g:each in="${instanceList}" status="i" var="instance">
						<tr>
							<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
							<td class="action">
							<gs:ifPopupPage>
								<gs:chooseLink refValue="${instance.id}" refLabel="${instance}"/>
							</gs:ifPopupPage>
							<gs:ifNotPopupPage>
								<gs:linkButton class="showLink" action="show" id="${instance.id}" icon="eye" title="${message(code:'crud.list.show',default:'show')}"/>
								&nbsp;&nbsp;
								<gs:linkButton class="restoreLink" action="restoreFile" id="${instance.id}" icon="arrow_rotate_clockwise"
									title="${message(code:'crud.list.restore',default:'restore')}"/>
							</gs:ifNotPopupPage>
							</td>
							<td><g:fieldValue bean="${instance}" field="directoryNode"/></td>
							<td><g:fieldValue bean="${instance}" field="originalPath"/></td>
							<td>
								<g:if test="${instance.fileType=='D'}">
									<gs:message code="fileRecycleBin.fileType.directory" default="Directory" />
								</g:if>
								<g:else>
									<gs:message code="fileRecycleBin.fileType.file" default="File" />
								</g:else>
							</td>
							<td><g:fieldValue bean="${instance}" field="checksum"/></td>
							<td><gs:formatDatetime date="${instance.deletedDate}" /></td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			</g:form>
			<div class="paginateButtons">
				<g:paginate total="${instanceTotal}" params="${params }"/>
				(<span id='resultTotals'>${session['fileRecycleBin.count']}</span>)
			</div>
		</div>
	</body>
</html>
