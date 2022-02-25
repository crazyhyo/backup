<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

<% 
	for(int dan = 2; dan <= 9; dan++){                  %>
	<h3><%=dan%>단</h3>
        <%
		for(int gop = 1; gop <= 9; gop++){
        %>
        <span><%=dan%> * <%=gop %> = <%=(dan * gop) %></span><br>
    	<%
		}
    	%>
    	<br>
<%
	}
%>

</body>
</html>
