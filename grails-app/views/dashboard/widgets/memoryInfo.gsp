
<script type="text/javascript">
	function callGc(){
		var c = confirm('This operation may slow down the system for a while. Do you still want to process?');
		if(!c) return;
		$.getJSON('${createLink(controller:'memoryInfoWidget',action:'executeGc')}',function(data){
			$('#memInfo_freeMemory').text(data.freeMemory);
			$('#memInfo_totalMemory').text(data.totalMemory);
			$('#memInfo_maxMemory').text(data.maxMemory);
		});
	}
</script>
<table style="width:100%">
	<thead>
		<th>Memory</th>
		<th>Amount</th>
	</thead>
	<tbody>
		<tr>
			<td>Free Memory</td>
			<td><span id="memInfo_freeMemory"><g:formatNumber number="${freeMemory}" format="###,###"/></span> MB</td>
		</tr>
		<tr>
			<td>Total Memory</td>
			<td><span id="memInfo_totalMemory"><g:formatNumber number="${totalMemory}" format="###,###"/></span> MB</td>
		</tr>
		<tr>
			<td>Max Memory</td>
			<td><span id="memInfo_maxMemory"><g:formatNumber number="${maxMemory}" format="###,###"/></span> MB</td>
		</tr>
		<tr>
			<td colspan="2">
				<hr/><br/>
				<a style="cursor:pointer" onclick="callGc();">Run Garbage Collector</a>
			</td>
		</tr>
	</tbody>
</table>