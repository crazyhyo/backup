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
	width : 250px;
	height : 50px;
	text-align : center;
}
  #info{
    height : 200px;
  }
</style>
</head>
<body>
  JSP : 클라이언트에서 전송시 데이터를 전달받는다.
<%

  request.setCharacterEncoding("UTF-8");

  String sid = request.getParameter("id");
  String sname = request.getParameter("name");
  String saddr = request.getParameter("addr");
  String sgender = request.getParameter("gender");
  String[] sfood = request.getParameterValues("food");
  String str = "";
  if(sfood != null){
    for(int i = 0; i < sfood.length; i++){
      str += sfood[i] + "&nbsp;&nbsp";
    }
    }else{
    str = "선택안함";
    }
  String sarea = request.getParameter("area");
  // sarea속에는 엔터기호(\r\n)를 포함하고 있다
  // 엔터기호를 <br>태그로 변경한다
  sarea = sarea.replaceAll("\r","").replaceAll("\n","<br>");
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
  <tr>
    <td id="info" colspan="2"><%= sarea %></td>
  </tr>
</table>
</body>
</html>

