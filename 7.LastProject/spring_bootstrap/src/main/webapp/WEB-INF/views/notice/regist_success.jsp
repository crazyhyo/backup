<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>



<body>
<script>
	alert("공지등록에 성공했습니다.\n 공지리스트 페이지로 이동합니다.");
	
	window.opener.location.href="<%=request.getContextPath()%>/notice/list.do";
window.onload = function(){
	CloseWindow();
}
</script>

</body>