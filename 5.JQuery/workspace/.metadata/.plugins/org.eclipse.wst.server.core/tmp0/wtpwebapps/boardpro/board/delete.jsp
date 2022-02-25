<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	int result = (Integer)request.getAttribute("result");

	int totalPage = (Integer)request.getAttribute("totalPage");
	
	if(result > 0){
%>
	{
		"flag" : "success",
		"totalPage" : "<%=totalPage %>"
	}
<%
	}else{
%>
	{
		"flag" : "success",
		"totalPage" : "0"
	}
<%
	}
%>
