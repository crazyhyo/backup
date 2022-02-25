<%@page import="kr.or.ddit.board.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		List<ReplyVO> list = (List<ReplyVO>)request.getAttribute("list");

		if(list == null){
			System.out.println("null this");
%>
[
			{
				"renum" : "aaa",
				"cont" : "aaa",
				"name" : "aaa",
				"redate" : "aaa",
				"bonum" : "aaa"
			}
]
<%

		}else{
%>

[

	<%
		for(int i = 0; i<list.size(); i++){
			ReplyVO vo = list.get(i);
			if(i > 0) out.print(",");
%>
			{
				"renum" : "<%=vo.getRenum() %>",
				"cont" : "<%=vo.getCont().replaceAll("\r","").replaceAll("\n","<br>") %>",
				"name" : "<%=vo.getName() %>",
				"redate" : "<%=vo.getRedate() %>",
				"bonum" : "<%=vo.getBonum() %>"
			}
<%
		}
%>
]

<% }%>