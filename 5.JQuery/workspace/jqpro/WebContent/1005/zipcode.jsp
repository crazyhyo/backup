<%@page import="kr.or.ddit.member.vo.ZipVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		List<ZipVO> list =(List<ZipVO>)request.getAttribute("zipList");
%>
[
	<%
		int cnt = 0;
		for(ZipVO vo : list){
			if(cnt > 0){
				out.print(",");
			}
			String bunji = vo.getBunji() == null ? "" : vo.getBunji();
	%>
			{
				"zipcode": "<%=vo.getZipcode()%>",
				"addr"   : "<%=vo.getSido()%><%=vo.getGugun()%><%=vo.getDong()%>",
				"bunji"  : "<%=bunji%>"
			}
	<%
			cnt++;
		}
	%>
]