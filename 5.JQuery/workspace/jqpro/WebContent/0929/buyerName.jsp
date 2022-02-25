<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
  SqlMapClient client = SqlMapClientFactory.getInstance();
	List<BuyerVO> list = client.queryForList("buyer.selectBuyerName");
%>

[
<%
	for(int i = 0; i < list.size(); i++){
		BuyerVO buyer = list.get(i);
		if(i > 0)	out.print(",");
%>
	{
		"id" : "<%= buyer.getBuyer_id() %>",
		"name" : "<%= buyer.getBuyer_name() %>"
	}
<% 
	}
%>
]