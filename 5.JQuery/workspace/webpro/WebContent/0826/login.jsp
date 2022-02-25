<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#pid{
	font-size : 1.5em;
	color : blue;
}
</style>
</head>
<body>
<h1> JSP : Java Server Page</h1>
<p>서버내에서 실행되는 프로그램</p>
<p>html기반에서 java언어를 이용해서 기술한다</p>
<p>자바 언어를 기술시 &lt;% &nbsp;&nbsp; String str = "asdf"; &nbsp;&nbsp; %&gt; 기호 사이에 자바코드를 기술한다</p>
<p>자바변수를 출력할때는 &lt;%= str %&gt; 기호 사이에 변수명을 기술한다.</p>

<%
	String userId = request.getParameter("id");
	String userPass = request.getParameter("pass");
%>

<p id="pid"><%= userId %>님 환영합니다</p>
<p><%= userPass %></p>


</body>
</html>