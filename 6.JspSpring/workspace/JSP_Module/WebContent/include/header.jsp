<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><decorator:title default="decorator title" /></title>

<decorator:head />

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" />

</head>
<body>

  <div style="max-width:1280px; height:100%; margin:0 auto;">
<div id="header">
  <h1>header 입니다.</h1>
</div>
