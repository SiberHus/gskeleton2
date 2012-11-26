<script type="text/javascript">
	$(document).ready(function(){
		<g:each in="${instance?.permissions}">
			addPermissionRow('${it.trim()}');
		</g:each>
		if($('#pwdNeverExpire').attr('checked')){
			$('#pwdAge').val('-1');
			$('#pwdAge').attr('disabled','disabled');
		}
		$('#pwdNeverExpire').click(function(){
			if($(this).attr('checked')){
				$('#pwdAge').val('-1');
				$('#pwdAge').attr('disabled','disabled');
			}else{
				$('#pwdAge').removeAttr('disabled');
			}
		});
	});
</script>