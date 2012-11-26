<tr class="prop">
	<td valign="top" class="name"><gs:message code="btn.createdDate" default="Date Created" />:</td>
	<td valign="top" class="value"><gs:formatDatetime date="${instance?.createdDate}"/></td>
	<td valign="top" class="name"><gs:message code="btn.createdBy" default="Created By" />:</td>
	<td valign="top" class="value">${instance?.createdBy}</td>
</tr>

<tr class="prop">
	<td valign="top" class="name"><gs:message code="crud.modifiedDate" default="Date Modified" />:</td>
	<td valign="top" class="value"><gs:formatDatetime date="${instance?.modifiedDate}"/></td>
	<td valign="top" class="name"><gs:message code="crud.modifiedBy" default="Modified By" />:</td>
	<td valign="top" class="value">${instance?.modifiedBy}</td>
</tr>