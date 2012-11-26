<script type="text/javascript">
	function hideUnrelatedTrigger(tt){
		if(tt=='cron'){
			$('.repeatField').hide();
			$('.specificField').hide();
			$('.cronField').fadeIn();
		}else if(tt=='repeat'){
			$('.cronField').hide();
			$('.specificField').hide();
			$('.repeatField').fadeIn();
		}else if(tt=='specific'){
			$('.cronField').hide();
			$('.repeatField').hide();
			$('.specificField').fadeIn();
		}else{
			$('.cronField').hide();
			$('.repeatField').hide();
			$('.specificField').hide();
		}
	}
	$(document).ready(function(){
		$('#triggerType').change(function(){
			hideUnrelatedTrigger($(this).val());
		});
		hideUnrelatedTrigger($('#triggerType').val());
		var cronBuilderBtns = {}
		cronBuilderBtns[I18N.lang('btn.close')] = function(){ $(this).dialog('close');};
		cronBuilderBtns[I18N.lang('btn.accept')] = function(){
			if($('#cronResult').val()=='true'){
				$('#cronExp').val($('#cronExpPreview').val());
				$(this).dialog('close');
			}else{
				alert(I18N.lang('cron.invalidCronExp'));
			}
		};
		$('#cronBuilder').dialog({
			modal: true,bgiframe: true,autoOpen: false,
			width: 490,height: 400,
			buttons: cronBuilderBtns
		});
		$('#cronButton').click(function(){
			$('#cronBuilder').dialog('open');
		});
	});
</script>