<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutor', default: 'Service Executor')}" />
		<noscript>
			<meta http-equiv="refresh" content="${pollingTime}; url=${createLink(controller:'serviceExecutor',action:'wait',params:[id:id,pollingTime:pollingTime])}">
		</noscript>

		<script type="text/javascript">
			setTimeout("window.location.replace('${createLink(controller:'serviceExecutor',action:'wait',params:[id:id,pollingTime:pollingTime])}')",${pollingTime*1000});
		</script>
	</head>
	<body>
		<gs:buttonBar>
			<gs:linkButton action="list" icon="database_table">
				<gs:message code="default.list.label" args="[entityName]" />
			</gs:linkButton>
			<gs:linkButton action="create" class="create" icon="database_add">
				<gs:message code="default.new.label" args="[entityName]" />
			</gs:linkButton>
		</gs:buttonBar>
		<div class="body">
			<h2><gs:message code="serviceExecutor.processing" default="Operation is in progress..." /></h2>
			<br/><br/>
			<div style="margin: 0 auto;width: 50%;text-align:center">
				<gs:image dir="/images" file="waiting.gif"/>
				<br/>
				<gs:message code="serviceExecutor.waitingMsg" default="Please wait... while the service is running"/>
				<br/><br/>
				<hr/>
				<gs:message code="serviceExecutor.changePollingInterval" default="Change polling interval (seconds)"/> 
				<g:form action="wait">
					<g:hiddenField name="id" value="${id}"/>
					<g:textField name="pollingTime" value="${pollingTime}" class="numeral" style="width:50px"/>
					<gs:linkSubmitButton value="Change" valueKey="submit.change"/> 
				</g:form>
			</div>
		</div>
	</body>
</html>