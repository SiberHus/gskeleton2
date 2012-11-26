<%--
  Created by IntelliJ IDEA.
  User: hussachai
  Date: Sep 13, 2010
  Time: 1:49:05 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Simple GSP page</title></head>
  <body>
	<%
		long t1 = System.currentTimeMillis()
		for(i in 1..1000){
			wp.script([name:'jquery'])
		}
		long t2 = System.currentTimeMillis()
		System.out.println(t2-t1)

		t1 = System.currentTimeMillis()
		for(i in 1..1000){
			g.resource([dir:'js',file:'jquery-1.4.2.js',plugin:'gskeleton-two'])
		}
		t2 = System.currentTimeMillis()
		System.out.println(t2-t1)
	%>
  	<wp:script name="jquery"/>
  	
  </body>
</html>