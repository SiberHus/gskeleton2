
<script type="text/javascript">
	function changeType(type){
		$('#fileTbl').addClass('hidden');
		$('#smtpTbl').addClass('hidden');
		if(type=='CONSOLE'){
			alert('${message(code:"_warn.log4jAppender.consoleIsPreserved",default:"You cannot set type to CONSOLE manually")}');
			$(this).val('');
		}else if(type=='FILE'){
			$('#fileTbl').removeClass('hidden');
			$('tr[name=rollingFile]').addClass('hidden');
			$('tr[name=dailyRollingFile]').addClass('hidden');
		}else if(type=='ROLLING_FILE'){
			$('#fileTbl').removeClass('hidden');
			$('tr[name=rollingFile]').removeClass('hidden');
			$('tr[name=dailyRollingFile]').addClass('hidden');
		}else if(type=='DAILY_ROLLING_FILE'){
			$('#fileTbl').removeClass('hidden');
			$('tr[name=rollingFile]').addClass('hidden');
			$('tr[name=dailyRollingFile]').removeClass('hidden');
		}else if(type=='SMTP'){
			$('#smtpTbl').removeClass('hidden');
		}
	}
	$(function(){
		$('#type').change(function(){
			changeType($(this).val());
		});
		$('#presetDatePattern').click(function(){
			$('#file\\.periodicity').removeClass('hidden');
			$('#file\\.datePattern').addClass('hidden');
		});
		$('#customDatePattern').click(function(){
			$('#file\\.periodicity').addClass('hidden');
			$('#file\\.datePattern').removeClass('hidden');
		});
		<g:if test="${actionName=='edit'}">
			$('#name').attr('readonly','readonly');
		</g:if>
		<g:if test="${instance?.type=='CONSOLE'}">
			$('#name').attr('readonly','readonly');
			$('#type').attr('disabled','disabled');
		</g:if>
		<g:else>
			changeType('${instance?.type}');
		</g:else>
		<g:if test="${instance?.props['file.datePattern']}">
			$('#file\\.periodicity').addClass('hidden');
			$('#file\\.datePattern').removeClass('hidden');
		</g:if>
		<g:else>
			$('#file\\.periodicity').removeClass('hidden');
			$('#file\\.datePattern').addClass('hidden');
		</g:else>
	});
