<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProdVO> prodList = (List<ProdVO>)request.getAttribute("prodList");
	int cnt = 0;
	if(prodList != null && prodList.size() > 0) {
%>
	{
		"flag" : "true",
		"datas" : 
			[
<%
			for (ProdVO prod : prodList) {
			String prodName = prod.getProd_name();
			String prodId = prod.getProd_id();
			
			if(cnt > 0) out.print(",");
%>
					{
							"id" : "<%=prodId%>",
							"nm" : "<%=prodName%>"
					}

<%
	cnt++;
		}
%>
		]
	}
<%
	}else{
%>
	{
		"flag" : "false"
	}
<%
	}
%>
