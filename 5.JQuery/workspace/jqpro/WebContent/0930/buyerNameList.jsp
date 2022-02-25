<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<BuyerVO> buyerNameList = (List<BuyerVO>) request.getAttribute("buyerNameList");

	for(BuyerVO buyer : buyerNameList){
%>
		<p id="<%= buyer.getBuyer_id() %>"><%= buyer.getBuyer_name()%></p>
<%		
	}
%>


