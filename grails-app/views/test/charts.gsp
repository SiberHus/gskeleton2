<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${request.contextPath} Chart Servlet Test Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>
This page contains a bunch of charts that we're using to test ${request.contextPath}:
<br><br>


<!-<img border="1" 
 src="${request.contextPath}/chart?
cht=bvs
&amp;chd=s:YUVmw1
&amp;chco=0000FF
&amp;chs=180x450
&amp;chtt=Site+visitors
&amp;chts=0000FF,20
&amp;chbh=10,4
" 

alt="Where's ${request.contextPath}?" />
-->

<img border="1" 
 src="${request.contextPath}/chart?
cht=bvg
&amp;chd=t:20|90|60|50|40|90|80|60|50|40
&amp;chxl=1:|Jan|July|Jan|July|Jan|Jan|July|Jan|July|Jan|
0:|0|100|200|300|600|700|800|900|1000|1100|0|100|200|300|600|700|800|900|1000|1100|
&amp;chxt=y,x
&amp;chs=500x300
&amp;chco=78AFA8,D5CD27,A2B180,C9512F,7A6656,D09B2C,324548,B8BFC6,63746D,715991,2790A6,D2232A
" 

alt="Where's ${request.contextPath}?" />

</body>
</html>