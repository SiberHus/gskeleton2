<%@ page import="com.siberhus.gskeleton.config.SysConfig" %>
<wp:scriptBundle name="baseScripts" merge="true"/>
<wp:script name="lang-en"/>
<wp:style name="jquery-ui-${SysConfig.get('webUi.theme')}"/>
<wp:script name="jquery-ui"/>
<script type="text/javascript" src="${gs.resource(dir:'ui/jquery-ui/i18n',file:'jquery.ui.datepicker-'+response.locale.language+'.js')}"></script>
<!--[if IE]>
<style type="text/css">
#content {
	position: relative;
	padding: 0em 1em 3em 18em;
	border-left: 1px #CCC solid;
	z-index: 1;
}
</style>
<![EndIf]-->

<script type="text/javascript">
	$(document).ready(function(){
		$("button, input:submit, a", ".buttons").button();
		$("tbody.ui-widget-content tr").hover(
			function () {$(this).addClass('ui-state-hover');},
			function () { $(this).removeClass('ui-state-hover');}
		);
		$('div.paginateButtons').addClass('ui-widget-content ui-corner-all');
		<%--
			$("input.date").AnyTime_picker(
				{ format: "%d/%m/%Z ", labelTitle: "Date"} );
			$("input.datetime").AnyTime_picker(
				{ format: "%d/%m/%Z %T", labelTitle: "DateTime"} );
			$("input.time").AnyTime_picker(
				{ format: "%T", labelTitle: "Time"} );
		--%>
		$.datepicker.setDefaults($.extend({
			dateFormat: 'dd/mm/yy',
			showMonthAfterYear: false,showOn: "button", //button|both
			duration: 'fast',
			buttonImage: "${gs.resource(dir:'images/icons',file:'date.png')}",
			buttonImageOnly: true,
			changeMonth: true,changeYear: true,
			gotoCurrent: true
		}, $.datepicker.regional['${response.locale.language}']));
		$('input.date').datepicker({dateFormat: '${SysConfig.get('converter.jsDatePattern')}'}, $.datepicker.regional['${response.locale.language}']);
		$('input.time24').inputTime24();
		$('input.numeral').inputNumeral();
		$('input.integer').inputInteger();
		$('input.decimal').inputFloat();
		$('input.email').inputEmail();
		$('input.letter').inputLetter();
	});
</script>