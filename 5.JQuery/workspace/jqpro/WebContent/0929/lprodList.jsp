<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	SqlMapClient client = SqlMapClientFactory.getInstance();
	List<LprodVO> list = client.queryForList("lprod.selectAllLItem");
%>

[
<%
	for(int i = 0; i < list.size(); i++){
		if(i > 0) out.print(",");
		LprodVO lprodVo = list.get(i);
%>
		{
			"lprod_id" : "<%= lprodVo.getLprod_id() %>",
			"lprod_gu" : "<%= lprodVo.getLprod_gu() %>",
			"lprod_nm" : "<%= lprodVo.getLprod_nm() %>"
		}		
<%
	}
%>
]