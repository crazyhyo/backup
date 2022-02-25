<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.ibatis.config.SqlMapClientFactory"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <table border="1">
    <tr>
      <th>name</th>
      <th>value</th>
    </tr>

    <%
      SqlMapClient client = SqlMapClientFactory.getInstance();
    	List<BuyerVO> list = client.queryForList("buyer.selectBuyerName");
    	
    	String names = "";
    	int size = list.size();
    	
    	for(BuyerVO buyer : list){
				names += "<p id='"+buyer.getBuyer_id()+"' class='pp'>" + buyer.getBuyer_name() + "</p>";
    	}
    %>
    <tr>
      <td><%= names %></td>
      <td></td>
    </tr>

  </table>
