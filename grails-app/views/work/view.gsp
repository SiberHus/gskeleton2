<g:set var="theme_dir" value="${session.theme_dir}" scope="page"/>

<HTML>
	<HEAD>
		<META name="layout" content="viewLayout" />
		<TITLE><g:meta name="app.name"/> - ${controllerName }</TITLE>
	</HEAD>
	<BODY>
		<TABLE border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
		<TBODY>
		<TR>
			<TD>
				<TABLE border="0" cellspacing="0" cellpadding="3" width="100%" class="small">
				<TBODY>
					<TR>
						<TD class="dvtTabCache" style="width:10px" nowrap="">&nbsp;</TD>
						<TD class="dvtSelectedCell" align="center" nowrap="">Campaign Information</TD>
						<TD class="dvtTabCache" style="width:10px">&nbsp;</TD>
						<TD class="dvtUnSelectedCell" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?action=CallRelatedList&module=Campaigns&record=124&parenttab=Marketing">More Information</A>
						</TD>
						<TD class="dvtTabCache" align="right" style="width:100%">
							<INPUT title="Edit [Alt+E]" accesskey="E" class="crmbutton small edit" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;DetailView&#39;; DetailView.return_id.value=&#39;124&#39;;DetailView.module.value=&#39;Campaigns&#39;;submitFormForAction(&#39;DetailView&#39;,&#39;EditView&#39;);" type="button" name="Edit" value="&nbsp;Edit&nbsp;">&nbsp;
							<INPUT title="Duplicate [Alt+U]" accesskey="U" class="crmbutton small create" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;DetailView&#39;; DetailView.isDuplicate.value=&#39;true&#39;;DetailView.module.value=&#39;Campaigns&#39;; submitFormForAction(&#39;DetailView&#39;,&#39;EditView&#39;);" type="button" name="Duplicate" value="Duplicate">&nbsp;
							<INPUT title="Delete [Alt+D]" accesskey="D" class="crmbutton small delete" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;index&#39;;  var confirmMsg = &#39;Are you sure you want to delete this record?&#39; ; submitFormForActionWithConfirmation(&#39;DetailView&#39;, &#39;Delete&#39;, confirmMsg);" type="button" name="Delete" value="Delete">&nbsp;
							<IMG align="absmiddle" title="Previous" src="${resource(dir:'images',file:'rec_prev_disabled.gif')}">
							<IMG align="absmiddle" title="JUMP" accesskey="JUMP" onclick="var obj = this;var lhref = getListOfRecords(obj, &#39;Campaigns&#39;,124,&#39;Marketing&#39;);" name="jumpBtnIdTop" id="jumpBtnIdTop" src="${resource(dir:'images',file:'rec_jump.gif')}">&nbsp;
							<IMG align="absmiddle" title="Next" accesskey="Next" onclick="location.href=&#39;index.php?module=Campaigns&amp;viewtype=&amp;action=DetailView&amp;record=123&amp;parenttab=Marketing&amp;start=1&#39;" name="nextrecord" src="${resource(dir:'images',file:'rec_next.gif')}">&nbsp;
						</TD>
					</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD valign="top" align="left">                
				<TABLE border="0" cellspacing="0" cellpadding="3" width="100%" class="dvtContentSpace" style="border-bottom:0;">
				<TBODY>
					<TR>
						<TD align="left">
							<!-- content cache -->
							<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
        					<TBODY>
        						<TR>
									<TD style="padding:5px">
										<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
										<TBODY>
											<TR>
												<TD>&nbsp;</TD>
												<TD>&nbsp;</TD>
												<TD>&nbsp;</TD>
												<TD align="right"></TD>
         									</TR>
											<!-- This is added to display the existing comments -->
											<TR>
												<TD colspan="4" class="dvInnerHeader">
													<DIV style="float:left;font-weight:bold;">
														<DIV style="float:left;">
															<A href="javascript:showHideStatus('tblCampaignInformation','aidCampaignInformation','themes/softed/images/');">
																<IMG id="aidCampaignInformation" src="${resource(dir:'images',file:'activate.gif')}" style="border: 0px solid #000000;" alt="Hide" title="Hide">
															</A>
														</DIV>
														<B>&nbsp;Campaign Information</B>
													</DIV>
												</TD>
											</TR>
										</TBODY>
										</TABLE>
											<DIV style="width:auto;display:block;" id="tblCampaignInformation">
												<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
							     				<TBODY>
							     					<TR style="height:25px">
									   					<TD class="dvtCellLabel" align="right" width="25%">Campaign Name</TD>
														<TD width="25%" class="dvtCellInfo" align="left" valign="top">
															<SPAN id="campaignName" class="editableText">
																DM Campaign to Top Customers
															</SPAN>															
        												</TD>
        												
														<TD class="dvtCellLabel" align="right" width="25%">Campaign No</TD>
														<TD class="dvtCellInfo" align="left" width="25%&quot;">CAM3<input id="something" type="text" class="time"></input></TD>
													</TR>
							     					<TR style="height:25px">
									   					<TD class="dvtCellLabel" align="right" width="25%">Assigned To</TD>
														<TD width="25%" class="dvtCellInfo" align="left">															
															<A href="#"><IMG src="${resource(dir:'images',file:'anchor.png')}" border="0"/></A>
															<SPAN id="assignedTo" class="editableSelect" from="admin:1,normaluser:2">admin</SPAN>													
        												</TD>
        												
                                						<TD class="dvtCellLabel" align="right" width="25%">Campaign Status</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--ComboBox-->
														<TD width="25%" class="dvtCellInfo" align="left">
															<A href="#"><IMG src="${resource(dir:'images',file:'anchor.png')}" border="0"/></A>
															<SPAN id="campaignStatus" class="editableSelect"
																from="None,Active,Cancelled,Completed,Inactive,Plaining">
																Completed
															</SPAN>
        												</TD>
													</TR>	
							     					<TR style="height:25px">
									   					<TD class="dvtCellLabel" align="right" width="25%">
									   						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Campaign Type
									   					</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--ComboBox-->
								                        <TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Campaign Type" onmouseover="hndMouseOver(15,&#39;Campaign Type&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);">
								                        	<SPAN id="dtlview_Campaign Type">
								                        		<FONT color="">Direct Mail</FONT>
								                        	</SPAN>
                          									<DIV id="editarea_Campaign Type" style="display:none;">
																<SELECT id="txtbox_Campaign Type" name="campaigntype" class="small">
																	<OPTION value="--None--">--None--</OPTION>
																	<OPTION value="Advertisement">Advertisement</OPTION>
																	<OPTION value="Banner Ads">Banner Ads</OPTION>
																	<OPTION value="Conference">Conference</OPTION>
				                                                	<OPTION value="Direct Mail">Direct Mail</OPTION>
				                                                	<OPTION value="Email">Email</OPTION>
																</SELECT>
																<BR><INPUT name="button_Campaign Type" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Campaign Type&#39;,&#39;Campaigns&#39;,15,&#39;vtiger_campaign&#39;,&#39;campaigntype&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
	                          		   							<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Campaign Type&#39;,&#39;editarea_Campaign Type&#39;,&#39;Campaign Type&#39;)" class="link">Cancel</A>
															</DIV>
														</TD>
                      									<TD class="dvtCellLabel" align="right" width="25%">
                      										<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Product
                      									</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--ProductPopup-->
														<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Product" onmouseover="hndMouseOver(59,&#39;Product&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);">
															&nbsp;<SPAN id="dtlview_Product"><A href="http://localhost/vtigercrm/index.php?module=Products&action=DetailView&record=0"></A></SPAN>
                          									<DIV id="editarea_Product" style="display:none;">
																<INPUT id="popuptxt_Product" name="product_name" readonly="" type="text" value="">
																<INPUT id="txtbox_Product" name="product_id" type="hidden" value="0">&nbsp;
																<IMG src="${resource(dir:'images',file:'select.gif')}" alt="Select" title="Select" language="javascript" onclick="return window.open(&quot;index.php?module=Products&amp;action=Popup&amp;html=Popup_picker&amp;form=HelpDeskEditView&amp;popuptype=specific&quot;,&quot;test&quot;,&quot;width=600,height=602,resizable=1,scrollbars=1,top=150,left=200&quot;);" align="absmiddle" style="cursor:hand;cursor:pointer">&nbsp;
																<INPUT type="image" src="${resource(dir:'images',file:'clear_field.gif')}" alt="Clear" title="Clear" language="javascript" onclick="this.form.product_id.value=&#39;&#39;; this.form.product_name.value=&#39;&#39;; return false;" align="absmiddle" style="cursor:hand;cursor:pointer">
																<BR><INPUT name="button_Product" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Product&#39;,&#39;Campaigns&#39;,59,&#39;vtiger_campaign&#39;,&#39;product_id&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
																<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Product&#39;,&#39;editarea_Product&#39;,&#39;Product&#39;)" class="link">Cancel</A>
															</DIV>
                              							</TD>
													</TR>	
							     					<TR style="height:25px">
														<TD class="dvtCellLabel" align="right" width="25%">
															<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Target Audience
														</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--TextBox-->
														<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Target Audience" onmouseover="hndMouseOver(1,&#39;Target Audience&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">				
															&nbsp;&nbsp;<SPAN id="dtlview_Target Audience">Rookies</SPAN>
		    												<DIV id="editarea_Target Audience" style="display:none;">
        														<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Target Audience" name="targetaudience" maxlength="100" value="Rookies">
        														<BR><INPUT name="button_Target Audience" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Target Audience&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;targetaudience&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        														<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Target Audience&#39;,&#39;editarea_Target Audience&#39;,&#39;Target Audience&#39;)" class="link">Cancel</A>
        													</DIV>
														</TD>
                                						<TD class="dvtCellLabel" align="right" width="25%">
                                							<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected Close Date
                                						</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<TD class="dvtCellInfo" align="left" width="25%&quot;">&nbsp;2005-04-12</TD>
													</TR>	
													<TR style="height:25px">
														<TD class="dvtCellLabel" align="right" width="25%">
															<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Sponsor
														</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--TextBox-->
														<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Sponsor" onmouseover="hndMouseOver(1,&#39;Sponsor&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
															&nbsp;&nbsp;<SPAN id="dtlview_Sponsor">Sales</SPAN>
															<DIV id="editarea_Sponsor" style="display:none;">
        														<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Sponsor" name="sponsor" maxlength="100" value="Sales">
        														<BR><INPUT name="button_Sponsor" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Sponsor&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;sponsor&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        														<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Sponsor&#39;,&#39;editarea_Sponsor&#39;,&#39;Sponsor&#39;)" class="link">Cancel</A>
        													</DIV>
        												</TD>
                                						<TD class="dvtCellLabel" align="right" width="25%">
                                							<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Target Size
                                						</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--TextBox-->
														<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Target Size" onmouseover="hndMouseOver(1,&#39;Target Size&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">				
															&nbsp;&nbsp;<SPAN id="dtlview_Target Size">187424</SPAN>
		    												<DIV id="editarea_Target Size" style="display:none;">
	    														<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Target Size" name="targetsize" maxlength="100" value="187424">
	    														<BR><INPUT name="button_Target Size" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Target Size&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;targetsize&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
	    														<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Target Size&#39;,&#39;editarea_Target Size&#39;,&#39;Target Size&#39;)" class="link">Cancel</A>
        													</DIV>
        												</TD>
        											</TR>	
							     					<TR style="height:25px">
									   					<TD class="dvtCellLabel" align="right" width="25%">
									   						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Created Time
									   					</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->											
														<TD class="dvtCellInfo" align="left" width="25%&quot;">&nbsp;2010-02-09 13:27:03</TD>
                                						<TD class="dvtCellLabel" align="right" width="25%">
                                							<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Num Sent
                                						</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<!--TextBox-->
														<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Num Sent" onmouseover="hndMouseOver(9,&#39;Num Sent&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">				
															&nbsp;&nbsp;<SPAN id="dtlview_Num Sent">3000</SPAN>
		    												<DIV id="editarea_Num Sent" style="display:none;">
        														<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Num Sent" name="numsent" maxlength="100" value="3000"><BR>
        														<INPUT name="button_Num Sent" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Num Sent&#39;,&#39;Campaigns&#39;,9,&#39;vtiger_campaign&#39;,&#39;numsent&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        														<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Num Sent&#39;,&#39;editarea_Num Sent&#39;,&#39;Num Sent&#39;)" class="link">Cancel</A>
        													</DIV>
        												</TD>
													</TR>	
							     					<TR style="height:25px">
														<TD class="dvtCellLabel" align="right" width="25%">
															<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Modified Time
														</TD>
														<!-- This file is used to display the fields based on the ui type in detailview -->
														<TD class="dvtCellInfo" align="left" width="25%&quot;">&nbsp;2010-02-09 13:27:03</TD>
													</TR>
		 										</TBODY>
		 										</TABLE>
		 									</DIV>
                          				</TD>
									</TR>
								<TR>
									<TD style="padding:10px">			
										<!-- Detailed View Code starts here-->
										<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
										<TBODY>
											<TR>
        										<TD>&nbsp;</TD>
        										<TD>&nbsp;</TD>
        										<TD>&nbsp;</TD>
         										<TD align="right"></TD>
         									</TR>
											<!-- This is added to display the existing comments -->
											<TR>
												<TD colspan="4" class="dvInnerHeader">
													<DIV style="float:left;font-weight:bold;">
														<DIV style="float:left;">
															<A href="javascript:showHideStatus('tblExpectations&Actuals','aidExpectations&Actuals','themes/softed/images/');">
															<IMG id="aidExpectations&amp;Actuals" src="${resource(dir:'images',file:'activate.gif')}" style="border: 0px solid #000000;" alt="Hide" title="Hide"></A>
														</DIV>
														<B>&nbsp;Expectations &amp; Actuals</B>
													</DIV>
												</TD>
											</TR>
										</TBODY>
										</TABLE>
										<DIV style="width:auto;display:block;" id="tblExpectations&amp;Actuals">
											<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
											<TBODY>
												<TR style="height:25px">
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Budget Cost
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Budget Cost" onmouseover="hndMouseOver(1,&#39;Budget Cost&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">				
														&nbsp;&nbsp;<SPAN id="dtlview_Budget Cost">90000</SPAN>
		    											<DIV id="editarea_Budget Cost" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Budget Cost" name="budgetcost" maxlength="100" value="90000"><BR>
        													<INPUT name="button_Budget Cost" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Budget Cost&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;budgetcost&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Budget Cost&#39;,&#39;editarea_Budget Cost&#39;,&#39;Budget Cost&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Actual Cost
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Actual Cost" onmouseover="hndMouseOver(1,&#39;Actual Cost&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">				
														&nbsp;&nbsp;<SPAN id="dtlview_Actual Cost">80000</SPAN>
		    											<DIV id="editarea_Actual Cost" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Actual Cost" name="actualcost" maxlength="100" value="80000"><BR>
        													<INPUT name="button_Actual Cost" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Actual Cost&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;actualcost&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Actual Cost&#39;,&#39;editarea_Actual Cost&#39;,&#39;Actual Cost&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
												</TR>	
							     				<TR style="height:25px">
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected Response
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--ComboBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Expected Response" onmouseover="hndMouseOver(15,&#39;Expected Response&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);"><SPAN id="dtlview_Expected Response"><FONT color=""></FONT></SPAN>
                          								<DIV id="editarea_Expected Response" style="display:none;">
        					   								<SELECT id="txtbox_Expected Response" name="expectedresponse" class="small">
																<OPTION value="--None--">--None--</OPTION>
																<OPTION value="Average">Average</OPTION>
																<OPTION value="Excellent">Excellent</OPTION>
		                                						<OPTION value="Good">Good</OPTION>
																<OPTION value="Poor">Poor</OPTION>
															</SELECT>
															<BR>
															<INPUT name="button_Expected Response" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Expected Response&#39;,&#39;Campaigns&#39;,15,&#39;vtiger_campaign&#39;,&#39;expectedresponse&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
                          		   							<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Expected Response&#39;,&#39;editarea_Expected Response&#39;,&#39;Expected Response&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected Revenue
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Expected Revenue" onmouseover="hndMouseOver(1,&#39;Expected Revenue&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Expected Revenue">500000</SPAN>
		    											<DIV id="editarea_Expected Revenue" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Expected Revenue" name="expectedrevenue" maxlength="100" value="500000"><BR>
        													<INPUT name="button_Expected Revenue" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Expected Revenue&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;expectedrevenue&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Expected Revenue&#39;,&#39;editarea_Expected Revenue&#39;,&#39;Expected Revenue&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
												</TR>	
												<TR style="height:25px">
									   				<TD class="dvtCellLabel" align="right" width="25%">
									   					<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected Sales Count
									   				</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Expected Sales Count" onmouseover="hndMouseOver(1,&#39;Expected Sales Count&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Expected Sales Count">90000</SPAN>
														<DIV id="editarea_Expected Sales Count" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Expected Sales Count" name="expectedsalescount" maxlength="100" value="90000"><BR>
        													<INPUT name="button_Expected Sales Count" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Expected Sales Count&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;expectedsalescount&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Expected Sales Count&#39;,&#39;editarea_Expected Sales Count&#39;,&#39;Expected Sales Count&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Actual Sales Count
                                					</TD>
                                					<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Actual Sales Count" onmouseover="hndMouseOver(1,&#39;Actual Sales Count&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Actual Sales Count">2390</SPAN>
		    											<DIV id="editarea_Actual Sales Count" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Actual Sales Count" name="actualsalescount" maxlength="100" value="2390"><BR>
        													<INPUT name="button_Actual Sales Count" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Actual Sales Count&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;actualsalescount&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Actual Sales Count&#39;,&#39;editarea_Actual Sales Count&#39;,&#39;Actual Sales Count&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
												</TR>	
							     				<TR style="height:25px">
													<TD class="dvtCellLabel" align="right" width="25%">
														<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected Response Count
													</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Expected Response Count" onmouseover="hndMouseOver(1,&#39;Expected Response Count&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Expected Response Count">5000</SPAN>
		    											<DIV id="editarea_Expected Response Count" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Expected Response Count" name="expectedresponsecount" maxlength="100" value="5000"><BR>
        													<INPUT name="button_Expected Response Count" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Expected Response Count&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;expectedresponsecount&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Expected Response Count&#39;,&#39;editarea_Expected Response Count&#39;,&#39;Expected Response Count&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Actual Response Count
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Actual Response Count" onmouseover="hndMouseOver(1,&#39;Actual Response Count&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Actual Response Count">1500</SPAN>
		    											<DIV id="editarea_Actual Response Count" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Actual Response Count" name="actualresponsecount" maxlength="100" value="1500"><BR>
        													<INPUT name="button_Actual Response Count" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Actual Response Count&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;actualresponsecount&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Actual Response Count&#39;,&#39;editarea_Actual Response Count&#39;,&#39;Actual Response Count&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
        										</TR>	
							     				<TR style="height:25px">
									   				<TD class="dvtCellLabel" align="right" width="25%">
									   					<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Expected ROI
									   				</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Expected ROI" onmouseover="hndMouseOver(1,&#39;Expected ROI&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Expected ROI">82</SPAN>
		    											<DIV id="editarea_Expected ROI" style="display:none;">
        													<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Expected ROI" name="expectedroi" maxlength="100" value="82"><BR>
        													<INPUT name="button_Expected ROI" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Expected ROI&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;expectedroi&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Expected ROI&#39;,&#39;editarea_Expected ROI&#39;,&#39;Expected ROI&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Actual ROI
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextBox-->
													<TD width="25%" class="dvtCellInfo" align="left" id="mouseArea_Actual ROI" onmouseover="hndMouseOver(1,&#39;Actual ROI&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);" valign="top">
														&nbsp;&nbsp;<SPAN id="dtlview_Actual ROI">12</SPAN>
														<DIV id="editarea_Actual ROI" style="display:none;">
															<INPUT class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" type="text" id="txtbox_Actual ROI" name="actualroi" maxlength="100" value="12"><BR>
        													<INPUT name="button_Actual ROI" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Actual ROI&#39;,&#39;Campaigns&#39;,1,&#39;vtiger_campaign&#39;,&#39;actualroi&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
        													<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Actual ROI&#39;,&#39;editarea_Actual ROI&#39;,&#39;Actual ROI&#39;)" class="link">Cancel</A>
        												</DIV>
        											</TD>
        										</TR>	
											</TBODY>
											</TABLE>
		 								</DIV>
                          			</TD>
								</TR>
								<TR>
									<TD style="padding:10px">
										<!-- Detailed View Code starts here-->
										<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
										<TBODY>
											<TR>
        										<TD>&nbsp;</TD>
												<TD>&nbsp;</TD>
												<TD>&nbsp;</TD>
												<TD align="right"></TD>
											</TR>
											<!-- This is added to display the existing comments -->
		 									<TR>
		 										<TD colspan="4" class="dvInnerHeader">
		 											<DIV style="float:left;font-weight:bold;">
		 												<DIV style="float:left;">
		 													<A href="javascript:showHideStatus('tblDescriptionInformation','aidDescriptionInformation','themes/softed/images/');">
		 													<IMG id="aidDescriptionInformation" src="${resource(dir:'images',file:'activate.gif') }" style="border: 0px solid #000000;" alt="Hide" title="Hide"></A>
		 												</DIV>
		 												<B>&nbsp;Description Information</B>
		 											</DIV>
		 										</TD>
		     								</TR>
										</TBODY>
										</TABLE>
										<DIV style="width:auto;display:block;" id="tblDescriptionInformation">
											<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
											<TBODY>
												<TR style="height:25px">
                                					<TD class="dvtCellLabel" align="right" width="25%">
                                						<INPUT type="hidden" id="hdtxt_IsAdmin" value="1">Description
                                					</TD>
													<!-- This file is used to display the fields based on the ui type in detailview -->
													<!--TextArea/Description-->
													<!-- we will empty the value of ticket and faq comment -->
													<TD width="100%" colspan="3" class="dvtCellInfo" align="left" id="mouseArea_Description" onmouseover="hndMouseOver(19,&#39;Description&#39;);" onmouseout="fnhide(&#39;crmspanid&#39;);">
														&nbsp;<SPAN id="dtlview_Description"></SPAN>
                                            			<DIV id="editarea_Description" style="display:none;">
                                            				<TEXTAREA id="txtbox_Description" name="description" class="detailedViewTextBox" onfocus="this.className=&#39;detailedViewTextBoxOn&#39;" onblur="this.className=&#39;detailedViewTextBox&#39;" cols="90" rows="8"></TEXTAREA><BR>
                                            				<INPUT name="button_Description" type="button" class="crmbutton small save" value="Save" onclick="dtlViewAjaxSave(&#39;Description&#39;,&#39;Campaigns&#39;,19,&#39;vtiger_crmentity&#39;,&#39;description&#39;,&#39;124&#39;);fnhide(&#39;crmspanid&#39;);"> or
                                            				<A href="javascript:;" onclick="hndCancel(&#39;dtlview_Description&#39;,&#39;editarea_Description&#39;,&#39;Description&#39;)" class="link">Cancel</A>
                                            			</DIV>
                                    				</TD>
												</TR>
		 									</TBODY>
		 									</TABLE>
		 								</DIV>
                          			</TD>
								</TR>
								<TR>
									<TD style="padding:10px"></TD>
								</TR>
								<!-- Inventory - Product Details informations -->
								<TR></TR>
								<!-- End the form related to detail view -->
							</TBODY>
							</TABLE>
						</TD>
						<TD width="22%" valign="top" style="border-left:1px dashed #cccccc;padding:13px">				  
							<!-- right side relevant info -->
							<!-- Action links for Event & Todo START-by Minnie -->
			                <!-- Action links END -->
							<!-- Tag cloud display -->
							<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="tagCloud">
							<TBODY>
								<TR>
									<TD class="tagCloudTopBg"><IMG src="${resource(dir:theme_dir,file:'images/tagCloudName.gif')}" border="0"></TD>
								</TR>
								<TR>
        							<TD>
        								<DIV id="tagdiv" style="display:visible;">
        									<FORM method="POST" action="javascript:void(0);" onsubmit="return tagvalidate();">
        										<INPUT class="textbox" type="text" id="txtbox_tagfields" name="textbox_First Name" value="" style="width:100px;margin-left:5px;">&nbsp;&nbsp;
        										<INPUT name="button_tagfileds" type="submit" class="crmbutton small save" value="Tag it">
        									</FORM>
        								</DIV>
        							</TD>
        						</TR>
								<TR>
									<TD class="tagCloudDisplay" valign="top">
										<SPAN id="tagfields">
											<SPAN id="tag_11" class="" onmouseover="$(&quot;tagspan_11&quot;).style.display=&quot;inline&quot;;" onmouseout="$(&quot;tagspan_11&quot;).style.display=&quot;none&quot;;">
												<A class="tagit" href="http://localhost/vtigercrm/index.php?module=Home&action=UnifiedSearch&search_module=Campaigns&query_string=campaign" style="font-size: 10px">campaign</A>
												<SPAN class="" id="tagspan_11" style="display:none;cursor:pointer;" onclick="DeleteTag(11,124);">
													<IMG src="${resource(dir:'images',file:'del_tag.gif')}">
												</SPAN>
											</SPAN>
										</SPAN>
									</TD>
								</TR>
							</TBODY>
							</TABLE>
							<!-- End Tag cloud display -->
							<!-- Mail Merge-->
							<BR>
						</TD>
					</TR>
				</TBODY>
				</TABLE>
				<!-- PUBLIC CONTENTS STOPS-->
			</TD>
		</TR>
		<TR>
			<TD>
				<TABLE border="0" cellspacing="0" cellpadding="3" width="100%" class="small">
				<TBODY>
					<TR>
						<TD class="dvtTabCacheBottom" style="width:10px" nowrap="">&nbsp;</TD>
						<TD class="dvtSelectedCellBottom" align="center" nowrap="">Campaign Information</TD>	
						<TD class="dvtTabCacheBottom" style="width:10px">&nbsp;</TD>
						<TD class="dvtUnSelectedCell" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?action=CallRelatedList&module=Campaigns&record=124&parenttab=Marketing">More Information</A>
						</TD>
						<TD class="dvtTabCacheBottom" align="right" style="width:100%">
							&nbsp;
							<INPUT title="Edit [Alt+E]" accesskey="E" class="crmbutton small edit" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;DetailView&#39;; DetailView.return_id.value=&#39;124&#39;;DetailView.module.value=&#39;Campaigns&#39;;submitFormForAction(&#39;DetailView&#39;,&#39;EditView&#39;);" type="submit" name="Edit" value="&nbsp;Edit&nbsp;">&nbsp;
							<INPUT title="Duplicate [Alt+U]" accesskey="U" class="crmbutton small create" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;DetailView&#39;; DetailView.isDuplicate.value=&#39;true&#39;;DetailView.module.value=&#39;Campaigns&#39;; submitFormForAction(&#39;DetailView&#39;,&#39;EditView&#39;);" type="submit" name="Duplicate" value="Duplicate">&nbsp;
							<INPUT title="Delete [Alt+D]" accesskey="D" class="crmbutton small delete" onclick="DetailView.return_module.value=&#39;Campaigns&#39;; DetailView.return_action.value=&#39;index&#39;;  var confirmMsg = &#39;Are you sure you want to delete this record?&#39; ; submitFormForActionWithConfirmation(&#39;DetailView&#39;, &#39;Delete&#39;, confirmMsg);" type="button" name="Delete" value="Delete">&nbsp;
							<IMG align="absmiddle" title="Previous" src="${resource(dir:'images',file:'rec_prev_disabled.gif') }">
							<IMG align="absmiddle" title="JUMP" accesskey="JUMP" onclick="var obj = this;var lhref = getListOfRecords(obj, &#39;Campaigns&#39;,124,&#39;Marketing&#39;);" name="jumpBtnIdBottom" id="jumpBtnIdBottom" src="${resource(dir:'images',file:'rec_jump.gif') }">&nbsp;
							<IMG align="absmiddle" title="Next" accesskey="Next" onclick="location.href=&#39;index.php?module=Campaigns&amp;viewtype=&amp;action=DetailView&amp;record=123&amp;parenttab=Marketing&#39;" name="nextrecord" src="${resource(dir:'images',file:'rec_next.gif') }">&nbsp;
						</TD>
					</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
		</TBODY>
		</TABLE>
	</BODY>
</HTML>