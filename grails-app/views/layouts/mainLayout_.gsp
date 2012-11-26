<g:set var="theme_dir" value="themes/softed" scope="session"/>
<g:set var="theme_dir" value="${session.theme_dir}" scope="page"/>

<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<TITLE><g:meta name="app.name"/> - ${controllerName }</TITLE>
		<LINK rel="SHORTCUT ICON" href="http://localhost/vtigercrm/themes/images/vtigercrm_icon.ico">		
		<STYLE type="text/css">@import url("${resource(dir:theme_dir,file:'style.css')}");</STYLE>
		<STYLE type="text/css">@import url("${resource(dir:'css',file:'anytime.css')}");</STYLE>
		<STYLE type="text/css">@import url("${resource(dir:'css',file:'dashboard.css')}");</STYLE>
		<g:javascript src="jquery-1.4.2.min.js"/>
		<g:javascript src="anytime.js"/>
		<g:javascript src="siberhus.js"/>
		<SCRIPT type="text/javascript">
			$(function(){
				$("input.date").AnyTime_picker( 
					{ format: "%d/%m/%Z ", labelTitle: "Date"} );
				$("input.datetime").AnyTime_picker( 
					{ format: "%d/%m/%Z %T", labelTitle: "DateTime"} );
				$("input.time").AnyTime_picker( 
					{ format: "%T", labelTitle: "Time"} );
			});
		</SCRIPT>
		<g:layoutHead />
	</HEAD>
	<BODY>
	<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="hdrNameBg">
	<TBODY>
		<TR>
			<TD valign="top">
				<IMG src="${resource(dir:'images',file:'vtiger-crm.gif')}" alt="vtiger CRM" title="vtiger CRM" border="0">
			</TD>
			<TD width="100%" align="center">
				<MARQUEE id="rss" direction="left" scrolldelay="10" scrollamount="3" behavior="scroll" class="marStyle" onmouseover="javascript:stop();" onmouseout="javascript:start();">&nbsp;</MARQUEE>                		
			</TD>
				<TABLE border="0" cellspacing="0" cellpadding="0">
			 	<TBODY>
			 		<TR>
						<!-- gmailbookmarklet customization -->
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
							<A href="javascript:(function()%7Bvar%20doc=top.document;var%20bodyElement=document.body;doc.vtigerURL%20=%22http://localhost/vtigercrm/%22;var%20scriptElement=document.createElement(%22script%22);scriptElement.type=%22text/javascript%22;scriptElement.src=doc.vtigerURL+%22modules/Emails/GmailBookmarkletTrigger.js%22;bodyElement.appendChild(scriptElement);%7D)();">Gmail Bookmarklet</A>
			 			</TD>
			 			<!-- END -->
			  			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			  				<A href="javascript:void(0);" onclick="vtiger_news(this)">vtiger News</A>
			  			</TD>
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			 				<A href="javascript:void(0);" onclick="vtiger_feedback();">Feedback</A>
			 			</TD>			 
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			 				<A href="http://localhost/vtigercrm/index.php?module=Users&action=DetailView&record=1&modechk=prefview">My Preferences</A>
			 			</TD>
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			 				<A href="http://wiki.vtiger.com/index.php/Main_Page" target="_blank">Help</A>
			 			</TD>
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			 				<A href="javascript:;" onclick="openwin();">About Us</A>
			 			</TD>
			 			<TD style="padding-left:10px;padding-right:10px" class="small" nowrap="">
			 				<A href="http://localhost/vtigercrm/index.php?module=Users&action=Logout">Sign Out</A> (admin)
			 			</TD>
			 		</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
	</TABLE>
	
	
	<!-- header - master tabs -->
	<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="hdrTabBg">
	<TBODY>
		<TR>
			<TD style="width:50px" class="small">&nbsp;</TD>
			<TD class="small" nowrap=""> 
				<TABLE border="0" cellspacing="0" cellpadding="0">
				<TBODY>
					<TR>
						<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabSelected" onmouseover="fnDropDown(this,&#39;My Home Page_sub&#39;);" 
							onmouseout="fnHideDrop(&#39;My Home Page_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Home&action=index&parenttab=My%20Home%20Page">My Home Page</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Marketing_sub&#39;);" 
							onmouseout="fnHideDrop(&#39;Marketing_sub&#39;);" align="center" nowrap="">
								<A href="http://localhost/vtigercrm/index.php?module=Campaigns&action=index&parenttab=Marketing">Marketing</A>
								<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
					  	<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Sales_sub&#39;);" onmouseout="fnHideDrop(&#39;Sales_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Leads&action=index&parenttab=Sales">Sales</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Support_sub&#39;);" onmouseout="fnHideDrop(&#39;Support_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=HelpDesk&action=index&parenttab=Support">Support</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Analytics_sub&#39;);" onmouseout="fnHideDrop(&#39;Analytics_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Reports&action=index&parenttab=Analytics">Analytics</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Inventory_sub&#39;);" onmouseout="fnHideDrop(&#39;Inventory_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Products&action=index&parenttab=Inventory">Inventory</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Tools_sub&#39;);" onmouseout="fnHideDrop(&#39;Tools_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Rss&action=index&parenttab=Tools">Tools</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD class="tabUnSelected" onmouseover="fnDropDown(this,&#39;Settings_sub&#39;);" onmouseout="fnHideDrop(&#39;Settings_sub&#39;);" align="center" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Settings&action=index&parenttab=Settings">Settings</A>
							<IMG src="${resource(dir:'images',file:'menuDnArrow.gif')}" border="0" style="padding-left:5px">
						</TD>
				  		<TD class="tabSeperator"><IMG src="${resource(dir:'images',file:'spacer.gif')}"></TD>
						<TD style="padding-left:10px" nowrap="">
							<SELECT class="small" id="qccombo" style="width:110px" onchange="QCreate(this);">
								<OPTION value="none">Quick Create...</OPTION>
								<OPTION value="Accounts">New&nbsp;Account</OPTION>
								<OPTION value="Calendar">New&nbsp;To Do</OPTION>
								<OPTION value="Campaigns">New&nbsp;Campaign</OPTION>
                               </SELECT>					
						</TD>
					</TR>
				</TBODY>
				</TABLE>
			</TD>
			<TD align="right" style="padding-right:10px" nowrap="">
				<TABLE border="0" cellspacing="0" cellpadding="0" id="search" style="border:1px solid #999999;background-color:white">
		   		<TBODY>
		   			<TR>
						<FORM name="UnifiedSearch" method="post" action="./vTiger_edit_files/vTiger_edit.htm" style="margin:0px" onsubmit="VtigerJS_DialogBox.block();">
						</FORM>
						<TD style="height:19px;background-color:#ffffef" nowrap="">
							<A href="javascript:void(0);" onclick="UnifiedSearch_SelectModuleForm(this);">
								<IMG src="${resource(dir:'images',file:'settings_top.gif') }" align="left" border="0">
							</A>
							<INPUT type="hidden" name="action" value="UnifiedSearch" style="margin:0px">
							<INPUT type="hidden" name="module" value="Home" style="margin:0px">
							<INPUT type="hidden" name="parenttab" value="My Home Page" style="margin:0px">
							<INPUT type="hidden" name="search_onlyin" value="--USESELECTED--" style="margin:0px">
							<INPUT type="text" name="query_string" value="Search..." class="searchBox" onfocus="this.value=&#39;&#39;">
						</TD>
						<TD style="background-color:#cccccc">
							<INPUT type="submit" class="searchBtn" value="Find" alt="Find" title="Find">
						</TD>
		   			</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
	</TABLE>
	
	<!-- - level 2 tabs starts-->
	<TABLE border="0" cellspacing="0" cellpadding="2" width="100%" class="level2Bg">
	<TBODY>
		<TR>
			<TD>
				<TABLE border="0" cellspacing="0" cellpadding="0">
				<TBODY>
					<TR>								      					 
      					<TD class="level2UnSelTab" nowrap>
      						<A href="index.php?module=Home&action=index&parenttab=My Home Page">Home</A>
      					</TD>
						<TD class="level2UnSelTab" nowrap>
							<A href="index.php?module=Calendar&action=index&parenttab=My Home Page">Calendar</A>
						</TD>
						<TD class="level2UnSelTab" nowrap>
							<A href="index.php?module=Webmails&action=index&parenttab=My Home Page">Webmail</A>
						</TD>
						<TD class="level2UnSelTab" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Home&action=index&parenttab=My%20Home%20Page">Home</A>
						</TD>
						<TD class="level2UnSelTab" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Calendar&action=index&parenttab=My%20Home%20Page">Calendar</A>
						</TD>
						<TD class="level2UnSelTab" nowrap="">
							<A href="http://localhost/vtigercrm/index.php?module=Webmails&action=index&parenttab=My%20Home%20Page">Webmail</A>
						</TD>
					</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
	</TABLE>		
	<!-- Level 2 tabs ends -->

	<DIV id="spinner" class="spinner" style="display: none;">
		<IMG src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
	</DIV>
	<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="small">
	<TBODY>
		<TR>
			<TD style="height: 2px">
		</TR>
		<TR>
			<TD style="padding-left: 10px; padding-right: 50px" class="moduleName" nowrap="">
				My Home Page &gt; 
				<A class="hdrLink" href="http://localhost/vtigercrm/index.php?action=ListView&module=Campaigns&parenttab=My%20Home%20Page">
					Campaigns
				</A>
			</TD>
			<TD width="100%" nowrap="">
			<TABLE border="0" cellspacing="0" cellpadding="0">
				<TBODY>
					<TR>
						<TD class="sep1" style="width: 1px;">
						<TD class="small"><!-- Add and Search -->
							<TABLE border="0" cellspacing="0" cellpadding="0">
							<TBODY>
								<TR>
									<TD>
										<TABLE border="0" cellspacing="0" cellpadding="5">
										<TBODY>
											<TR>
												<TD style="padding-right: 0px; padding-left: 10px;">
													<A href="http://localhost/vtigercrm/index.php?module=Campaigns&action=EditView&return_action=DetailView&parenttab=My%20Home%20Page">
														<IMG src="${resource(dir:theme_dir,file:'images/btnL3Add.gif')}" alt="Create Campaign..." title="Create Campaign..." border="0">
													</A>
												</TD>
												<TD style="padding-right: 10px">
													<IMG id="btnL3Search" src="${resource(dir:'images',file:'btnL3Search-Faded.gif')}" border="0">
												</TD>
											</TR>
										</TBODY>
										</TABLE>
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</TD>
						<TD style="width: 20px;">&nbsp;</TD>
						<TD class="small"><!-- Calendar Clock Calculator and Chat -->
							<TABLE border="0" cellspacing="0" cellpadding="5">
							<TBODY>
								<TR>
									<TD style="padding-right: 0px; padding-left: 10px;">
										<A href="javascript:;" onClick="fnvshobj(this,&quot;miniCal&quot;);getMiniCal(&quot;parenttab=My Home Page&quot;);">
											<IMG src="${resource(dir:theme_dir,file:'images/btnL3Calendar.gif')}" alt="Open Calendar..." title="Open Calendar..." border="0">
										</A>
									</TD>
									<TD style="padding-right: 0px">
										<A href="javascript:;">
											<IMG src="${resource(dir:theme_dir,file:'images/btnL3Clock.gif')}" alt="Show World Clock..." title="Show World Clock..."
												border="0" onClick="fnvshobj(this,&#39;wclock&#39;);">
										</A>
									</TD>
									<TD style="padding-right: 0px">
										<A href="http://localhost/vtigercrm/index.php#">
											<IMG src="${resource(dir:theme_dir,file:'images/btnL3Calc.gif')}" alt="Open Calculator..." title="Open Calculator..." border="0"
												onClick="fnvshobj(this,&#39;calculator_cont&#39;);fetch_calc();">
										</A>
									</TD>
									<TD style="padding-right: 0px">
										<A href="javascript:;"
											onClick="return window.open(&quot;index.php?module=Home&amp;action=vtchat&quot;,&quot;Chat&quot;,&quot;width=600,height=450,resizable=1,scrollbars=1&quot;);"><IMG
											src="${resource(dir:theme_dir,file:'images/tbarChat.gif')}" alt="Chat..." title="Chat..." border="0">
										</A>
									</TD>
									<TD style="padding-right: 10px">
										<IMG src="${resource(dir:theme_dir,file:'images/btnL3Tracker.gif')}" alt="Last Viewed"
											title="Last Viewed" border="0" onClick="fnvshobj(this,&#39;tracker&#39;);">
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</TD>
						<TD style="width: 20px;">&nbsp;</TD>
						<TD class="small"><!-- Import / Export -->
							<TABLE border="0" cellspacing="0" cellpadding="5">
							<TBODY>
								<TR>
									<TD style="padding-right: 0px; padding-left: 10px;">
										<IMG src="${resource(dir:'images',file:'tbarImport-Faded.gif')}" border="0">
									</TD>
									<TD style="padding-right: 10px">
										<IMG src="${resource(dir:'images',file:'tbarExport-Faded.gif')}" border="0">
									</TD>
										<TD style="padding-right: 10px">
										<IMG src="${resource(dir:'images',file:'FindDuplicates-Faded.gif')}" border="0">
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</TD>
						<TD style="width: 20px;">&nbsp;</TD>
						<TD class="small"><!-- All Menu -->
							<TABLE border="0" cellspacing="0" cellpadding="5">
							<TBODY>
								<TR>
									<TD style="padding-left: 10px;">
										<A href="javascript:;" onMouseOut="fninvsh(&#39;allMenu&#39;);"
											onClick="fnvshobj(this,&#39;allMenu&#39;)">
											<IMG src="${resource(dir:theme_dir,file:'images/btnL3AllMenu.gif')}"
												alt="Open All Menu..." title="Open All Menu..." border="0">
										</A>
									</TD>
									<TD style="padding-left: 10px;">
										<A href="http://localhost/vtigercrm/index.php?module=Settings&action=ModuleManager&module_settings=true&formodule=Campaigns&parenttab=Settings">
											<IMG src="${resource(dir:theme_dir,file:'images/settingsBox.png')}"
												alt="Campaigns Settings" title="Campaigns Settings" border="0">
										</A>
									</TD>
								</TR>
							</TBODY>
							</TABLE>
						</TD>
					</TR>
				</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
	</TABLE>
	
	<g:layoutBody />

	</BODY>
</HTML>

