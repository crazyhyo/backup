<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProdVO prod = (ProdVO)request.getAttribute("prod");

	
	String prodId = prod.getProd_id();
	String prodName = prod.getProd_name();
	String prodLGU = prod.getProd_lgu();
	String prodBuyer = prod.getProd_buyer();
	int prodCost = prod.getProd_cost();
	int prodPrice = prod.getProd_price();
	int prodSale = prod.getProd_sale();
	String prodSize = prod.getProd_size();
	String prodColor = prod.getProd_color(); 
	
%>
{
		"prod" : "<%=prodId %>",
		"prodName" : "<%=prodName %>",
		"prodLGU" : "<%=prodLGU %>",
		"prodBuyer" : "<%=prodBuyer %>",
		"prodCost" : "<%=prodCost %>",
		"prodPrice" : "<%=prodPrice %>",
		"prodSale" : "<%=prodSale %>",
		"prodSize" : "<%=prodSize %>",
		"prodColor" : "<%=prodColor %>"
}