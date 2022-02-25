<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav aria-label="Navigation">
	<ul class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:list_go(1);">
				<i class="fas fa-angle-double-left"></i>
			</a>
		</li>
		<c:if test="${pageMaker.prev }">
		<li class="page-item">
			<a class="page-link" href="javascript:list_go(${pageMaker.startPage - 1});">
				<i class="fas fa-angle-left"></i>
			</a>
		</li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="i" >
		<li class="page-item ${pageMaker.cri.page == i ? 'active' : '' }">
			<a class="page-link" href="javascript:list_go(${i});">
				${i }
			</a>
		</li>	    						
		</c:forEach>
		<c:if test="${pageMaker.next }">
		<li class="page-item">
			<a class="page-link" href="javascript:list_go(${pageMaker.endPage + 1});">
				<i class="fas fa-angle-right"></i>
			</a>
		</li>
		</c:if>
		<li class="page-item">
			<a class="page-link" href="javascript:list_go(${pageMaker.realEndPage });">
				<i class="fas fa-angle-double-right"></i>
			</a>
		</li>
	</ul>
</nav>

<form id="listForm">
	<input type='hidden' name='page' value="" />
	<input type='hidden' name='perPageNum' value="" />
	<input type='hidden' name='searchKey' value="" />
	<input type='hidden' name='searchWord' value="" />
</form>

<script>
function list_go(page, url){
	
	console.log("list_go");
	
	if(!url) url="list";
	
	var listForm=$('#listForm');
	
	listForm.find("[name='page']").val(page);
	listForm.find("[name='perPageNum']").val($('select[name="perPageNum"]').val());
	listForm.find("[name='searchKey']").val($('select[name="searchKey"]').val());
	listForm.find("[name='searchWord']").val($('#inputSearch').val());
	
	listForm.attr({
		action:url,
		method:'get'
	}).submit();
}
</script>