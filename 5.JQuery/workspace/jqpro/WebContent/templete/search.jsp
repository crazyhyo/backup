<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	SqlMapClient client = SqlMapClientFactory.getInstance();
	BuyerVO buyer = (BuyerVO) client.queryForObject("buyer.selectBuyerDetail", request.getAttribute("sendId"));
%>

<p><%= buyer.getBuyer_id() %></p>