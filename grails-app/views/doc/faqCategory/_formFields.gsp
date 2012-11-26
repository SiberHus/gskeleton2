
<%@ page import="com.siberhus.gskeleton.doc.FaqCategory" %>
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<gs:message code="faqCategory.name" default="Name" />
					</label>
					<span style="color:red;">*</span>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'name', 'errors')}">
					<g:textField name="name" value="${instance?.name}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label for="description">
						<gs:message code="faqCategory.description" default="Description" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'description', 'errors')}">
					<g:textArea name="description" rows="5" cols="40" value="${instance?.description}" />
				</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name">
					<label>
						<gs:message code="faqCategory.faqs" default="Faqs" />
					</label>
				</td>
				<td valign="top" class="value ${hasErrors(bean: instance, field: 'faqs', 'errors')}">
					<ul>
					<g:each in="${instance?.faqs}" var="faqInstance">
						<li>
							<g:link controller="faq" action="show" id="${faqInstance?.id}">
								${faqInstance?.encodeAsHTML()}
							</g:link>
						</li>
					</g:each>
					</ul>
					<g:link controller="faq" params="['faqCategory?.id': instance?.id]" action="create">
						<g:message code="faq.new" default="New Faq" />
					</g:link>
				</td>
			</tr>
		</tbody>
	</table>
</div>