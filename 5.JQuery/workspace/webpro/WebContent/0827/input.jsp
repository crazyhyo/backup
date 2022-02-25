<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	<h1>JSP : Java Server Page</h1>
	server내에서 실행되는 자바 프로그램을 포함한 스크립트 언어<br>
	클라이언트 요청시 데이터를 받는다 : request.getParameter("name")<br>
	<%
		String inputMail = request.getParameter("email");
		String inputUrl = request.getParameter("url");
		String inputTel = request.getParameter("tel");
		String inputColor = request.getParameter("color");
		String inputMonth = request.getParameter("month");
		String inputDate = request.getParameter("date");
		String inputWeek = request.getParameter("week");
		String inputTime = request.getParameter("time");
		String inputLocalDateTime = request.getParameter("localdatetime");
		int inputNumber = Integer.parseInt(request.getParameter("number"));
		String inputRange = request.getParameter("range");
    String inputPass = request.getParameter("pass");
    String inputFile = request.getParameter("file");
	%>
	
	<table border="1">
		<tr>
			<td>항목</td>
			<td>값</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%= inputMail %></td>
		</tr>
		<tr>
			<td>URL</td>
			<td><%= inputUrl %></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%= inputTel %></td>
		</tr>
		<tr>
			<td>색상</td>
			<td><%= inputColor %></td>
		</tr>
		<tr>
			<td>월</td>
			<td><%= inputMonth %></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%= inputDate %></td>
		</tr>
		<tr>
			<td>주</td>
			<td><%= inputWeek %></td>
		</tr>
		<tr>
			<td>시간</td>
			<td><%= inputTime %></td>
		</tr>
		<tr>
			<td>지역 시간</td>
			<td><%= inputLocalDateTime %></td>
		</tr>
		<tr>
			<td>숫자</td>
			<td><%= inputNumber %></td>
		</tr>
		<tr>
			<td>범위</td>
			<td><%= inputRange %></td>
		</tr>
		<tr>
			<td>pass</td>
			<td><%= inputPass %></td>
		</tr>
		<tr>
			<td>file</td>
			<td><%= inputFile %></td>
		</tr>
	</table>
</body>
</html>
