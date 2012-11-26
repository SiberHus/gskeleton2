<html>
    <head>
		<meta name="layout" content="adminLayout" />
		
		<wp:script name="dashboard"/>
		<script type="text/javascript">
			<g:each in="${userWidgets}" var="widget">
				function widget${widget.code}(){
					$('#content_${widget.code}').html('');
					$('#loading_${widget.code}').show();
					<%
						def contentPath
						if(widget.contentPath.startsWith('/')){
							contentPath = application.contextPath+widget.contentPath
						}else{
							contentPath = widget.contentPath
						}
					%>
					$.get('${contentPath}', function(data) {
						$('#loading_${widget.code}').hide();
						$('#content_${widget.code}').html(data);
					});
				}
				widget${widget.code}();
			</g:each>
		</script>
	</head>
	<body>
		<div id="dashboard">
			<div id="topsection" class="sortable">
				<g:each in="${userWidgets}" var="widget">
					<g:if test="${widget.defaultPosition=='CENTER'}">
						<g:render template="/dashboard/widget" model="${[widget:widget]}"/> 
					</g:if>
				</g:each>
			</div>
			<div id="leftsection" class="sortable">
				<g:each in="${userWidgets}" var="widget">
					<g:if test="${widget.defaultPosition=='LEFT'}">
						<g:render template="/dashboard/widget" model="${[widget:widget]}"/>
					</g:if>
				</g:each>
			</div>
			<div id="rightsection" class="sortable">
				<g:each in="${userWidgets}" var="widget">
					<g:if test="${widget.defaultPosition=='RIGHT'}">
						<g:render template="/dashboard/widget" model="${[widget:widget]}"/>
					</g:if>
				</g:each>
			</div>
		</div>
		<g:if test="${userWidgets}">
		<div class="buttons" style="clear: both;">
			<a href="javascript:void(0);" id="edit_dashboard">
				<gs:image icon="pencil"/><gs:message code="btn.edit" default="Edit"/>
			</a>
			<a href="javascript:void(0);" id="save_dashboard">
				<gs:image icon="disk"/><gs:message code="btn.save" default="Save"/>
			</a>
		</div>
		</g:if>
		<br style="clear: both" />
	</body>
</html>
	