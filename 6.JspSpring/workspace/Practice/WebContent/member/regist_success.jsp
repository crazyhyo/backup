<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<body>
<script>
	alert("회원 등록에 성공하셨습니다.");
	opener.location.href = "<%=request.getContextPath()%>/member/list?page=1";
window.onload = function(){
	CloseWindow();
}
</script>
</body>