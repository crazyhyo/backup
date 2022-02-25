<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BuyerVO buyer = (BuyerVO) request.getAttribute("buyer");
%>
<table border='1'>

	<tr>
		<td>id </td>
		<td><%= buyer.getBuyer_id() %></td>
	</tr>

	<tr>
		<td>name </td>
		<td><%= buyer.getBuyer_name() %></td>
	</tr>

	<tr>
		<td>add1 </td>
		<td><%= buyer.getBuyer_add1() %></td>
	</tr>

	<tr>
		<td>add2 </td>
		<td><%= buyer.getBuyer_add2() %></td>
	</tr>

	<tr>
		<td>zip </td>
		<td><%= buyer.getBuyer_zip() %></td>
	</tr>

	<tr>
		<td>bank </td>
		<td><%= buyer.getBuyer_bank() %></td>
	</tr>

	<tr>
		<td>bankName </td>
		<td><%= buyer.getBuyer_bankname() %></td>
	</tr>

	<tr>
		<td>bankNo </td>
		<td><%= buyer.getBuyer_bankno() %></td>
	</tr>

	<tr>
		<td>charger </td>
		<td><%= buyer.getBuyer_charger() %></td>
	</tr>

	<tr>
		<td>comtel </td>
		<td><%= buyer.getBuyer_comtel() %></td>
	</tr>

	<tr>
		<td>fax </td>
		<td><%= buyer.getBuyer_fax() %></td>
	</tr>

	<tr>
		<td>lgu </td>
		<td><%= buyer.getBuyer_lgu() %></td>
	</tr>

	<tr>
		<td>mail </td>
		<td><%= buyer.getBuyer_mail() %></td>
	</tr>

	<tr>
		<td>telext </td>
		<td><%= buyer.getBuyer_telext() %></td>
	</tr>

</table>
