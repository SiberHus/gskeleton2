<%@ page import="com.siberhus.gskeleton.doc.FaqCategory" %>
<div class="dialog">
	<table style="width:100%">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name" style="width:15%">
					<label for="question">
						<gs:message code="faq.category" default="Category" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'category', 'errors')}">
					<g:select name="category.id" from="${FaqCategory.list()}"
						optionKey="id" optionValue="name" value="${instance?.category?.id}"
						noSelection="${session.noSelection}"/>
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name" style="width:15%">
					<label for="question">
						<gs:message code="faq.question" default="Question" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'question', 'errors')}">
					<g:textField name="question" value="${instance?.question}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="answer">
						<gs:message code="faq.answer" default="Answer" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'answer', 'errors')}">
					<%--
					<a href="${fckeditor.fileBrowserLink(type:'Image', browser:'extended', userSpace:'userone')}">Open file browser</a>
					--%>
					<fckeditor:editor
					    name="answer"
					    width="100%"
					    height="400"
					    toolbar="Default"
					    fileBrowser="default"
					    userSpace="userone"
					    >
					${instance?.answer}
					</fckeditor:editor>
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="pinned">
						<gs:message code="faq.pinned" default="Pinned" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'pinned', 'errors')}">
					<g:checkBox name="pinned" value="${instance?.pinned}" />
				</td>
			</tr>
			
			<tr id="displayOrderRow" class="prop">
				<td valign="top" class="name">
					<label for="displayOrder">
						<gs:message code="faq.displayOrder" default="Display Order" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'displayOrder', 'errors')}">
					<g:textField name="displayOrder" value="${instance?.displayOrder}" class="integer" />
				</td>
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="readCount">
						<gs:message code="faq.readCount" default="Read Count" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'readCount', 'errors')}">
					<g:textField name="readCount" value="${instance?.readCount}" class="integer" />	
				</td>
			</tr>
			
		</tbody>
	</table>
</div>