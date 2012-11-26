		<script type="text/javascript">
			$(function(){
				toggleDisplayOrder($('#pinned'));
				$('#pinned').click(function(){
					toggleDisplayOrder($(this));
				});
			});
			function toggleDisplayOrder(pinElem){
				if(pinElem.attr('checked')){
					$('#displayOrderRow').fadeIn();
				}else{
					$('#displayOrderRow').hide();
				}
			}
		</script>