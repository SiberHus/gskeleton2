<html>
    <head>
        <title>Welcome to Grails</title>
		<meta name="layout" content="userGuideLayout" />
	</head>
	<body>
		<h1>CodeIgniter URLs</h1> 
 
		<p>By default, URLs in CodeIgniter are designed to be search-engine and human friendly.  Rather than using the standard "query string"
		approach to URLs that is synonymous with dynamic systems, CodeIgniter uses a <strong>segment-based</strong> approach:</p> 
		 
		<code>example.com/<var>news</var>/<dfn>article</dfn>/<samp>my_article</samp></code> 
		 
		<p class="important"><strong>Note:</strong> Query string URLs can be optionally enabled, as described below.</p> 
		 
		<h2>URI Segments</h2> 
		 
		<p>The segments in the URL, in following with the Model-View-Controller approach, usually represent:</p> 
		 
		<code>example.com/<var>class</var>/<dfn>function</dfn>/<samp>ID</samp></code> 
		 
		<ol>
		<li>The first segment represents the controller <strong>class</strong> that should be invoked.</li> 
		<li>The second segment represents the class <strong>function</strong>, or method, that should be called.</li> 
		<li>The third, and any additional segments, represent the ID and any variables that will be passed to the controller.</li> 
		</ol> 
		 
		<p>The <a href="../libraries/uri.html">URI Class</a> and the <a href="../helpers/url_helper.html">URL Helper</a> 
		contain functions that make it easy to work with your URI data.  In addition, your URLs can be remapped using the
		<a href="routing.html">URI Routing</a> feature for more flexibility.</p> 
		 
		<h2>Removing the index.php file</h2> 
		 
		<p>By default, the <strong>index.php</strong> file will be included in your URLs:</p> 
		 
		<code>example.com/<var>index.php</var>/news/article/my_article</code> 
		 
		<p>You can easily remove this file by using a .htaccess file with some simple rules. Here is an example
		 of such a file, using the "negative" method in which everything is redirected except the specified items:</p> 
		 
		<code>RewriteEngine on<br /> 
		RewriteCond $1 !^(index\.php|images|robots\.txt)<br /> 
		RewriteRule ^(.*)$ /index.php/$1 [L]</code> 
		 
		<p>In the above example, any HTTP request other than those for index.php, images, and robots.txt is treated as
		a request for your index.php file.</p> 
		 
		 
		<h2>Adding a URL Suffix</h2> 
		 
		<p>In your <dfn>config/config.php</dfn> file you can specify a suffix that will be added to all URLs generated
		by CodeIgniter.  For example, if a URL is this:</p> 
		 
		<code>example.com/index.php/products/view/shoes</code> 
		 
		<p>You can optionally add a suffix, like <kbd>.html</kbd>, making the page appear to be of a certain type:</p> 
		 
		<code>example.com/index.php/products/view/shoes.html</code> 
		 
		 
		<h2>Enabling Query Strings</h2> 
		
		<p>In some cases you might prefer to use query strings URLs:</p> 
		 
		<code>index.php?c=products&amp;m=view&amp;id=345</code> 
		 
		<p>CodeIgniter optionally supports this capability, which can be enabled in your <dfn>application/config.php</dfn> file. If you
		open your config file you'll see these items:</p> 
		 
		<code>$config['enable_query_strings'] = FALSE;<br /> 
		$config['controller_trigger'] = 'c';<br /> 
		$config['function_trigger'] = 'm';</code> 
		 
		<p>If you change "enable_query_strings" to TRUE this feature will become active.  Your controllers and functions will then
		be accessible using the "trigger" words you've set to invoke your controllers and methods:</p> 
		 
		<code>index.php?c=controller&amp;m=method</code> 
		 
		<p class="important"><strong>Please note:</strong> If you are using query strings you will have to build your own URLs, rather than utilizing
		the URL helpers (and other helpers that generate URLs, like some of the form helpers) as these are designed to work with
		segment based URLs.</p> 
	</body>
</html>