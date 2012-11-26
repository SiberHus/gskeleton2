		<script type="text/javascript">
			function addPermissionRow(permission){
				TableUI.addRow('permissionTbl', [
					"<input type='text' id='perm"+rowNum+"' name='permissions' value='"+permission+"' style='width:90%'/>&nbsp;"+
					"<a style='cursor:pointer;' onclick='TableUI.deleteRow(this);'><img src='${resource(dir:'/images/icons',file:'delete.png')}'/></a>"+
					"<a style='cursor:pointer;' id='addPerm"+rowNum+"' class='gs_setItem' lookupUrl='${gs.createLink(controller:'permission')}' refvid='perm"+rowNum+"'><img src='${resource(dir:'/images/icons',file:'add.png')}'/></a>"
				],function(){
					//add event handler dynamically
					$('#addPerm'+rowNum).click(function(){
						UI.showDialog($(this),{
							width:'680px',
							target:$(this).attr('lookupUrl')+'?gs_popup=true&gs_parentValueId='
								+$(this).attr('refvid')+'&gs_parentLabelId='+$(this).attr('reflid')
						});
					});
				});
			}
		</script>
		