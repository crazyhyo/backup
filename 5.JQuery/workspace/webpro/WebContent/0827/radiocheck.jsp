<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<style>
table{
	border : 1px solid hotpink;
	margin : 50px;
}
td{
	width : 150px;
	height : 20px;
	text-align : center;
}
</style>
</head>
<body>
<%

  request.setCharacterEncoding("UTF-8");

  String sid = request.getParameter("id");
  String sname = request.getParameter("name");
  String saddr = request.getParameter("addr");
  String sgender = request.getParameter("gender");
  String[] sfood = request.getParameterValues("food");
  String str = "";
  for(int i = 0; i < sfood.length; i++){
    str += sfood[i] + "&nbsp;&nbsp";
  }
%>
<table border="1">
  <tr>
    <td>id</td>
    <td><%= sid %></td>
  </tr>
  <tr>
    <td>name</td>
    <td><%= sname %></td>
  </tr>
  <tr>
    <td>addr</td>
    <td><%= saddr %></td>
  </tr>
  <tr>
    <td>gender</td>
    <td><%= sgender %></td>
  </tr>
  <tr>
    <td>sfood</td>
    <td><%= str %></td>
  </tr>
</table>
</body>
</html>

