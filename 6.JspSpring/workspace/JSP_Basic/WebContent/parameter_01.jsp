<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style>
	body{
		background:<% out.print(request.getParameter("color")); %>;
	}
</style>

</head>
<body>
	<h1>parameter_01</h1>
	<p>배경색을 선택하세요</p>
	<button type="button" onclick="location.href='parameter_01.jsp?color=red';">빨간색</button>
	<button type="button" onclick="location.href='parameter_01.jsp?color=green';">초록색</button>
	<button type="button" onclick="location.href='parameter_01.jsp?color=yellow';">노란색</button>
<script>
	<% if(request.getParameter("color") != null){
		out.print("alert('"+request.getParameter("color")+"');");
	}%>
</script>
</body>
</html>