
<%@ page import="com.siberhus.gskeleton.doc.FaqCategory; com.siberhus.gskeleton.doc.Faq" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="adminShowLayout" />
		<g:set var="entityName" value="${message(code: 'faq', default: 'FAQ')}" />
		<style type="text/css">
			#question{
				margin: 10 10 2 10;
				padding: 5;
			}
			#answer{
				margin: 0 10 5 10;
				padding: 5;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				var faqButtons = {}
				faqButtons[I18N.lang('btn.close')] = function(){ $(this).dialog('close');}
				$('#faq').dialog({
					bgiframe: true,autoOpen: false,
					width: 400,height: 300,
					buttons: faqButtons
				});
				$('.faqLink').click(function(){
					$.getJSON('${gs.createLink(controller:'faq',action:'jsonGetFaq')}',{
							id:$(this).attr('name').substring(3)},
						function(data){
							$('#answer').html(data.answer);
							$('#question').html(data.question);
							$('#faq').dialog('open');
						}
					);
				});
			});
		</script>
	</head>
	<body>
		<div id="faq" title="${message(code:'faq',default:'FAQ')}" class="hidden">
			<h3 id="question"></h3>
			<div id="answer"></div>
		</div>
		<div class="body">
			<h2><gs:message code="default.list.label" args="[entityName]" /></h2>
			<br/>
			<g:each var="category" in="${FaqCategory.list()}">
				<span style="margin: 10px;font-size:1.5em;" title="${category.description}">
					<g:if test="${category.id.toString()==params['category.id']}">
						${category.name}
					</g:if>
					<g:else>
						<g:link controller="faq" action="display" params="['category.id':category.id]">
							${category.name}
						</g:link>
					</g:else>
				</span>
			</g:each>
			<ul>
			<g:each var="faq" in="${pinnedFaq}">
				<li>
					<a class="faqLink" name="faq${faq.id}" href="#faq${faq.id}">${faq.question }</a> 
					&nbsp;&nbsp; ( ${message(code:'faq.readCount',default:'read: ')} ${faq.readCount } )
				</li>
			</g:each>
			</ul>
			<br/><hr width="400px" /><br/>
			<ul>
			<g:each var="faq" in="${notPinnedFaq}">
				<li>
					<a class="faqLink" name="faq${faq.id}" href="#faq${faq.id}">${faq.question }</a> 
					&nbsp;&nbsp; ( ${message(code:'faq.readCount',default:'read: ')} ${faq.readCount } )
				</li>
			</g:each>
			</ul>
		</div>
	</body>
</html>
