<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><g:layoutTitle default="GSkeleton" /></title>
		<link rel="shortcut icon" href="${gs.resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />		
		<link  href="${gs.resource(dir:'css',file:'userguide.css')}" rel="stylesheet" type="text/css" />
		<g:javascript src="jquery-1.4.2.min.js" />
		<g:javascript src="jquery.cookie.js" />
		<script type="text/javascript">
			$(document).ready(function(){
				$("#nav").hide();
				$("#show_menu_toc").toggle(
					function(){
						$("#nav").slideDown();
					},
					function(){
						$("#nav").slideUp();
					}
				);
			});
		</script>
		<g:layoutHead />
	</head>
	<body>
		<!-- START NAVIGATION --> 
		<div id="nav">
			<div id="nav_inner">
				<table cellpadding="0" cellspaceing="0" border="0" style="width:98%">
					<tr>
						<td class="td" valign="top">
							<ul>
								<li><a href="#">User Guide Home</a></li>
								<li><a href="#">Table of Contents Page</a></li>
							</ul>
							<h3>Basic Info</h3>
							<ul>
								<li><a href="#">Server Requirements</a></li>
								<li><a href="#">License Agreement</a></li>
								<li><a href="#">Change Log</a></li>
								<li><a href="#">Credits</a></li>
							</ul>
						</td>
						<td class="td_sep" valign="top">
							<h3>General Topics</h3>
							<ul>
								<li><a href="#">Getting Started</a></li>
								<li><a href="#">CodeIgniter URLs</a></li>
								<li><a href="#">Reserved Names</a></li>
								<li><a href="#">Controllers</a></li>
							</ul>
							<h3>Specific Topics</h3>
							<ul>
								<li><a href="#">Getting Started</a></li>
								<li><a href="#">CodeIgniter URLs</a></li>
								<li><a href="#">Reserved Names</a></li>
								<li><a href="#">Controllers</a></li>
							</ul>
						</td>
						<td class="td_sep" valign="top">
							<h3>Class Reference</h3>
							<ul>
								<li><a href="#">Benchmarking Class</a></li>
								<li><a href="#">Calendaring Class</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="nav2">
			<a name="top"></a>
			<a id="show_menu_toc" href="javascript:void(0);">
				<img src="${resource(dir:'images/userguide',file:'nav_toggle_darker.jpg') }" 
					width="153" height="44" border="0" title="Toggle Table of Contents" 
					alt="Toggle Table of Contents" />
			</a>
		</div>
		<div id="masthead"> 
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%"> 
				<tr>
					<td><h1>CodeIgniter User Guide Version 1.7.2</h1></td> 
					<td id="breadcrumb_right"><a href="../toc.html">Table of Contents Page</a></td> 
				</tr> 
			</table>
		</div>
		<!-- END NAVIGATION -->
		
		<!-- START BREADCRUMB --> 
		<table cellpadding="0" cellspacing="0" border="0" style="width:100%"> 
			<tr> 
				<td id="breadcrumb"> 
					<a href="http://codeigniter.com/">CodeIgniter Home</a> &nbsp;&#8250;&nbsp;
					<a href="../index.html">User Guide Home</a> &nbsp;&#8250;&nbsp;URLS
				</td> 
				<td id="searchbox">
					<form method="get" action="http://www.google.com/search">
						<input type="hidden" name="as_sitesearch" id="as_sitesearch" value="codeigniter.com/user_guide/" />Search User Guide&nbsp; 
						<input type="text" class="input" style="width:200px;" name="q" id="q" size="31" maxlength="255" value="" />&nbsp;
						<input type="submit" class="submit" name="sa" value="Go" />
					</form>
				</td>
			</tr> 
		</table> 
		<!-- END BREADCRUMB -->
		
		<br clear="all" />
		
		<!-- START CONTENT --> 
		<div id="content">
			<g:layoutBody />
		</div>
		<!-- END CONTENT -->
		
		<div id="footer"> 
			<p> 
				<a href="#top">Top of Page</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;
				<a href="../index.html">User Guide Home</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;
				Next Topic:&nbsp;&nbsp;<a href="controllers.html">Controllers</a></p> 
				<p><a href="http://codeigniter.com">CodeIgniter</a> &nbsp;&middot;&nbsp; Copyright &#169; 2006-2009 &nbsp;&middot;&nbsp; <a href="http://ellislab.com/">Ellislab, Inc.</a>
			</p> 
		</div>
	</body>
</html>