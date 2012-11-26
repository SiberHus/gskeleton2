<gs:ifNotPopupPage>
	<g:hiddenField name="offset" value="${params.offset}"/>
	<g:hiddenField name="max" value="${params.max}"/>
	<div class="buttons">
		<a style="cursor:pointer;" class="delete negative">
			<gs:image icon="database_delete"/>
			<gs:message code="btn.bulkDelete" default="Delete" />
		</a>
	</div>
	<br/>
</gs:ifNotPopupPage>
<gs:ifPopupPage><br/></gs:ifPopupPage>
