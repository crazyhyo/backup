<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
  SqlMapClient client = SqlMapClientFactory.getInstance();

  String buyerId = request.getParameter("id");
	BuyerVO buyer = (BuyerVO)client.queryForObject("buyer.selectBuyerDetail", buyerId);
%>

[

	{
		"id" : "<%= buyer.getBuyer_id() %>",
		"name" : "<%= buyer.getBuyer_name() %>",
    "add1" : "<%= buyer.getBuyer_add1() %>",
    "add2" : "<%= buyer.getBuyer_add2() %>",
    "zip" : "<%= buyer.getBuyer_zip() %>",
    "bank" : "<%= buyer.getBuyer_bank() %>",
    "bankName" : "<%= buyer.getBuyer_bankname() %>",
    "bankNo" : "<%= buyer.getBuyer_bankno() %>",
    "charger" : "<%= buyer.getBuyer_charger() %>",
    "comtel" : "<%= buyer.getBuyer_comtel() %>",
    "fax" : "<%= buyer.getBuyer_fax() %>",
    "lgu" : "<%= buyer.getBuyer_lgu() %>",
    "mail" : "<%= buyer.getBuyer_mail() %>",
    "telext" : "<%= buyer.getBuyer_telext() %>"
	}

]