</script>
<%@ page import="com.siberhus.gskeleton.cfg.log4j.Log4jAppender" %>
<div class="dialog">
	<table style="width:80%">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="log4jAppender.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="log4jAppender.threshold" default="Threshold" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'threshold', 'errors')}">
					<input type="radio" id="thresholdAll" value="ALL" name="threshold" ${instance?.threshold=='ALL'?'checked="checked"':''}/>
					<label for="thresholdAll" style="color:black;font-weight:bold;">
						<gs:message code="log4j.level.all" default="ALL"/>
					</label>
					<br/>
					<input type="radio" id="thresholdTrace" value="TRACE" name="threshold" ${instance?.threshold=='TRACE'?'checked="checked"':''}/>
					<label for="thresholdTrace" style="color:blue;font-weight:bold;">
						<gs:message code="log4j.level.trace" default="TRACE"/>
					</label>
					<br/>
					<input type="radio" id="thresholdDebug" value="DEBUG" name="threshold" ${instance?.threshold=='DEBUG'?'checked="checked"':''}/>
					<label for="thresholdDebug" style="color:#00008b;font-weight:bold;">
						<gs:message code="log4j.level.debug" default="DEBUG"/>
					</label>
					<br/>
					<input type="radio" id="thresholdInfo" value="INFO" name="threshold" ${instance?.threshold=='INFO'?'checked="checked"':''}/>
					<label for="thresholdInfo" style="color:#006400;font-weight:bold;">
						<gs:message code="log4j.level.info" default="INFO"/>
					</label>
					<br/>
					<input type="radio" id="thresholdWarn" value="WARN" name="threshold" ${instance?.threshold=='WARN'?'checked="checked"':''}/>
					<label for="thresholdWarn" style="color:purple;font-weight:bold;">
						<gs:message code="log4j.level.warn" default="WARN"/>
					</label>
					<br/>
					<input type="radio" id="thresholdError" value="ERROR" name="threshold" ${instance?.threshold=='ERROR'?'checked="checked"':''}/>
					<label for="thresholdError" style="color:#fe365e;font-weight:bold;">
						<gs:message code="log4j.level.error" default="ERROR"/>
					</label>
					<br/>
					<input type="radio" id="thresholdFatal" value="FATAL" name="threshold" ${instance?.threshold=='FATAL'?'checked="checked"':''}/>
					<label for="thresholdFatal" style="color:red;font-weight:bold;">
						<gs:message code="log4j.level.fatal" default="FATAL"/>
					</label>
					<br/>
					<input type="radio" id="thresholdOff" value="OFF" name="threshold" ${instance?.threshold=='OFF'?'checked="checked"':''}/>
					<label for="thresholdOff" style="color:teal;font-weight:bold;">
						<gs:message code="log4j.level.off" default="OFF"/>
					</label>
					<br/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="conversionPattern">
						<gs:message code="log4jAppender.conversionPattern" default="Conversion Pattern" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'conversionPattern', 'errors')}">
					<g:textField name="conversionPattern" value="${instance?.conversionPattern}" style="width:450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="type">
						<gs:message code="log4jAppender.type" default="Type" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'type', 'errors')}">
					<g:select name="type" from="${Log4jAppender.constraints.type.inList}"
						value="${instance.type}" valueMessagePrefix="log4jAppender.type"
							noSelection="${session.noSelection}"/>
				</td>
			</tr>
		</tbody>
	</table>
	<table id="fileTbl" class="hidden" style="width: 80%">
		<caption><gs:message code="log4jAppender.file.props" default="File Properties"/></caption>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.file" default="File"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="file.file" value="${instance?.props['file']}" style="width: 450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.encoding" default="Encoding"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="file.encoding" value="${instance?.props['encoding']?:'UTF-8'}"/>
				</td>
			</tr>
			<tr class="prop" name="rollingFile">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.maxFileSize" default="Max File Size"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="file.maxFileSize" value="${instance?.props['maxFileSize']}"/>
				</td>
			</tr>
			<tr class="prop" name="rollingFile">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.maxBackupIndex" default="Max Backup Index"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="file.maxBackupIndex" value="${instance?.props['maxBackupIndex']}" class="integer"/>
				</td>
			</tr>
			<tr class="prop" name="dailyRollingFile">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.datePattern" default="Date Pattern"/>
				</td>
				<td valign="top" class="value">
					<input id="presetDatePattern" type="radio" name="datePatternRad"
						${instance?.props['datePattern']?'':'checked="checked"'}/>
					<label for="presetDatePattern"><gs:message code="log4jAppender.props.presetDatePattern" default="Preset"/></label>&nbsp;
					<input id="customDatePattern" type="radio" name="datePatternRad"/>
					<label for="customDatePattern"><gs:message code="log4jAppender.props.customDatePattern" default="Custom"/></label>&nbsp;
					<br/>
					<g:textField name="file.datePattern" value="${instance?.props['datePattern']}"/>
					<g:select name="file.periodicity" from="['minutely','hourly','half-daily','daily','weekly','monthly']"
							valueMessagePrefix="log4jAppender" value="${instance?.props['periodicity']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.append" default="Append"/>
				</td>
				<td valign="top" class="value">
					<g:checkBox name="file.append" value="${instance?.props['append']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.bufferedIO" default="Buffered IO"/>
				</td>
				<td valign="top" class="value">
					<g:checkBox name="file.bufferedIO" value="${instance?.props['bufferedIO']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.bufferSize" default="Buffer Size"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="file.bufferSize" value="${instance?.props['bufferSize']}" class="integer"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.immediateFlush" default="Immediate Flush"/>
				</td>
				<td valign="top" class="value">
					<g:checkBox name="file.immediateFlush" value="${instance?.props['immediateFlush']}"/>
				</td>
			</tr>
		</tbody>
	</table>

	<table id="smtpTbl" class="hidden" style="width: 80%">
		<caption><gs:message code="log4jAppender.smtp.props" default="SMTP Properties"/></caption>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.smtpHost" default="SMTP Host"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.smtpHost" value="${instance?.props['smtpHost']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.smtpUsername" default="SMTP Username"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.smtpUsername" value="${instance?.props['smtpUsername']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.smtpPassword" default="SMTP Password"/>
				</td>
				<td valign="top" class="value">
					<g:passwordField name="smtp.smtpPassword" value="${instance?.props['smtpPassword']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.bufferSize" default="Buffer Size"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.bufferSize" value="${instance?.props['bufferSize']}" class="integer"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.smtpDebug" default="SMTP Debug"/>
				</td>
				<td valign="top" class="value">
					<g:checkBox name="smtp.smtpDebug" value="${instance?.props['smtpDebug']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.locationInfo" default="Location Info"/>
				</td>
				<td valign="top" class="value">
					<g:checkBox name="smtp.locationInfo" value="${instance?.props['locationInfo']}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.from" default="From"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.from" value="${instance?.props['from']}" style="width: 450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.to" default="To"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.to" value="${instance?.props['to']}" class="email" style="width: 450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.cc" default="CC"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.cc" value="${instance?.props['cc']}" style="width: 450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.bcc" default="BCC"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.bcc" value="${instance?.props['bcc']}" style="width: 450px"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<gs:message code="log4jAppender.props.subject" default="Subject"/>
				</td>
				<td valign="top" class="value">
					<g:textField name="smtp.subject" value="${instance?.props['subject']}" style="width: 450px"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>