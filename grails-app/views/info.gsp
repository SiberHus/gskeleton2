<html>
    <head>
        <title>Welcome to GSkeleton</title>
		<meta name="layout" content="adminLayout" />
		<style type="text/css" media="screen">
			h1 {
				font-size:2.0em;
			}
			h2 {
				margin-top:15px;
				margin-bottom:15px;
				font-size:1.2em;
			}
			#pageBody {
				margin-left: 15px;
			}
		</style>
		<script type="text/javascript">
			$(function(){
				$("#tabs").tabs();
			});
		</script>
    </head>
    <body>
		<div id="pageBody">
			<br/>
			<h1>GSkeleton Info</h1>
			<span style="margin-left:5px">Locale: ${Locale.default}</span>
			<div id="tabs">
				<ul>
					<li><a href="#tabsControllers">Available Controllers</a></li>
					<li><a href="#tabsInfo">Application Info</a></li>
					<li><a href="#tabsSysEnv">System Environment</a></li>
					<li><a href="#tabsSysProps">System Properties</a></li>
					<li><a href="#tabsAbout">About</a></li>
				</ul>
				<div id="tabsControllers">
					<h2>Available Controllers (Grouped &amp; Sorted)</h2>
					<%
						def groupMap = new TreeMap()
						for(def cc in grailsApplication.controllerClasses){
							def group = 'default'
							if(cc.fullName.contains('.')){
			        			group = cc.fullName.substring(0,cc.fullName.lastIndexOf('.'))
							}
							def controllerMap = groupMap.get(group)
							if(controllerMap==null){
								controllerMap = new TreeMap()
								groupMap.put(group, controllerMap)
							}
							controllerMap.put(cc.fullName, cc.logicalPropertyName)
						}
					%>
					<div id="controllerList" class="dialog">
						<g:each var="g" in="${groupMap}">
							<strong>${g.key }</strong>
							<ul>
								<g:each var="c" in="${g.value}">
									<li class="controller"><g:link controller="${c.value}">${c.key}</g:link></li>
								</g:each>
							</ul>
						</g:each>
					</div>
				</div>
				<div id="tabsInfo">
					<h2>Application Status</h2>
					<div class="list">
						<table style="width:450px">
							<thead class="ui-widget-header">
								<tr>
									<th style="width:300px">Property</th>
									<th style="width:150px">Value</th>
								</tr>
							</thead>
							<tbody class="ui-widget-content">
								<tr>
									<td>App version: </td>
									<td><g:meta name="app.version" /></td>
								</tr>
								<tr>
									<td>Grails version: </td>
									<td><g:meta name="app.grails.version" /></td>
								</tr>
								<tr>
									<td>JVM version: </td>
									<td>${System.getProperty('java.version')}</td>
								</tr>
								<tr>
									<td>Number of Controllers: </td>
									<td>${grailsApplication.controllerClasses.size()}</td>
								</tr>
								<tr>
									<td>Number of Domains: </td>
									<td>${grailsApplication.domainClasses.size()}</td>
								</tr>
								<tr>
									<td>Number of Services: </td>
									<td> ${grailsApplication.serviceClasses.size()}</td>
								</tr>
								<tr>
									<td>Number of Tag Libraries: </td>
									<td>${grailsApplication.tagLibClasses.size()}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<h2>Installed Plugins</h2>
					<div class="list">
						<table style="width:450px">
							<thead class="ui-widget-header">
								<tr>
									<th style="width:300px">Plugin</th>
									<th style="width:150px">Version</th>
								</tr>
							</thead>
							<tbody class="ui-widget-content">
								<g:set var="pluginManager"
									value="${applicationContext.getBean('pluginManager')}"></g:set>
								<g:each var="plugin" in="${pluginManager.allPlugins}">
								<tr>
									<td>${plugin.name}</td>
									<td>${plugin.version}</td>
								</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tabsSysEnv">
					<h2>System Environment</h2>
					<div class="list">
						<table>
							<thead class="ui-widget-header">
								<tr>
									<th style="width:300px">Property</th>
									<th>Value</th>
								</tr>
							</thead>
							<tbody class="ui-widget-content">
								<g:each var="env" in="${new TreeMap(System.getenv())}">
								<tr>
									<td>${env.key}</td>
									<td>${env.value}</td>
								</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tabsSysProps">
					<h2>System Properties</h2>
					<div class="list">
						<table>
							<thead class="ui-widget-header">
								<tr>
									<th style="width:300px">Property</th>
									<th>Value</th>
								</tr>
							</thead>
							<tbody class="ui-widget-content">
								<g:each var="prop" in="${new TreeMap(System.properties)}">
								<tr>
									<td>${prop.key}</td>
									<td>${prop.value}</td>
								</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tabsAbout">
					<img src="${resource(dir:'images',file:'logo.jpg')}" />
					<p>
					</p>
		</div>
			</div>
		</div>
    </body>
</html>