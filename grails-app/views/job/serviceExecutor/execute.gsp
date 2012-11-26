<%@ page import="org.apache.commons.lang.exception.ExceptionUtils; com.siberhus.gskeleton.job.ServiceExecutionThread; com.siberhus.gskeleton.job.ServiceExecutor" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<g:set var="entityName" value="${message(code: 'serviceExecutor', default: 'Service Executor')}" />
		<script type="text/javascript">
			$(function(){
				var tabs = $('#tabs').tabs();
				tabs.tabs('select',${params.showerr?1:0});
			});
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
			<h2><gs:message code="serviceExecutor.execute" default="Execute Service" /></h2>
			<g:form method="post" >
				<g:hiddenField name="id" value="${instance?.id}" />
				<div id="tabs" class="dialog">
					<ul>
						<li><a href="#tabs-1"><gs:message code="serviceExecutor.detail" default="Service Executor Detail"/></a></li>
						<li><a href="#tabs-2"><gs:message code="serviceExecutor.lastError" default="Last Error Detail"/></a></li>
					</ul>
					<div id="tabs-1">
					<table style="width:100%">
						<tbody>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutor.name" default="Name" /></td>
								<td valign="top" class="value">${instance.name}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutor.serviceName" default="Service Name" /></td>
								<td valign="top" class="value">${instance.serviceName}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><gs:message code="serviceExecutor.methodName" default="Method Name" /></td>
								<td valign="top" class="value">${instance.methodName}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="serviceExecutor.serviceParameters" default="Service Parameters" />
									</label>
								</td>
								<td valign="top" class="value">
									<div>
										<table style="width:100%">
											<thead class="ui-widget-header">
												<tr>
													<th style="width:20%"><gs:message code="serviceParameter.name" default="Parameter Name"/></th>
													<th style="width:15%"><gs:message code="serviceParameter.type" default="Parameter Type"/></th>
													<th style="width:35%"><gs:message code="serviceParameter.value" default="Value"/></th>
													<th style="width:30%"><gs:message code="serviceParameter.desc" default="Description"/></th>
												</tr>
											</thead>
											<tbody class="ui-widget-content">
												<%-- Collections.sort(instance.serviceParameters) --%>
												<g:each in="${instance.serviceParameters}" var="serviceParameter">
												<tr>
													<td>
														<g:hiddenField name="paramName" value="${serviceParameter.name}"/>
														${serviceParameter.name}
													</td>
													<td>
														<g:hiddenField name="paramType" value="${serviceParameter.type}"/>
														${serviceParameter.type}
													</td>
													<td>
														<%
															def classType
															def paramType = serviceParameter.type
															if(paramType=='int'||paramType=='long'){
																classType = 'integer'
															}else if(paramType=='float'||paramType=='double'){
																classType = 'decimal'
															}else{
																classType = paramType
															}
														%>
														<input type="text" id="paramValue_${serviceParameter.name}" name="paramValue" value="${serviceParameter.defaultValue}"
																class="${classType}" style="width:90%"/>
													</td>
													<td>
														${serviceParameter.description}
													</td>
												</tr>
												</g:each>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					</div>
					<div id="tabs-2">
						<% def exception = ServiceExecutionThread.ERROR_MESSAGES.get(instance?.name) %>
						<strong>${ExceptionUtils.getRootCauseMessage(exception)}</strong>
						<p>
							${ExceptionUtils.getFullStackTrace(exception)}
						</p>
					</div>
				</div>
				<gs:buttonBar>
					<g:if test="${ServiceExecutionThread.isServiceRunning(instance.name)}">
						<gs:linkButton action="terminate" id="${instance.id}" icon="cross"
							valueKey="command.terminate" value="Terminate"
							confirm="true" confirmMessage="${message(code:'serviceExecutor.confirmTerminate',default:'Are you sure to terminate this service?')}"/>
					</g:if>
					<g:else>
						<gs:linkSubmitButton action="execute" valueKey="command.execute" value="Execute" icon="cog"
							confirm="true" confirmMessage="${message(code:'serviceExecutor.confirmExecute',default:'Are you sure to execute this service?')}"/>
					</g:else>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
