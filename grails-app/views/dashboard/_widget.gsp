<div class="widget ui-widget ui-corner-all" id="widget_${widget.code}">
	<div class="action">
		<gs:image widgetControl="true" icon="tick" alt="Enable"/>
		<gs:image widgetControl="true" icon="cross" alt="Disable"/>
		<gs:image widgetControl="false" icon="arrow_refresh" alt="Refresh"
			style="cursor:pointer;" onclick="widget${widget.code}();"/>
		<%--
		<img widgetControl="true" src="${gs.resource(dir:'images/icons',file:'tick.png')}"  alt="tick" />
		<img widgetControl="true" src="${gs.resource(dir:'images/icons',file:'cross.png')}"  alt="cross" />
		<img widgetControl="false" src="${gs.resource(dir:'images/icons',file:'arrow_refresh.png')}"
			alt="refresh" style="cursor:pointer;" onclick="widget${widget.code}();"/>
		--%>
	</div>
	<div class="header ui-widget-header">
		<gs:message code="widget.${widget.id}" default="${widget.name}"/>
	</div>
	<div id="content_${widget.code}" class="body"></div>
	<div id="loading_${widget.code}" class="body hidden loading" style="text-align:center">
		<img src="${gs.resource(dir:'images',file:'widget_loading.gif')}" alt="Loading" width="100" height="100"/>
	</div>
</div>
