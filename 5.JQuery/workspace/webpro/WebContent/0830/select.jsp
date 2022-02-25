<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
</head>
<body>
<%
  String car1 = request.getParameter("car1");
  String[] car2 = request.getParameterValues("car2");
  
  String str = "선택한 값 : <br>";
  if(car1 != null) {
    //out.print(car1);
    str += car1; 
  }else if(car2 != null) {
    //car2.stream().out().print();
    //out.print(car2);
    for(String car : car2){
      str += car + "<br>";
    }
  }
%>

<div><%= str %></div>

</body>
</html>

