<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>

<div class="header">
	<h1>회원관리 카드</h1>
	<hr>
</div>

<div class="section">
	<div class="article">
		<table class="table table-hover show" id="memDetail">
			<tr>
				<td class="gray">이름</td>
				<td colspan="3" class="spanned">${member.name}</td>
			</tr>
			<tr>
				<td class="gray">아이디</td>
				<td class="data">${member.id}</td>
				<td class="gray">비밀번호</td>
				<td class="data">${member.pwd}</td>
			</tr>
			<tr>
				<td class="gray">권한</td>
				<td class="data">${member.authority}</td>
				<td class="gray">등록자</td>
				<td class="data">${member.register}</td>
			</tr>
			<tr>
				<td class="gray">주소</td>
				<td colspan="3" class="spanned">${member.address}</td>
			</tr>
			<tr>
				<td class="gray">입사일</td>
				<td class="data">${member.regdate}</td>
				<td class="gray">재직여부</td>
				<td class="data">${status}</td>
			</tr>
			<tr>
				<td class="gray">전화번호</td>
				<td colspan="3" class="spanned">${member.phone}</td>
			</tr>
			<tr>
				<td class="gray">이메일</td>
				<td colspan="3" class="spanned">${member.email}</td>
			</tr>
		</table>

		<form id="update" class="hidden" method="post" action="update">
			<table class="table table-hover">
				<tr>
					<td class="gray">이름</td>
					<td colspan="3" class="spanned"><input type="text" name="name" id="name" value="${member.name}"></td>
				</tr>
				<tr>
					<td class="gray">아이디</td>
					<td class="data"><input type="text" name="id" value="${member.id}" id="id" readonly required></td>
					<td class="gray">비밀번호</td>
					<td class="data"><input type="password" name="pwd" id="pwd" value="${member.pwd}"required></td>
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
					<td class="data"><input type="text" name="register" value="${member.register}" readonly></td>
				</tr>
				<tr>
					<td class="gray">주소</td>
					<td colspan="3" class="spanned"><input type="text" name="address" value="${member.address}"></td>
				</tr>
				<tr>
					<td class="gray">입사일</td>
					<td class="data"><input type="date" name="regdate"></td>
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
					<td colspan="3" class="spanned"><input type="text" name="phone" id="phone" value="${member.phone}" required></td>
				</tr>
				<tr>
					<td class="gray">이메일</td>
					<td colspan="3" class="spanned"><input type="text" name="email" id="email" value="${member.email}" required></td>
				</tr>
			</table>
			<input type="submit" value="제출" id="btnSubmit" class="hidden">
			<input type="button" value="취소" id="btnCancle" class="hidden">
		</form>			
	</div>
</div>
<input type="button" value="수정" id="btnUpdate" class="show">
<form method="post" action="delete">
	<input type="hidden" value="${member.id}" name="id">
	<input type="submit" value="삭제" id="btnDelete" class="show">
</form>
<a href="/reBoard/list?page=${page}"><input type="button" value="목록" id="btnList"></a>

</body>