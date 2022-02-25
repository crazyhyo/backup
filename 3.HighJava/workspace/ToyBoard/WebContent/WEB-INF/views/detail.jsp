<%@page import="java.util.Date"%>
<%@page import="kr.or.ddit.jdbcBoard.vo.JdbcBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	JdbcBoardVO board = (JdbcBoardVO)request.getAttribute("board");
	
	int board_no = board.getBoard_no();
	String board_title = board.getBoard_title();
	String board_writer = board.getBoard_writer();
	Date board_date = board.getBoard_date();
	String board_content = board.getBoard_content();
	
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>detail</title>

<script>
	window.onload = function(){
		
		let btnUpdate = document.querySelector("#btnUpdate");
		let btnDelete = document.querySelector("#btnDelete");
		let btnList = document.querySelector("#btnList");

		btnList.addEventListener("click",function(){
			location.href="boardlist.do";
		})
		btnUpdate.addEventListener("click",function(){
			location.href="update.do";
		})
		btnDelete.addEventListener("click",function(){
			
			if(confirm('정말 삭제하시겠습니까?')){
				location.href="delete.do?board_no=<%=board_no%>";
			}
		})
	}
</script>

</head>
<body>
	<table border="1">
		<tr>
			<td>제목</td>
			<td><%= board_title %></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%= board_writer %></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%= board_date %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%= board_content %></td>
		</tr>
	</table>
	
	<input type="button" value="목록" id="btnList" name="btnList"></input>
	<input type="button" value="수정" id="btnUpdate" name="btnUpdate"></input>
	<input type="button" value="삭제" id="btnDelete" name="btnDelete"></input>
	
</body>
</html>