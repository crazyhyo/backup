<%@page import="kr.or.ddit.util.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<BoardVO> boardPagingList = (List<BoardVO>)request.getAttribute("boardPagingList");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
		<thead>
			<tr>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
				<td>신고수</td>
			</tr>
		</thead>
		<tbody>
		<% for(BoardVO vo : boardPagingList){ %>
			<tr>
				<td><a href="/Test/BoardDetail.do?boardNo=<%=vo.getBoardNo() %>"><%= vo.getTitle() %></a></td>
				<td><%= vo.getMemNm() %></td>
				<td><%= vo.getRegDate() %></td>
				<td><%= vo.getHit() %></td>
				<td><%= vo.getReport() %></td>
			</tr>
		<% } %>
		</tbody>
		
	</table>
</body>
</html>