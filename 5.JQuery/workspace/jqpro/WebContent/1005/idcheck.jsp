<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userId = (String)request.getAttribute("userId");
	String vailidId = userId != null ? "사용가능한 아이디입니다" : "사용불가능한 아이디입니다";
%>

{
	"vailidId" : "<%= vailidId %>"
}