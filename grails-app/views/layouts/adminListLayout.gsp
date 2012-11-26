<%@page import="com.siberhus.gskeleton.config.SysConfig; org.codehaus.groovy.grails.web.context.ServletContextHolder as SCH" %>
<g:applyLayout name="adminLayout">
<html>
	<head>
		<title><g:meta name="app.name"/> - ${controllerName }</title>
		<style type="text/css">
			.searchbox { margin: 0 1em 1em 0; }
			.searchbox-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
			.searchbox-header .ui-icon { float: right; cursor: pointer;}
			.searchbox-content { padding: 0.4em; }
			#allIdsChk { width:15px; }
			th.action { width: 90px; }
		</style>
		<script type="text/javascript">
			$(function(){
				$('a.delete').click(function(){
					if(confirm(I18N.lang('crud.bulkDelete.confirm'))){
						$('form[name=bulkDeleteForm]').submit();
					}
				});
				$('#allIdsChk').click(function(){
					ChkBoxUI.toggleCheckedItems($('input[name=ids]'),this);
				});
				$('a.export').click(function(){
					$('#exportDialog').dialog('open');
					return false;
				});
				var exportButtons = {};
				exportButtons[I18N.lang('btn.close')] = function() { $(this).dialog('close'); };
				exportButtons[I18N.lang('btn.export')] = function() {
					var itemCount = $('#resultTotals').html();
					var maxItems =  ${SCH.servletContext.config.get('crud.export.maxItems')}
					if(itemCount > maxItems ){
						alert(I18N.lang('crud.export.maxExceed')+" ("
							+itemCount+">"+maxItems+")");
					}else{
						$('#exportForm').submit();
					}
					$(this).dialog('close');
				};
				$('#exportDialog').dialog( {
					bgiframe : true,autoOpen : false,modal : true,
					width: 450, height : 300,
					buttons : exportButtons
				});
				
			});
			function setSearchBoxVisible(hidden){
				var sbhIco = $('.searchbox-header .ui-icon');
				if(hidden){
					sbhIco.addClass('ui-icon-minusthick');
					$('.searchbox-header').parents(".searchbox:first").find('.searchbox-content').hide();
				}else{
					sbhIco.removeClass('ui-icon-minusthick');
					$('.searchbox-header').parents(".searchbox:first").find('.searchbox-content').fadeIn();
				}
			}
			$(function(){
				$('.searchbox').addClass('ui-widget ui-helper-clearfix ui-corner-all')
					.find('.searchbox-header')
					.addClass('ui-widget-header ui-corner-all')
					.prepend('<span class="ui-icon ui-icon-plusthick"></span>')
					.end()
					.find('.searchbox-content');

				var hidden = $.cookie('${controllerName}.searchBox')=='H'?true:false;
				setSearchBoxVisible(hidden);
				$('.searchbox-header .ui-icon').click(function() {
					if($('.searchbox-header .ui-icon').hasClass('ui-icon-minusthick')){
						$.cookie('${controllerName}.searchBox', null, { expires: 7, path: '/'});
						setSearchBoxVisible(false);
					}else{
						$.cookie('${controllerName}.searchBox', 'H', { expires: 7, path: '/'});
						setSearchBoxVisible(true);
					}
				});
			});
		</script>
		<g:layoutHead />
	</head>
	<body>
		<br/>
		<g:layoutBody />
		<div id="exportDialog" class="dialog hidden" title="${message(code:'crud.export.options',default:'Export Options') }">
			<g:form name="exportForm" method="post" action="export">
				<table class="ui-widget-content">
					<tbody>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fileName"><gs:message code="crud.export.fileName" default="File Name: " /></label>
							</td>
							<td valign="top" class="value">
								<input type="text" id="fileName" name="fileName" value="untitled.csv" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="escapeCsv"><gs:message code="crud.export.escapeCsv" default="Escape CSV: " /></label>
							</td>
							<td valign="top" class="value">
								<input type="checkbox" id="escapeCsv" name="escapeCsv" value="true" checked="checked"/>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="columnSeparator"><gs:message code="crud.export.columnSeparator" default="Column Separator: " /></label>
							</td>
							<td valign="top" class="value">
								<input type="text" id="columnSeparator" name="columnSeparator" value="," />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fileFormat"><gs:message code="crud.export.fileFormat" default="File Format: " /></label>
							</td>
							<td valign="top" class="value">
								<select id="fileFormat" name="fileFormat">
									<option value="WIN" selected="selected">WINDOWS</option>
									<option value="UNIX">UNIX</option>
									<option value="MAC">MAC</option>
								</select>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fileEncoding"><gs:message code="crud.export.fileEncoding" default="File Encoding: " /></label>
							</td>
							<td valign="top" class="value">
								<g:select name="fileEncoding" from="${SysConfig.get('crud.export.fileEncodingValues')}"
									value="${SysConfig.get('crud.export.defaultFileEncoding')}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</g:form>
		</div>
	</body>
</html>
</g:applyLayout>