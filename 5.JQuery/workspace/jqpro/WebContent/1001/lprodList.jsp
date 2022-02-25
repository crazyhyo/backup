<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<LprodVO> lprodList = (List<LprodVO>)request.getAttribute("lprodList");
	int cnt = 0;

	for(LprodVO lprod : lprodList){
		String lprodGU = lprod.getLprod_gu();
		String lprodNM = lprod.getLprod_nm();
%>
		<option value="<%= lprodGU %>"><%= lprodNM %></option>
<%
	}
%>
