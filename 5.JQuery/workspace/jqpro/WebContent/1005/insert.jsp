<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		String mem_id = request.getAttribute("mem_id") == null?
				null : (String)request.getAttribute("mem_id");
		
		System.out.println(mem_id);
		
		String msg = request.getAttribute("mem_id") == null?
				"가입실패" : "가입성공";
%>
{
	"flag" : "<%=msg %>"
}