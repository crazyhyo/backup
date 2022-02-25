<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
  table{
    border : 3px solid blue;
    border-collapse: collapse;
  }
  td{
    width: 200px;
    height: 50px;
    text-align: center;
  }
</style>
</head>
<body>
<h1>JSP : Java Server Page</h1>

<%
  String id = request.getParameter("id");
  String name = request.getParameter("name");
  String tel = request.getParameter("tel");
  String addr = request.getParameter("addr");
%>

<table>
  <tr>
    <td>id</td>
    <td><%= id %></td>
  </tr><tr>
    <td>name</td>
    <td><%= name %></td>
  </tr><tr>
    <td>tel</td>
    <td><%= tel %></td>
  </tr><tr>
    <td>addr</td>
    <td><%= addr %></td>
  </tr>
</table>
</body>
</html>
