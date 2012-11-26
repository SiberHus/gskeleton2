		<script type="text/javascript">
			$(document).ready(function(){
				<g:each in="${instance?.permissions}">
					addPermissionRow('${it.trim()}');
				</g:each>
			});
		</script>