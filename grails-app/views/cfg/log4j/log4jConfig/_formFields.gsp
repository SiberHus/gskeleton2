
<script type="text/javascript">
	$(function(){
		<g:if test="${actionName=='edit'}">
			$('#name').attr('readonly','readonly');
		</g:if>
	});
</script>
<%@ page import="com.siberhus.gskeleton.cfg.log4j.Log4jConfig" %>
<div class="dialog">
	<table style="width:80%">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="log4jConfig.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<input id="name" type="text" name="name" value="${instance?.name}" style="width:450px;"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="log4jConfig.level" default="Level" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'level', 'errors')}">
					<input type="radio" id="levelAll" value="ALL" name="level" ${instance?.level=='ALL'?'checked="checked"':''}>
					<label for="levelAll" style="color:black;font-weight:bold;">
						<gs:message code="log4j.level.all" default="ALL"/>
					</label>
					<br/>
					<input type="radio" id="levelTrace" value="TRACE" name="level" ${instance?.level=='TRACE'?'checked="checked"':''}/>
					<label for="levelTrace" style="color:blue;font-weight:bold;">
						<gs:message code="log4j.level.trace" default="TRACE"/>
					</label>
					<br/>
					<input type="radio" id="levelDebug" value="DEBUG" name="level" ${instance?.level=='DEBUG'?'checked="checked"':''}/>
					<label for="levelDebug" style="color:#00008b;font-weight:bold;">
						<gs:message code="log4j.level.debug" default="DEBUG"/>
					</label>
					<br/>
					<input type="radio" id="levelInfo" value="INFO" name="level" ${instance?.level=='INFO'?'checked="checked"':''}/>
					<label for="levelInfo" style="color:#006400;font-weight:bold;">
						<gs:message code="log4j.level.info" default="INFO"/>
					</label>
					<br/>
					<input type="radio" id="levelWarn" value="WARN" name="level" ${instance?.level=='WARN'?'checked="checked"':''}/>
					<label for="levelWarn" style="color:purple;font-weight:bold;">
						<gs:message code="log4j.level.warn" default="WARN"/>
					</label>
					<br/>
					<input type="radio" id="levelError" value="ERROR" name="level" ${instance?.level=='ERROR'?'checked="checked"':''}/>
					<label for="levelError" style="color:#fe365e;font-weight:bold;">
						<gs:message code="log4j.level.error" default="ERROR"/>
					</label>
					<br/>
					<input type="radio" id="levelFatal" value="FATAL" name="level" ${instance?.level=='FATAL'?'checked="checked"':''}/>
					<label for="levelFatal" style="color:red;font-weight:bold;">
						<gs:message code="log4j.level.fatal" default="FATAL"/>
					</label>
					<br/>
					<input type="radio" id="levelOff" value="OFF" name="level" ${instance?.level=='OFF'?'checked="checked"':''}/>
					<label for="levelOff" style="color:teal;font-weight:bold;">
						<gs:message code="log4j.level.off" default="OFF"/>
					</label>
					<br/>
				</td>
			</tr>
		</tbody>
	</table>
</div>