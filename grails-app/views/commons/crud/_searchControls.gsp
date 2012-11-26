<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>

<gs:buttonBar>
	<gs:linkSubmitButton action="search" icon="page_find" valueKey="btn.search" value=" Search"/>
	&nbsp;
	<gs:message code="crud.display" default="Display "/>
	<g:select name="max" from="${SysConfig.get('crud.list.sizeValues')}"
		value="${params.max?:SysConfig.get('crud.list.defaultSize') }" style="width:50px;" />
	<gs:message code="crud.itemsPerPage" default=" Items per page"/>
<gs:ifNotPopupPage>
	<%
		Class realClass = instance?.class
	%>
	<g:if test="${realClass?.metaClass.hasProperty(realClass,'exportFields') && session[controllerName+'.queryString']}">
		<gs:linkButton class="export" icon="page_excel">
			<gs:message code="btn.export" default="Export" />
		</gs:linkButton>
	</g:if>
</gs:ifNotPopupPage>
</gs:buttonBar>