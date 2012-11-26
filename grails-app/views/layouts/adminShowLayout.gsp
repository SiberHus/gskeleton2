
<g:applyLayout name="adminLayout">
<html>
	<head>
		<title><g:meta name="app.name"/> - ${controllerName }</title>
		<wp:script name="jquery.editinplace"/>
		<script type="text/javascript">
			$(function(){
				$(".editableText").editInPlace({
					preinit: function(settings){
						settings['update_value'] = $(this).attr('id');
						settings['params'] = 'fieldName='+$(this).attr('id');
						return true;
					},
					//callback: function(unused, enteredText) {	
						//return enteredText;
					//},
					url: "${createLink(controller:'test',action:'echo')}",
					bg_over: "#cff",
					field_type: 'text',
					saving_image: "${resource(dir:'images',file:'spinner.gif')}",
					show_buttons: true,
					save_button: "<br/><input type='button' class='inplace_save crmbutton small edit' value='save'/>",
					cancel_button: "<input type='button' class='inplace_save crmbutton small delete' value='cancel'/>",
				});
				$(".editableSelect").editInPlace({
					preinit: function(settings){
						settings['select_options'] = $(this).attr('from');
						settings['update_value'] = $(this).attr('id');
						return true;
					},
					callback: function(unused, enteredText) {
						return enteredText;
					},
					// url: "./server.php",
					bg_over: "#cff",
					field_type: 'select',
					select_text: 'Choose new value',
					saving_image: "${resource(dir:'images',file:'spinner.gif')}",
					show_buttons: true,
					save_button: "<br/><input type='button' class='inplace_save crmbutton small edit' value='save'/>",
					cancel_button: "<input type='button' class='inplace_save crmbutton small delete' value='cancel'/>",
				});
			});
		</script>
		<g:layoutHead />
	</head>
	<body>
		<br/>
		<g:layoutBody />
	</body>
</html>
</g:applyLayout>