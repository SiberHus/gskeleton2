<%--
  Created by IntelliJ IDEA.
  User: hussachai
  Date: Jul 21, 2010
  Time: 9:05:43 AM
  To change this template use File | Settings | File Templates.
--%>

<td class="idcheck"><g:checkBox name="ids" value="${instance.id}" checked="false"/></td>
<td class="action">
<gs:ifPopupPage>
	<gs:chooseLink refValue="${instance.id}" refLabel="${instance}"/>
</gs:ifPopupPage>
<gs:ifNotPopupPage>
	<gs:linkButton action="show" id="${instance.id}" icon="eye" params="${[offset:params.offset,max:params.max]}"
			title="${message(code:'crud.list.show',default:'show')}"/>&nbsp;&nbsp;
	<gs:linkButton action="edit" id="${instance.id}" icon="database_edit" params="${[offset:params.offset,max:params.max]}" 
			title="${message(code:'crud.list.edit',default:'edit')}"/>
</gs:ifNotPopupPage>
</td>
