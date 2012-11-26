<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminFormLayout" />
		<script type="text/javascript">
			$(function(){
				$('#accordion').accordion();
			});
		</script>
	</head>
	<body>
		<div class="body">
			<h2><gs:message code="customConfig.security" default="Security Configurations" /></h2>
			<g:form method="post" >
				<div id="accordion" class="dialog">

					<h3><a href="#"><gs:message code="security.ipv4Filter" default="IPv4 Filter"/></a></h3>
					<div>
						<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="ipv4Filter">
										<gs:message code="security.ipv4Filter.enabled" default="IPv4 Filter Enabled" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="ipv4Filter" value="true" checked="${SysConfig.get('security.ipv4Filter')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="ipv4Filter.localhost">
										<gs:message code="security.ipv4Filter.localhost" default="Allow Localhost Access" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="ipv4Filter.localhost" value="true" checked="${SysConfig.get('security.ipv4Filter.localhost')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="ipv4Filter.definedOnly">
										<gs:message code="security.ipv4Filter.definedOnly" default="Filter Defined List Only" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="ipv4Filter.definedOnly" value="true" checked="${SysConfig.get('security.ipv4Filter.localhost')}"/>
								</td>
							</tr>
						</tbody>
						</table>
					</div>

					<h3><a href="#"><gs:message code="security.authc" default="Authentication"/></a></h3>
					<div>
						<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.rememberMe">
										<gs:message code="security.authc.rememberMe" default="Remember Me" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="authc.rememberMe" value="true" checked="${SysConfig.get('security.authc.rememberMe')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.defaultSuccessView">
										<gs:message code="security.authc.defaultSuccessView" default="Default Success View" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="authc.defaultSuccessView" value="${SysConfig.get('security.authc.defaultSuccessView')}"/> 
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.multiSessionLogin">
										<gs:message code="security.authc.multiSessionLogin" default="Multi Session Login" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="authc.multiSessionLogin" value="true" checked="${SysConfig.get('security.authc.multiSessionLogin')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.multiAddressLogin">
										<gs:message code="security.authc.multiAddressLogin" default="Multi Address Login" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="authc.multiAddressLogin" value="true" checked="${SysConfig.get('security.authc.multiAddressLogin')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.maxLoginFailures">
										<gs:message code="security.authc.maxLoginFailures" default="Maximum Login Failures" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="authc.maxLoginFailures"
										value="${SysConfig.get('security.authc.maxLoginFailures')}" class="integer"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="authc.disableTimeInterval">
										<gs:message code="security.authc.disableTimeInterval" default="Disabled Time Interval" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="authc.disableTimeInterval"
										value="${SysConfig.get('security.authc.disableTimeInterval')}" class="integer"/>
								</td>
							</tr>
						</tbody>
						</table>
					</div>

					<h3><a href="#"><gs:message code="security.password" default="Password Policy"/></a></h3>
					<div>
						<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="password.minLength">
										<gs:message code="security.password.minLength" default="Minimum Length" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="password.minLength" value="${SysConfig.get('security.password.minLength')}" class="integer"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="password.minLength">
										<gs:message code="security.password.maxLength" default="Maximum Length" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="password.maxLength" value="${SysConfig.get('security.password.maxLength')}" class="integer"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label>
										<gs:message code="security.password.rule" default="Password Rule" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<% def rule = SysConfig.get('security.password.rule') %>
									<g:radio id="rule.0" name="password.rule" value="0" checked="${rule==0}"/>
									<label for="rule.0"><gs:message code="password.rule.0" default="Custom Regular Expression"/></label><br/>
									<g:radio id="rule.1" name="password.rule" value="1" checked="${rule==1}"/>
									<label for="rule.1"><gs:message code="password.rule.1" default="Characters Only"/></label><br/>
									<g:radio id="rule.2" name="password.rule" value="2" checked="${rule==2}"/>
									<label for="rule.2"><gs:message code="password.rule.2" default="Numbers Only"/></label><br/>
									<g:radio id="rule.3" name="password.rule" value="3" checked="${rule==3}"/>
									<label for="rule.3"><gs:message code="password.rule.3" default="Alphanumeric Including _(underscore)"/></label><br/>
									<g:radio id="rule.4" name="password.rule" value="4" checked="${rule==4}"/>
									<label for="rule.4"><gs:message code="password.rule.4" default="Any"/></label><br/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="password.ruleRegex">
										<gs:message code="security.password.ruleRegex" default="Regular Expression" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:textField name="password.ruleRegex" value="${SysConfig.get('security.password.ruleRegex')}"/>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					
					<h3><a href="#"><gs:message code="security.log" default="Security Logs"/></a></h3>
					<div>
						<table>
						<tbody>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="log.login">
										<gs:message code="security.log.login" default="Login Log Enabled" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="log.login" value="true" checked="${SysConfig.get('security.log.login')}"/>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name">
									<label for="log.loginFailure">
										<gs:message code="security.log.loginFailure" default="Login Failure Log Enabled" />
									</label>
								</td>
								<td colspan="3" valign="top" class="value">
									<g:checkBox name="log.loginFailure" value="true" checked="${SysConfig.get('security.log.loginFailure')}"/>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
				</div>
				<br/>
				<gs:buttonBar>
					<gs:linkSubmitButton action="updateSecurity" valueKey="btn.update" value="Update" icon="database_save"/>
				</gs:buttonBar>
			</g:form>
		</div>
	</body>
</html>
