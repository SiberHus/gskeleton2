/**
 * dependencies: siberhus.js, micheal's multiselect.js, browser-detect.js
 */

function selectAllListItems(){
	//make sure select option value will be included to params
	//even though it's empty
	$("select.gs_multiSelect").each(function(){
		if($(this).val()==null){
			$(this).val('');
		}
	});
	$("select.gs_multiLookup").each(function(){
		if($(this).val()==null){
			SelectUI.addOption(this, '', '');
		}
		SelectUI.selectAll(this);
	});
}

function submitAction(targetForm, action){
	if(action !=null){
		var field = document.createElement('input');
		field.setAttribute('type', 'hidden');
		field.setAttribute('name', '_action_'+action);
		targetForm.appendChild(field);
	}
	selectAllListItems();
	targetForm.submit();
}

$(document).ready(function(){
	$("select.gs_multiSelect").multiselect();
	var dgOpen = false;
	$('a.gs_addItem').click(function(){
		UI.showDialog($(this),{
			width:'680px',
			target: $(this).attr('lookupUrl')
				+'?gs_popup=true&gs_multiselect=true&gs_parentValueId='+$(this).attr('refvid')
		});
	});
	$('a.gs_removeItem').click(function(){
		SelectUI.removeSelected($(this).attr('refvid'));
	});
	$('a.gs_setItem').click(function(){
		UI.showDialog($(this),{
			width:'680px',
			target:$(this).attr('lookupUrl')+'?gs_popup=true&gs_multiselect=false&gs_parentValueId='
				+$(this).attr('refvid')+'&gs_parentLabelId='+$(this).attr('reflid')
		});
	});
	$('a.gs_unsetItem').click(function(){
		var refvid = document.getElementById($(this).attr('refvid'));
		var reflid = document.getElementById($(this).attr('reflid'));
		//refvid.value = 'null';
		refvid.value = '';
		reflid.value = '';
	});
	$('a.gs_chooseItem').click(function(){
		var refValue = $(this).attr('refValue');
		var refLabel = $(this).attr('refLabel');
		var parentValueId = $('#gs_parentValueId').val();
		var parentLabelId = $('#gs_parentLabelId').val();
		var multiselect = $('#gs_multiselect').val();
		if(multiselect=='true'){
			UI.addParentElementValue(parentValueId,refValue,refLabel);
			$(this).addClass('hidden');
		}else{
			var parentValueElem = UI.getParentElementById(parentValueId);
			var parentLabelElem = UI.getParentElementById(parentLabelId);
			parentValueElem.value = refValue;
			parentLabelElem.value = refLabel;
			window.close();
		}
	});
	
	$("form").submit(function(){
		selectAllListItems();
	});
	
});