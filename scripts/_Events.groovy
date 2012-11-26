

eventConfigureTomcat = {tomcat ->
	def ctx=tomcat.host.findChild(serverContextPath)
	ctx.aliases += ',/resources=D:/java/app_servers'
}

