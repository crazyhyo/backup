<%@page import="org.eclipse.jdt.internal.compiler.ast.MemberValuePair"%>
<%@page import="kr.or.ddit.member.vo.PagingVO"%>
<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>

<div class="header">
	<h1 style="cursor:pointer;" onclick="location.href='/reBoard/list'">회원관리</h1>
	<hr>
</div>


	<div id="search">
		<form method="get" action="list" class="form-inline">
			
			<select name="searchKey" id="sltSearchTag" class="show">
				<option value=''>검색구분</option>
				<option value="id" >id</option>
				<option value="name" >이름</option>
				<option value="email" >이메일</option>
				<option value="phone" >전화번호</option>
			</select>
			<input type="text" name="searchWord" id="inputSearch" class="show">
			<div class="form-group" style="display:inline">
			<input type="submit" value="검색" id="btnSearch" class="show">
			</div>
		</form>
		<input type="button" value="등록" id="btnRegister" class="show">

		<a href="/reBoard/list"><input type="button" value="목록" id="btnList" class="show"></a>
	</div>

	<div class="article">
		<table class="table show" id="memList">
			<thead>
				<tr>
					<th>NAME</th>					
					<th>ID</th>
					<th>EMAIL</th>
					<th>PHONE</th>
					<th>ENABLED</th>
				</tr>
			</thead>
			<tbody>
            <c:forEach items="${members}" var="md">
	            <c:set var="member" value="${md}" />
	            <c:if test="${member.enabled eq 0}">
	                <c:set var="status" value="퇴사" />
	            </c:if>
	            <c:if test="${member.enabled eq 1}">
	                <c:set var="status" value="재직" />
	            </c:if>
	            <c:if test="${member.enabled eq 2}">
	                <c:set var="status" value="휴직" />
	            </c:if>
					<tr>
	                    <td><a href="/reBoard/detail?id=${member.id}&page=${page}">${member.name}</a></td>
						<td>${member.id}</td>
						<td>${member.email}</td>
						<td>${member.phone}</td>
						<td>${status}</td>
					</tr>
            </c:forEach>
			</tbody>
            <tfoot>
                <tr>
                    <td colspan="11">
                        <c:if test="${page gt pagingVO.pageSize}">
                        <a href="/reBoard/list?page=${pagingVO.firstPageNo - pagingVO.pageSize}&searchKey=${searchKey}&searchWord=${searchWord}">이전</a>
                        </c:if>
                        <c:forEach var="i" begin="${pagingVO.firstPageNo}" end="${pagingVO.lastPageNo}">
                        <c:choose>
	                        <c:when test="${page ne i }">
	                        	<a href="/reBoard/list?page=${i}&searchKey=${searchKey}&searchWord=${searchWord}">${i}</a>
	                        </c:when>
	                        <c:otherwise>
	                        	<a style="color:black" href="/reBoard/list?page=${i}&searchKey=${searchKey}&searchWord=${searchWord}">${i}</a>
	                        </c:otherwise>
                        </c:choose>
                        </c:forEach>
                        <c:if test="${pagingVO.lastPageNo lt pagingVO.totalPageCount}">
                        <a href="/reBoard/list?page=${pagingVO.firstPageNo + pagingVO.pageSize}&searchKey=${searchKey}&searchWord=${searchWord}">다음</a>
                        </c:if>
                    </td>
                </tr>
            </tfoot>
		</table>

		<form id="register" class="hidden" method="post" action="regist">
			<table class="table table-hover">
				<tr>
					<td class="gray">이름</td>
					<td colspan="3" class="spanned"><input type="text" name="name" id="name"></td>
				</tr>
				<tr>
					<td class="gray">아이디</td>
					<td class="data">
					<input type="text" name="id" value="" id="id" required>
					<input type="button" value="중복확인" id="idCheck"></td>
					<td class="gray">비밀번호</td>
					<td class="data"><input type="password" name="pwd" id="pwd" required></td>
				</tr>
				<tr>
					<td class="gray">권한</td>
					<td class="data">				
						<select name="authority" id="authority">
							<option value="ROLE_USER" selected>ROLE_USER</option>
							<option value="ROLE_ADMIN">ROLE_ADMIN</option>
						</select>
					</td>
					<td class="gray">등록자</td>
					<td class="data"><input type="text" name="register" value="mimi"></td>
				</tr>
				<tr>
					<td class="gray">주소</td>
					<td colspan="3" class="spanned"><input type="text" name="address" value=""></td>
				</tr>
				<tr>
					<td class="gray">입사일</td>
					<td class="data"><input type="date" name="regdate" value=""></td>
					<td class="gray">재직여부</td>
					<td class="data">
						<select name="enabled" id="enabled">
							<option value="0">퇴사</option>
							<option value="1" selected>재직</option>
							<option value="2">휴직</option>
						</select>						
					</td>
				</tr>
				<tr>
					<td class="gray">전화번호</td>
					<td colspan="3" class="spanned"><input type="text" name="phone" id="phone" value="" required></td>
				</tr>
				<tr>
					<td class="gray">이메일</td>
					<td colspan="3" class="spanned"><input type="text" name="email" id="email" value="" required></td>
				</tr>
			</table>
			<input type="submit" value="제출" id="btnSubmit" class="hidden" disabled>
			<input type="button" value="취소" id="btnCancle" class="hidden">
			<label id="lblcheck"></label>
		</form>			
</div>


</body>
