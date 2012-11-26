<style type="text/css">
	table.cron {
		width: 450px;
		border: none;
	}
	table.cron .label{
		width: 100px;
	}
	input.timeunit{
		width: 30px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#weeklyTbl').hide();
		$('#monthlyTbl').hide();
		$('#oneTimeOnlyTbl').hide();
		$('#customTbl').hide();
		$('#category').change(function(){
			var cat = $(this).val();
			if(cat=='d'){
				$('#dailyTbl').show();
				$('#weeklyTbl').hide();
				$('#monthlyTbl').hide();
				$('#oneTimeOnlyTbl').hide();
				$('#customTbl').hide();
			}else if(cat=='w'){
				$('#dailyTbl').hide();
				$('#weeklyTbl').show();
				$('#monthlyTbl').hide();
				$('#oneTimeOnlyTbl').hide();
				$('#customTbl').hide();
			}else if(cat=='m'){
				$('#dailyTbl').hide();
				$('#weeklyTbl').hide();
				$('#monthlyTbl').show();
				$('#oneTimeOnlyTbl').hide();
				$('#customTbl').hide();
			}else if(cat=='o'){
				$('#dailyTbl').hide();
				$('#weeklyTbl').hide();
				$('#monthlyTbl').hide();
				$('#oneTimeOnlyTbl').show();
				$('#customTbl').hide();
			}else if(cat=='c'){
				$('#dailyTbl').hide();
				$('#weeklyTbl').hide();
				$('#monthlyTbl').hide();
				$('#oneTimeOnlyTbl').hide();
				$('#customTbl').show();
			}
			$('#cronExpPreview').val('');
		});
		$('#cron_noStartTime').click(function(){
			if($(this).attr('checked')) $('#cron_startTime').attr('disabled','disabled');
			else $('#cron_startTime').removeAttr('disabled');
		});
		$('#cron_m_dayValue').attr('disabled','disabled');
		$('#cron_m_day').click(function(){
			if($(this).attr('checked')) $('#cron_m_dayValue').removeAttr('disabled');
			else $('#cron_m_dayValue').attr('disabled','disabled');
		});
		$('#generateBtn').click(function(){
			var cat = $('#category').val();
			var cronExp = null;
			var noStartTime = $('#cron_noStartTime').attr('checked');
			var startHour = 0;
			var startMinute = 0;
			var cronError = false;
			if(!noStartTime){
				var startTime = $('#cron_startTime').val().split(':');
				if(startTime.length!=2){
					alert(I18N.lang('cron.invalidTime'));
					cronError = true;
					return;
				}
				startHour = parseInt(startTime[0]);
				if(!(startHour>=0 && startHour<=23)){
					alert(I18N.lang('cron.invalidHours'));
					cronError = true;
					return;
				}
				startMinute = parseInt(startTime[1]);
				if(!(startMinute>=0 && startMinute<=59)){
					alert(I18N.lang('cron.invalidMinutes'));
					cronError = true;
					return;
				}
			}
			if(cat=='d'){
				if($('#cron_d_everyday').attr('checked')){
					cronExp = '0 '+startMinute+' '+startHour+' * * ?';
				}else if($('#cron_d_weekday').attr('checked')){
					cronExp = '0 '+startMinute+' '+startHour+' ? * SAT,SUN';
				}else if($('#cron_d_everyndays').attr('checked')){
					var ndays = parseInt($('#cron_d_ndays').val());
					if(ndays>=1 && ndays <=31){
						cronExp = '0 '+startMinute+' '+startHour+' 1/'+ndays+' * ?';
					}else{
						alert(I18N.lang('cron.invalidDays'));
						cronError = true;
					}
				}else if($('#cron_d_everynhours').attr('checked')){
					var nhours = parseInt($('#cron_d_nhours').val());
					if(nhours>=0 && nhours <=23){
						cronExp = '0 0 0/'+nhours+' * * ?';
					}else{
						alert(I18N.lang('cron.invalidHours'));
						cronError = true;
					}
				}else if($('#cron_d_everynminutes').attr('checked')){
					var nminutes = parseInt($('#cron_d_nminutes').val());
					if(nminutes>=0 && nminutes<= 59){
						cronExp = '0 0/'+nminutes+' * * * ?';
					}else{
						alert(I18N.lang('cron.invalidMinutes'));
						cronError = true;
					}
				}else if($('#cron_d_everynseconds').attr('checked')){
					var nseconds = parseInt($('#cron_d_nseconds').val());
					if(nseconds>=0 && nseconds<= 59){
						cronExp = '0/'+nseconds+' * * * * ?';
					}else{
						alert(I18N.lang('cron.invalidSeconds'));
						cronError = true;
					}
				}else{
					alert(I18N.lang('cron.optionNotSelect'));
					cronError = true;
				}
			}else if(cat=='w'){
				var dayOfWeeks = '';
				var dayCount = 0;
				if($('#cron_w_mon').attr('checked')){
					dayOfWeeks = 'MON';
					dayCount++;
				}
				if($('#cron_w_tue').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'TUE';
					else dayOfWeeks = dayOfWeeks+',TUE';
					dayCount++;
				}
				if($('#cron_w_wed').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'WED';
					else dayOfWeeks = dayOfWeeks+',WED';
					dayCount++;
				}
				if($('#cron_w_thu').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'THU';
					else dayOfWeeks = dayOfWeeks+',THU';
					dayCount++;
				}
				if($('#cron_w_fri').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'FRI';
					else dayOfWeeks = dayOfWeeks+',FRI';
					dayCount++;
				}
				if($('#cron_w_sat').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'SAT';
					else dayOfWeeks = dayOfWeeks+',SAT';
					dayCount++;
				}
				if($('#cron_w_sun').attr('checked')){
					if(dayOfWeeks=='') dayOfWeeks = 'SUN';
					else dayOfWeeks = dayOfWeeks+',SUN';
					dayCount++;
				}
				if(dayCount==0) {
					alert(I18N.lang('cron.optionNotSelect'));
					cronError = true;
				}else{
					if(dayCount==7) dayOfWeeks = 'MON-SUN';
					cronExp = '0 '+startMinute+' '+startHour+' ? * '+dayOfWeeks;
				}
			}else if(cat=='m'){
				var month = '';
				var monthCount = 0;
				var dayOfMonth = '*';
				var months = ['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
				if($('#cron_m_day').attr('checked')){
					var day = parseInt($('#cron_m_dayValue').val());
					if(day>=1 && day <=31){
						dayOfMonth = day;
					}else{
						alert(I18N.lang('cron.invalidDays'));
						cronError = true;
					}
				}
				for(var i in months){
					if($('#cron_m_'+months[i]).attr('checked')){
						var m = parseInt(i)+1;
						if(month=='') month = m;
						else month = month+','+m;
						monthCount++;
					}
				}
				if(monthCount==0) {
					alert(I18N.lang('cron.optionNotSelect'));
					cronError = true;
				}else{
					if(monthCount==12) month = '1-12';
					cronExp = '0 '+startMinute+' '+startHour+' '+dayOfMonth+' '+month+' ?';
				}
			}else if(cat=='o'){
				var day = $('#cron_o_day').val();
				var month = $('#cron_o_month').val();
				var year = $('#cron_o_year').val();
				cronExp = '0 '+startMinute+' '+startHour+' '+day+' '+month+' ? '+year;
			}else if(cat=='c'){
				cronExp = $('#cron_c_value').val();
			}
			$('#cronExpPreview').val(cronExp);
			if(cronError != true){
				$.getJSON('${createLink(controller:"jobScheduler",action:"jsonParseCronExpression")}',
					{cronExp:cronExp},function(json){
					if(json.success){
						$('#nextFireTime').show();
						$('#errorMessage').hide();
						$('#cronResult').val('true');
						$('#cronMessage').css('color','green');
					}else{
						$('#nextFireTime').hide();
						$('#errorMessage').show();
						$('#cronResult').val('false');
						$('#cronMessage').css('color','red');
					}
					$('#cronMessage').html(json.message);
				});
			}else{
				$('#cronExpPreview').val('');
				$('#nextFireTime').hide();
				$('#errorMessage').hide();
				$('#cronMessage').html('');
			}
		});
	});
</script>