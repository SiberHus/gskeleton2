
<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder; com.siberhus.gskeleton.base.User" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminPopupLayout" />
		<style type="text/css">
			.checkList { border: 1px solid #ccc; }
			.checkList ul {
				list-style: none;
				margin: 0;
				padding:0;
			}
			.checkList, .checkList li { margin-left: 0; padding: 0; }
			.checkListLabel { display: block; padding-left: 25px; text-indent: -25px; }
			.checkListLabel:hover, .checkListLabel.hover { background: #777; color: #fff; }
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#controllerName').change(function(){
					$.getJSON('${gs.createLink(controller:"permission",action:"jsonFindAllActionsByController")}',
							{controllerName:$(this).val()} 
							,function(data){
								<%--
								SelectUI.clear('actionName');
								$.each(data, function(){
									SelectUI.addOption('actionName',this,this);
								});
								--%>
								var actionValues = '<ul id="form_checkList_ul">'; 
								$.each(data, function(){
									actionValues += '<li><label for="checkList_'+this+'" class="checkListLabel">';
									actionValues += '<input value="'+this+'" id="checkList_'+this+'" name="actionNames" type="checkbox">'+this;
									actionValues += '</label></li>';
								});
								$('#actionName').html(actionValues);
							}
					);
				});
				$('#acceptBtn').click(function(){
					var permText = $('#controllerName').val()+":";
					var parentValueElem = UI.getParentElementById($('#gs_parentValueId').val());
					var actionCount = 0;
					var totalActions = 0;
					$.each($('input[name=actionNames]'), function(){
						if($(this).attr('checked')){
							if($(this).val()=='*'){
								permText = $('#controllerName').val()+":*";
								actionCount = 1;
								return false;
							}else{
								if(actionCount==0)
									permText += $(this).val();
								else
									permText += ','+$(this).val();
								actionCount++;
							}
						}
						totalActions++;
					});
					if(actionCount+1 >= totalActions)
						permText = $('#controllerName').val()+":*";
					if(actionCount>0){
						parentValueElem.value = permText;
						window.close();
					}else{
						alert(I18N.lang('permission.actionIsRequired'));
					}
				});
			});
		</script>
	</head>
	<body>
		<div class="body">
			<h2><gs:message code="permission.compose" default="Compose Permission" /></h2>
			<form id="permForm">
			<g:hiddenField name="gs_parentValueId" value="${params.gs_parentValueId }" />
			<div class="dialog">
				<table style="width:100%">
					<thead>
						<tr>
							<th style="width:50%"><gs:message code="permission.controller" default="Controller" /></th>
							<th style="width:50%"><gs:message code="permission.action" default="Action" /></th>
						</tr>
					</thead>
					<tbody>
						<tr class="prop">
							<td valign="top">
								<%--
								<g:select id="controllerName" from="${grailsApplication.controllerClasses}" 
									optionKey="logicalPropertyName" optionValue="logicalPropertyName"
									noSelection="${['*':'*']}" style="width: 100%"/>
								--%>
								<select id="controllerName" style="width:100%">
								<option value="*">ALL</option>
								<%
									def permNames = ConfigurationHolder.config.gskeleton.permissions.controllerNames
									System.out.println(permNames)
								%>
								<g:each var="permGroup" in="${permNames.keySet()}">
									<optgroup label="${permGroup}">
										<g:each var="perm" in="${permNames[permGroup]}">
										<option value="${perm.key}">${perm.value}</option>
										</g:each>
									</optgroup>
								</g:each>
								</select>
							</td>
							<td valign="top">
								<%--
								<select id="actionName" style="width: 100%"><option value="*">*</option></select>
								--%>
								<div id="actionName" style="overflow:auto;height:15em;width:100%" class="checkList">
									<ul id="form_checkList_ul">
										<li>
											<label for="checkList_default" class="checkListLabel">
												<input value="*" id="checkList_default" name="actionNames" type="checkbox" />*
											</label>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="buttons">
				<gs:linkButton id="acceptBtn" url="#" valueKey="btn.accept" value="Accept" icon="accept" />
			</div>
			</form>
		</div>
	</body>
</html>
