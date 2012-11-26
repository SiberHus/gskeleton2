<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${request.contextPath} Chart Servlet Test Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
This page contains a bunch of charts that we're using to test ${request.contextPath}:
<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=p3&chd=s:hW&chs=250x100&chl=Hello|World" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=p3&chd=s:hW&chs=250x100&chl=Hello|World" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=p3&chs=200x90&chd=s:Hellobla&chl=May|Jun|Jul|Aug|Sep|Oct&chco=0000ff" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=p3&chs=200x90&chd=s:Hellobla&chl=May|Jun|Jul|Aug|Sep|Oct&chco=0000ff" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:HELo" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=bhs&chs=200x125&chd=s:HELo" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=bvs&chd=s:YUVmw1&chco=0000FF&chs=180x150&chtt=Site+visitors&chts=0000FF,20&chbh=22,4" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=bvs&chd=s:YUVmw1&chco=0000FF&chs=180x150&chtt=Site+visitors&chts=0000FF,20&chbh=22,4" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0,0.0,0.0&chxt=x,y&chxl=0:|0|1|2|3|4|5|1:|0|50|100&chs=200x125&chg=20,50" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0,0.0,0.0&chxt=x,y&chxl=0:|0|1|2|3|4|5|1:|0|50|100&chs=200x125&chg=20,50" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=s&chd=s:984sttvuvkQIBLKNCAIi,DEJPgq0uov17zwopQODS,AFLPTXaflptx159gsDrn&chxt=x,y&chxl=0:|0|2|3|4|5|6|7|8|9|10|1:|0|25|50|75|100&chs=200x125" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=s&chd=s:984sttvuvkQIBLKNCAIi,DEJPgq0uov17zwopQODS,AFLPTXaflptx159gsDrn&chxt=x,y&chxl=0:|0|2|3|4|5|6|7|8|9|10|1:|0|25|50|75|100&chs=200x125" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=FF0000&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|1|2|3|4|5|1:|0|50|100&chf=c,lg,0,76A4FB,1,ffffff,0|bg,s,EFEFEF" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=FF0000&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|1|2|3|4|5|1:|0|50|100&chf=c,lg,0,76A4FB,1,ffffff,0|bg,s,EFEFEF" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,A0BAE9,0,0.75,0.25|R,ff0000,0,0.1,0.11" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,A0BAE9,0,0.75,0.25|R,ff0000,0,0.1,0.11" alt="Where's ${request.contextPath}?" />

<br><br>
<img border="1" src="http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,ff0000,0,0.1,0.11|R,A0BAE9,0,0.75,0.25|r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11" alt="Where's Google?" />
<img border="1" src="${request.contextPath}/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,ff0000,0,0.1,0.11|R,A0BAE9,0,0.75,0.25|r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11" alt="Where's ${request.contextPath}?" />

<br><br>
<img src="http://chart.apis.google.com/chart?chco=00AF33,4BB74C,EE2C2C,CC3232,33FF33,66FF66,9AFF9A,C1FFC1,CCFFCC&chl=Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chtt=Food+and+Drink+Consumed+Christmas+2007&cht=p&chs=600x300&chd=s:KUIZFDPJF" alt="Where's Google?" />
<img src="${request.contextPath}/chart?chco=00AF33,4BB74C,EE2C2C,CC3232,33FF33,66FF66,9AFF9A,C1FFC1,CCFFCC&chl=Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chtt=Food+and+Drink+Consumed+Christmas+2007&cht=p&chs=600x300&chd=s:KUIZFDPJF" alt="Where's ${request.contextPath}?" />
<br><br>
<img src="http://chart.apis.google.com/chart?cht=bhg&chs=600x300&chd=s:KUIZFDPJF&chxt=x,y&chtt=Food+and+Drink+Consumed+Christmas+2007&chxl=1:|Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chco=00AF33" alt="Where's Google?" />
<img src="${request.contextPath}/chart?cht=bhg&chs=600x300&chd=s:KUIZFDPJF&chxt=x,y&chtt=Food+and+Drink+Consumed+Christmas+2007&chxl=1:|Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chco=00AF33" alt="Where's ${request.contextPath}?" />
<br><br>
<img src="http://chart.apis.google.com/chart?cht=bvg&chs=600x300&chd=s:KUIZFDPJF&chxt=x,y&chtt=Food+and+Drink+Consumed+Christmas+2007&chxl=0:|Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chco=00AF33" alt="Where's Google?" />
<img src="${request.contextPath}/chart?cht=bvg&chs=600x300&chd=s:KUIZFDPJF&chxt=x,y&chtt=Food+and+Drink+Consumed+Christmas+2007&chxl=0:|Egg+nog|Christmas+Ham|Milk+(not+including+egg+nog)|Cookies|Roast+Chestnuts|Chocolate|Various+Other+Beverages|Various+Other+Foods|Snacks&chco=00AF33" alt="Where's ${request.contextPath}?" />

</body>
</html>
