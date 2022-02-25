<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<BoardVO> list = (List<BoardVO>) request.getAttribute("list");
%>

[
	<%
		for(int i = 0; i < list.size(); i++){
			BoardVO bv = list.get(i);
			int num = bv.getNum();
			String writer = bv.getWriter();
			String subject = bv.getSubject();
			String mail = bv.getMail();
			int hit = bv.getHit();
			String wdate = bv.getWdate();
			String content = bv.getContent();
			
			if(i > 0){
				out.print(",");
			}
	%>
			{
				"num" : "<%=num %>",
				"writer" : "<%=writer %>",
				"subject" : "<%=subject %>",
				"mail" : "<%=mail %>",
				"hit" : "<%=hit %>",
				"wdate" : "<%=wdate %>",
				"content" : "<%=content.replaceAll("\r","").replaceAll("\n", "") %>"
			}
	<%
		}
	%>
]