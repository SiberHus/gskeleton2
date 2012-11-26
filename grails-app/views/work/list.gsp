<g:set var="theme_dir" value="${session.theme_dir}" scope="page"/>

<HTML>
	<HEAD>
		<META name="layout" content="mainLayout" />
		<STYLE type="text/css">
			.hidden {
				display:none;
			}
		</STYLE>
		<SCRIPT type="text/javascript">
			
			function addConditionRowToTable(){
				TableUI.addRow('advSearchTbl', [						
					"<DIV>"+$('#advSearchFieldsDiv').html()
						.replace('_advSearchFields','searchField'+rowNum)
						.replace('_operid','queryField'+rowNum)
						+"</DIV>",
					"<DIV id='queryField"+rowNum+"'></DIV>",						
					"<INPUT type='text' name='searchValue' class='detailedViewTextBox'>",
					"<INPUT type='button' value=' Remove ' onclick='TableUI.deleteRow(this);' class='crmbuttom small delete'>"
				]);
				$('#searchField'+(rowNum-1)).change(function(){
					var ft = $(this).val().split('\|')[1];
					var opid = $(this).attr('opid');
					if(ft=='t'){
					 	$('#'+opid).html($('#textQueryOpersDiv').html());
					}else{
						$('#'+opid).html($('#numberQueryOpersDiv').html());
					}
				});
			}
			
			$(function(){
				$('#btnL3Search').attr('src',"${resource(dir:theme_dir,file:'images/btnL3Search.gif')}");
				$('#btnL3Search').mouseover(function(){
					this.style.cursor='pointer';
				});		
				$('#btnL3Search').click(function(){
					$('#basicSearch').fadeIn();
					$('#advSearch').hide();					
				});
				$('#goToAdvSearch').click(function(){
					$('#basicSearch').hide();
					$('#advSearch').show();
				});
				$('#goToBasicSearch').click(function(){
					$('#basicSearch').show();
					$('#advSearch').hide();
				});
				$('.link').mouseover(function(){
					this.style.cursor='pointer';
				});
				$('#closeAdvSearch').click(function(){
					$('#advSearch').hide();
				});
				$('#closeBasicSearch').click(function(){
					$('#basicSearch').hide();
				});
				
				$('#basicSearchColumns').html($('#basicSearchFieldsDiv').html());
				
				$('#addMoreCondBtn').click(function(){
					addConditionRowToTable();
				});
				
				addConditionRowToTable();
			});
		</SCRIPT>
	</HEAD>
	<BODY>
		
		<DIV style="display:none;">
			<DIV id="textQueryOpersDiv">
				<SELECT id="textQueryOpers" name="queryOper" class="detailedViewTextBox">				
					<OPTION value="is">is</OPTION>
					<OPTION value="isn">is not</OPTION>				
					<OPTION value="bwt">begins with</OPTION>
					<OPTION value="ewt">ends with</OPTION>
					<OPTION value="cts">contains</OPTION>
					<OPTION value="dcts">does not contains</OPTION>
				</SELECT>
			</DIV>
			<DIV id="numberQueryOpersDiv">
				<SELECT id="numberQueryOpers" name="queryOper" class="detailedViewTextBox">
					<OPTION value="is">is</OPTION>
					<OPTION value="isn">is not</OPTION>
					<OPTION value="grt">greater than</OPTION>
					<OPTION value="lst">less than</OPTION>
					<OPTION value="grteq">greater or equal</OPTION>
					<OPTION value="lsteq">less or equal</OPTION>
				</SELECT>
			</DIV>
			
			<DIV id="basicSearchFieldsDiv">
				<SELECT id="basicSearchFields" name="fieldName" class="txtBox" style="width:150px">
					<OPTION value="firstName">First Name</OPTION>
					<OPTION value="lastName">Last Name</OPTION>
					<OPTION value="email">Email</OPTION>
					<OPTION value="birthdate">Birthdate</OPTION>
				</SELECT>
			</DIV>
			<DIV id="advSearchFieldsDiv">
				<SELECT id="_advSearchFields" opid="_operid" name="fieldName" class="detailedViewTextBox">
					<OPTION value=""></OPTION>
					<OPTION value="firstName|t">First Name</OPTION>
					<OPTION value="lastName|t">Last Name</OPTION>
					<OPTION value="email|t">Email</OPTION>
					<OPTION value="birthdate|n">Birthdate</OPTION>
					<OPTION value="salary|n">Salary</OPTION>
					<OPTION value="mobilePhone|t">Mobile Phone</OPTION>
				</SELECT>
			</DIV>
		</DIV>
		
		<TABLE border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
		<TBODY>
			<TR>
				<TD valign="top"><IMG src="${resource(dir:'images',file:'showPanelTopLeft.gif') }"></TD>
				<TD class="showPanelBg" valign="top" width="100%" style="padding:10px;">
	 				<!-- SIMPLE SEARCH -->
					<DIV id="basicSearch" style="z-index:1;display:none;position:relative;">
						<FORM name="basicSearch" method="post" action="http://localhost/vtigercrm/index.php" onSubmit="return callSearch(&#39;Basic&#39;);">
							<TABLE width="80%" cellpadding="5" cellspacing="0" class="searchUIBasic small" align="center" border="0">
							<TBODY>
								<TR>
									<TD class="searchUIName small" nowrap="" align="left">
										<SPAN class="moduleName">Search</SPAN><BR>
										<SPAN class="small"><A id="goToAdvSearch" href="#">Go to Advanced Search</A></SPAN>
									</TD>
									<TD class="small" nowrap="" align="right"><B>Search for</B></TD>
									<TD class="small"><INPUT type="text" class="txtBox" style="width:120px" name="search_text"></TD>
									<TD class="small" nowrap=""><B>In</B>&nbsp;</TD>
									<TD class="small" nowrap="">
										<DIV id="basicSearchColumns"></DIV>
			                        	<INPUT type="hidden" name="searchtype" value="BasicSearch">
									</TD>
									<TD class="small" nowrap="" width="40%">
					  					<INPUT name="submit" type="button" class="crmbutton small create" onClick="callSearch(&#39;Basic&#39;);" value=" Search Now ">&nbsp;
					  				</TD>
									<TD id="closeBasicSearch" class="small link" valign="top">[x]</TD>
								</TR>
								<TR>
									<TD colspan="7" align="center" class="small">
										<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
										<TBODY>
											<TR>
												<TD class="searchAlph" id="alpha_1" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=A&quot;,&quot;alpha_1&quot;)">A</TD><TD class="searchAlph" id="alpha_2" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=B&quot;,&quot;alpha_2&quot;)">B</TD><TD class="searchAlph" id="alpha_3" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=C&quot;,&quot;alpha_3&quot;)">C</TD><TD class="searchAlph" id="alpha_4" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=D&quot;,&quot;alpha_4&quot;)">D</TD><TD class="searchAlph" id="alpha_5" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=E&quot;,&quot;alpha_5&quot;)">E</TD><TD class="searchAlph" id="alpha_6" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=F&quot;,&quot;alpha_6&quot;)">F</TD><TD class="searchAlph" id="alpha_7" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=G&quot;,&quot;alpha_7&quot;)">G</TD><TD class="searchAlph" id="alpha_8" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=H&quot;,&quot;alpha_8&quot;)">H</TD><TD class="searchAlph" id="alpha_9" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=I&quot;,&quot;alpha_9&quot;)">I</TD><TD class="searchAlph" id="alpha_10" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=J&quot;,&quot;alpha_10&quot;)">J</TD><TD class="searchAlph" id="alpha_11" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=K&quot;,&quot;alpha_11&quot;)">K</TD><TD class="searchAlph" id="alpha_12" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=L&quot;,&quot;alpha_12&quot;)">L</TD><TD class="searchAlph" id="alpha_13" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=M&quot;,&quot;alpha_13&quot;)">M</TD><TD class="searchAlph" id="alpha_14" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=N&quot;,&quot;alpha_14&quot;)">N</TD><TD class="searchAlph" id="alpha_15" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=O&quot;,&quot;alpha_15&quot;)">O</TD><TD class="searchAlph" id="alpha_16" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=P&quot;,&quot;alpha_16&quot;)">P</TD><TD class="searchAlph" id="alpha_17" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=Q&quot;,&quot;alpha_17&quot;)">Q</TD><TD class="searchAlph" id="alpha_18" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=R&quot;,&quot;alpha_18&quot;)">R</TD><TD class="searchAlph" id="alpha_19" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=S&quot;,&quot;alpha_19&quot;)">S</TD><TD class="searchAlph" id="alpha_20" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=T&quot;,&quot;alpha_20&quot;)">T</TD><TD class="searchAlph" id="alpha_21" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=U&quot;,&quot;alpha_21&quot;)">U</TD><TD class="searchAlph" id="alpha_22" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=V&quot;,&quot;alpha_22&quot;)">V</TD><TD class="searchAlph" id="alpha_23" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=W&quot;,&quot;alpha_23&quot;)">W</TD><TD class="searchAlph" id="alpha_24" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=X&quot;,&quot;alpha_24&quot;)">X</TD><TD class="searchAlph" id="alpha_25" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=Y&quot;,&quot;alpha_25&quot;)">Y</TD><TD class="searchAlph" id="alpha_26" align="center" onClick="alphabetic(&quot;Campaigns&quot;,&quot;gname=&amp;query=true&amp;search_field=campaignname&amp;searchtype=BasicSearch&amp;type=alpbt&amp;search_text=Z&quot;,&quot;alpha_26&quot;)">Z</TD>
		                                	</TR>
		                        		</TBODY>
		                        		</TABLE>
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</FORM>
					</DIV>
					<!-- ADVANCED SEARCH -->
					<DIV id="advSearch" style="display:none;">
						<FORM name="advSearch" method="post" action="#" onSubmit="totalnoofrows();return callSearch(&#39;Advanced&#39;);">
							<TABLE cellspacing="0" cellpadding="5" width="80%" class="searchUIAdv1 small" align="center" border="0">
							<TBODY>
								<TR>
									<TD class="searchUIName small" nowrap="" align="left">
										<SPAN class="moduleName">Search</SPAN><BR>
										<SPAN class="small"><A id="goToBasicSearch" href="#">Go to Basic Search</A></SPAN>
									</TD>
									<TD nowrap="" class="small"><B><INPUT name="matchtype" type="radio" value="all">&nbsp;Match All of the Following</B></TD>
									<TD nowrap="" width="60%" class="small"><B><INPUT name="matchtype" type="radio" value="any" checked="">&nbsp;Match Any of the Following</B></TD>
									<TD id="closeAdvSearch" class="small link" valign="top">[x]</TD>
								</TR>
							</TBODY>
							</TABLE>
							<TABLE cellpadding="2" cellspacing="0" width="80%" align="center" class="searchUIAdv2 small" border="0">
							<TBODY>
								<TR>
									<TD align="center" class="small" width="90%">
										<DIV id="fixed" style="position:relative;width:95%;padding:0px; overflow:auto;border:1px solid #CCCCCC;background-color:#ffffff" class="small">
											<TABLE border="0" width="95%">
											<TBODY>
												<TR>
													<TD align="left">
														<TABLE id="advSearchTbl" width="100%" border="0" cellpadding="2" cellspacing="0" id="adSrc" align="left">
														<TBODY>
														</TBODY>
														</TABLE>
													</TD>
												</TR>
											</TBODY>
											</TABLE>
										</DIV>
									</TD>
								</TR>
							</TBODY>
							</TABLE>			
							<TABLE border="0" cellspacing="0" cellpadding="5" width="80%" class="searchUIAdv3 small" align="center">
							<TBODY>
								<TR>
									<TD align="left" width="40%">
										<INPUT id="addMoreCondBtn" type="button" name="more" value=" More " class="crmbuttom small edit">										
									</TD>
									<TD align="left" class="small">
										<INPUT type="button" class="crmbutton small create" value=" Search Now " onClick="totalnoofrows();callSearch('Advanced');">
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</FORM>
					</DIV>

	 
					<!-- PUBLIC CONTENTS STARTS-->
					<DIV id="ListViewContents" class="small" style="width:100%;">
	  					<SCRIPT language="JavaScript" type="text/javascript" src="./vTiger_list_files/ListView.js"></SCRIPT>
						<FORM name="massdelete" method="POST" id="massdelete" onSubmit="VtigerJS_DialogBox.block();">
							<INPUT name="search_url" id="search_url" type="hidden" value="">
							<INPUT name="idlist" id="idlist" type="hidden">
							<INPUT name="change_owner" type="hidden">
							<INPUT name="change_status" type="hidden">
							<INPUT name="action" type="hidden">
							<INPUT name="where_export" type="hidden" value="">
							<INPUT name="step" type="hidden">
							<INPUT name="allids" type="hidden" id="allids" value="124;123;122">
							<INPUT name="selectedboxes" id="selectedboxes" type="hidden" value="">
							<INPUT name="allselectedboxes" id="allselectedboxes" type="hidden" value="">
							<INPUT name="current_page_boxes" id="current_page_boxes" type="hidden" value="124;123;122">
							<!-- List View Master Holder starts -->
							<TABLE border="0" cellspacing="1" cellpadding="0" width="100%" class="lvtBg">
							<TBODY>
								<TR>
									<TD>
										<!-- List View's Buttons and Filters starts -->
					       			 	<TABLE border="0" cellspacing="0" cellpadding="2" width="100%" class="small">
						    			<TBODY>
				    						<TR>
												<!-- Buttons -->
												<TD style="padding-right:20px" nowrap="">
													<INPUT class="crmbutton small delete" type="button" value="Delete" onClick="return massDelete('Campaigns')">
													<INPUT class="crmbutton small edit" type="button" value="Mass Edit" onClick="return mass_edit(this, 'massedit', 'Campaigns', 'Marketing')">
												</TD>
												<TD class="small" nowrap="">
													Showing Records 1 - 3
												</TD>
												<!-- Page Navigation -->
												<TD nowrap="" width="30%" align="center">
													<TABLE border="0" cellspacing="0" cellpadding="0" class="small">
														<TBODY><TR><TD align="right" style="padding: 5px;"><IMG src="./vTiger_list_files/start_disabled.gif" border="0" align="absmiddle">&nbsp;<IMG src="./vTiger_list_files/previous_disabled.gif" border="0" align="absmiddle">&nbsp;<INPUT class="small" name="pagenum" type="text" value="1" style="width: 3em;margin-right: 0.7em;" onChange="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;start='+this.value+'');" onKeyPress="return VT_disableFormSubmit(event);"><SPAN name="Campaigns_listViewCountContainerName" class="small" style="white-space: nowrap;">of 1</SPAN><IMG src="./vTiger_list_files/next_disabled.gif" border="0" align="absmiddle">&nbsp;<IMG src="./vTiger_list_files/end_disabled.gif" border="0" align="absmiddle">&nbsp;</TD></TR>
													</TBODY></TABLE>
								                </TD>
												<TD width="40%" align="right">
								  					<!-- Filters -->
								   					<TABLE border="0" cellspacing="0" cellpadding="0" class="small">
													<TBODY>
														<TR>
															<TD>Filters :</TD>
															<TD style="padding-left:5px;padding-right:5px">
				                            					<SELECT name="viewname" id="viewname" class="small" onChange="showDefaultCustomView(this,'Campaigns','Marketing')">
				                            						<OPTION selected="" value="29">All</OPTION>
				                            					</SELECT>
				                            				</TD>
				                            				<TD>
				                            					<A href="#new">New</A>
																<SPAN class="small">|</SPAN>
																<SPAN class="small" disabled="">Edit</SPAN>
																<SPAN class="small">|</SPAN>
																<SPAN class="small" disabled="">Delete</SPAN>
															</TD>
										    			</TR>
													</TBODY>
													</TABLE> 
					   								<!-- Filters  END-->
												</TD>
	       		    						</TR>
										</TBODY>
										</TABLE>
										<!-- List View's Buttons and Filters ends -->			
										
										<DIV>
											<TABLE border="0" cellspacing="1" cellpadding="3" width="100%" class="lvt small">
											<!-- Table Headers -->
											<TBODY>
												<TR>
				            						<TD class="lvtCol">
				            							<INPUT type="checkbox" name="selectall" onClick="toggleSelect_ListView(this.checked,&quot;selected_id&quot;)">
				            						</TD>
													<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=campaign_no&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Campaign No</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=campaignname&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Campaign Name</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=campaigntype&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Campaign Type</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=campaignstatus&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Campaign Status</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=expectedrevenue&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Expected Revenue</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=closingdate&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Expected Close Date</A></TD>
								 					<TD class="lvtCol"><A href="javascript:;" onClick="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;order_by=smownerid&amp;start=&amp;sorder=ASC&amp;viewname=29');" class="listFormHeaderLinks">Assigned To</A></TD>
								 					<TD class="lvtCol">Action</TD>
												</TR>
												<!-- Table Contents -->
												<TR bgcolor="white" onMouseOver="this.className='lvtColDataHover'" onMouseOut="this.className='lvtColData'" id="row_124" class="lvtColData">
													<TD width="2%"><INPUT type="checkbox" name="selected_id" id="124" value="124" onClick="check_object(this)"></TD>							
													<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">CAM3 <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="campaign_no" vtmodule="Campaigns" style="display:none;"></SPAN></TD>				        				
													<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))"><A href="http://localhost/vtigercrm/index.php?action=DetailView&module=Campaigns&record=124&parenttab=Marketing">DM Campaign to Top Customers</A> <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="campaignname" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
													<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">Direct Mail <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="campaigntype" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
										        	<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">Completed <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="campaignstatus" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
									        		<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">500000 <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="expectedrevenue" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
									        		<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">2005-04-12 <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="closingdate" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
									        		<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">admin <SPAN type="vtlib_metainfo" vtrecordid="124" vtfieldname="assigned_user_id" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
									        		<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))"><A href="http://localhost/vtigercrm/index.php?module=Campaigns&action=EditView&record=124&return_module=Campaigns&return_action=index&parenttab=Marketing&return_viewname=29">edit</A>  | <A href="javascript:confirmdelete("index.php%3Fmodule%3DCampaigns%26action%3DDelete%26record%3D124%26return_module%3DCampaigns%26return_action%3Dindex%26parenttab%3DMarketing%26return_viewname%3D29")">del</A></TD>
								        		</TR>
												<TR bgcolor="white" onMouseOver="this.className='lvtColDataHover'" onMouseOut="this.className='lvtColData'" id="row_123" class="lvtColData">
													<TD width="2%"><INPUT type="checkbox" name="selected_id" id="123" value="123" onClick="check_object(this)"></TD>
													<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">CAM2 <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="campaign_no" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))"><A href="http://localhost/vtigercrm/index.php?action=DetailView&module=Campaigns&record=123&parenttab=Marketing">International Electrical Engineers Assoc...</A> <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="campaignname" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">Trade Show <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="campaigntype" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">Planning <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="campaignstatus" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">750000 <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="expectedrevenue" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">2004-02-03 <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="closingdate" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))">admin <SPAN type="vtlib_metainfo" vtrecordid="123" vtfieldname="assigned_user_id" vtmodule="Campaigns" style="display:none;"></SPAN></TD>
								        			<TD onMouseOver="vtlib_listview.trigger('cell.onmouseover', $(this))" onMouseOut="vtlib_listview.trigger('cell.onmouseout', $(this))"><A href="http://localhost/vtigercrm/index.php?module=Campaigns&action=EditView&record=123&return_module=Campaigns&return_action=index&parenttab=Marketing&return_viewname=29">edit</A>  | <A href="javascript:confirmdelete("index.php%3Fmodule%3DCampaigns%26action%3DDelete%26record%3D123%26return_module%3DCampaigns%26return_action%3Dindex%26parenttab%3DMarketing%26return_viewname%3D29")">del</A></TD>
								        		</TR>
											</TBODY>
											</TABLE>
										</DIV>			 
										<TABLE border="0" cellspacing="0" cellpadding="2" width="100%">
						      			<TBODY>
							      			<TR>
									 			<TD style="padding-right:20px" nowrap=""> </TD>
												<TD class="small" nowrap="">
													Showing Records 1 - 3
												</TD>
												<TD nowrap="" width="30%" align="center">
									    			<TABLE border="0" cellspacing="0" cellpadding="0" class="small">
									         		<TBODY>
									         			<TR>
									         				<TD align="right" style="padding: 5px;"><IMG src="./vTiger_list_files/start_disabled.gif" border="0" align="absmiddle">&nbsp;<IMG src="./vTiger_list_files/previous_disabled.gif" border="0" align="absmiddle">&nbsp;<INPUT class="small" name="pagenum" type="text" value="1" style="width: 3em;margin-right: 0.7em;" onChange="getListViewEntries_js('Campaigns','parenttab=Marketing&amp;start='+this.value+'');" onKeyPress="return VT_disableFormSubmit(event);"><SPAN name="Campaigns_listViewCountContainerName" class="small" style="white-space: nowrap;">of 1</SPAN><IMG src="./vTiger_list_files/next_disabled.gif" border="0" align="absmiddle">&nbsp;<IMG src="./vTiger_list_files/end_disabled.gif" border="0" align="absmiddle">&nbsp;</TD>
									         			</TR>
									     			</TBODY>
									     			</TABLE>
									 			</TD>
									 			<TD align="right" width="40%">
									   				<TABLE border="0" cellspacing="0" cellpadding="0" class="small">
													<TBODY>
														<TR></TR>
									   				</TBODY></TABLE>
									 			</TD>
							      			</TR>
				       		    		</TBODY>
				       		    		</TABLE>
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</FORM>
					</DIV>
				</TD>
				<TD valign="top"><IMG src="${resource(dir:'images',file:'showPanelTopRight.gif') }"></TD>
			</TR>
		</TBODY>
		</TABLE>
	
	</BODY>
</HTML>


