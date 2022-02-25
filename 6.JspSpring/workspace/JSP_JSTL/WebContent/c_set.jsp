<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% pageContext.setAttribute("msg", "hello!"); %>

${msg}

<hr />

<c:set var="msg" value="hello~~~" scope="request" ></c:set>
${requestScope.msg}

<hr />
<c:remove var="msg" scope="page"/>
${msg}<br />
${requestScope.msg}
<hr/>

