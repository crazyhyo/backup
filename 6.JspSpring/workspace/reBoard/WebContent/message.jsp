<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    <c:choose>
        <c:when test="${flag eq 'success'}">
            alert("${commandName} 요청에 성공하셨습니다");
            location.href = "${successUrl}";
        </c:when>

        <c:when test="${flag eq 'fail'}">
            alert("${commandName} 요청에 실패하셨습니다");
            location.href = "${failUrl}";
        </c:when>
    </c:choose>
</script>
