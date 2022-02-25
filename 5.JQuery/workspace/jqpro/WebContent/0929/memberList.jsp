<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SqlMapClient client = SqlMapClientFactory.getInstance();
	List<MemberVO> list = client.queryForList("member.selectAllMember");
%>

[

<%
	for(int i = 0; i < list.size(); i ++){
		MemberVO memVO = list.get(i);
		if(i > 0) out.print(",");
%>
		{
			"id" : "<%= memVO.getMem_id() %>",
			"add1" : "<%= memVO.getMem_add1() %>",
			"add2" : "<%= memVO.getMem_add2() %>",
			"bir" : "<%= memVO.getMem_bir() %>",
			"hp" : "<%= memVO.getMem_hp() %>",
			"mail" : "<%= memVO.getMem_mail() %>",
			"name" : "<%= memVO.getMem_name() %>",
			"zip" : "<%= memVO.getMem_zip() %>"
		}		
<%	
	}
%>

]
