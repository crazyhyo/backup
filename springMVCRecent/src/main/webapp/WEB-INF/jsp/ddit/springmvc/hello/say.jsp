<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SPRING MVC HELLO TEST</title>
</head>
<body>
	${name}님 ${now}에 접속 요청하셨습니다.
	<br/>
	<form action="helloForm.do" method="get">
		이름: <input type="text" name="name"><br/>
<!-- 		페이지번호: <input type="text" name="pageNo"><br/> -->
		<button type="submit">GET 방식전송</button>
	</form>
	<br/>
	<form action="helloForm.do" method="post">
<!-- 	     이름: <input type="text" name="name"><br/> -->
	     페이지번호: <input type="text" name="pageNo"><br/>
		<button type="submit">POST 방식전송</button>
	</form>
</body>
</html>