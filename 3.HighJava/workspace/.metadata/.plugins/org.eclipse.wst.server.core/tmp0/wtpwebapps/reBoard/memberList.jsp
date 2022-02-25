<%@page import="org.eclipse.jdt.internal.compiler.ast.MemberValuePair"%>
<%@page import="kr.or.ddit.member.vo.PagingVO"%>
<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

		List<MemberDTO> list = (List<MemberDTO>) request.getAttribute("memberList");
	
		PagingVO pagingVO = (PagingVO) request.getAttribute("pagingVO");
		boolean isSearch = (boolean) request.getAttribute("isSearch");
		
		Integer curruntPageNo = (Integer) session.getAttribute("currentPageNo"); 

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<!--  jquery사용 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Insert title here</title>

<style>




div{
	display: flex;
	flex-direction: row;
}
.image{
	clear: both;
}
img{
	display: block;
	width: 250;
	height: 250;
}
.table{
	width : 800px;
}
.hidden{
	display: none;
}
input{
	outline : none;
}

</style>

</head>
<body>

<div class="header">
	<h1>회원관리</h1>
	<hr>
</div>


	<div id="search">
		<form method="post" action="search" class="form-inline">
			<input type="radio" name="searchTag" value="id" checked>아이디
			<input type="radio" name="searchTag" value="email">이메일
			<input type="radio" name="searchTag" value="phone">전화번호
			<input type="radio" name="searchTag" value="name">이름
			<div class="form-group" style="display:inline">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<label>검색 입력 : </label><input type="text" name="search">
			<input type="submit" value="검색" id="btnSearch">
			</div>
		</form>
		<input type="button" value="등록" id="btnRegister">

		<a href="${listUrl}"><input type="button" value="목록" id="btnList"></a>
	</div>

	<div class="article">
		<table class="table" id="memList">
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
			<% for(MemberDTO md : list){
				
				request.setAttribute("member", md);
				
				String status = "";
				if(md.getEnabled() == 0){
					status = "퇴사";
				}else if(md.getEnabled() == 1){
					status = "재직";
				}else if(md.getEnabled() == 2){
					status = "휴직";
				}
				
				request.setAttribute("status", status);
			%>
				<tr>
					<td><a href="${detailUrl}?id=${member.id}">${member.name}</a></td>
					<td>${member.id}</td>
					<td>${member.email}</td>
					<td>${member.phone}</td>
					<td>${status}</td>
				</tr>
			<% } %>
			</tbody>
		<% System.out.println("페이지네이션 시작"); %>
		<% if(pagingVO != null && !isSearch){ %>
		<% System.out.println("검색모드 아님"); %>
		<tfoot>
			<tr>
				<td colspan="11">
				<% if(curruntPageNo > pagingVO.getPageSize()){ %>
					<a href="${listUrl}?currentPageNo=${pagingVO.firstPageNo - pagingVO.pageSize}">이전</a>
				<% } %>
				<% for(int i = pagingVO.getFirstPageNo(); i <= pagingVO.getLastPageNo(); i++) { %>
					<a href="${listUrl}?currentPageNo=<%=i %>"><%=i %></a>
				<% } %>
				
				<% if(pagingVO.getLastPageNo() < pagingVO.getTotalPageCount()){ %>
					<a href="${listUrl}?currentPageNo=${pagingVO.firstPageNo + pagingVO.pageSize}">다음</a>
				<% } %>
				</td>
			</tr>
		</tfoot>
		<% }else if(pagingVO != null && isSearch){ %>
		<% System.out.println("검색모드"); %>
		<tfoot>
			<tr>
				<td colspan="11">
				<% if(curruntPageNo > pagingVO.getPageSize()){ %>
					<a href="${searchUrl}?currentPageNo=${pagingVO.firstPageNo - pagingVO.pageSize}
					&searchTag=${searchTag}&search=${search}">이전</a>
				<% } %>
				<% for(int i = pagingVO.getFirstPageNo(); i <= pagingVO.getLastPageNo(); i++) { %>
					<a href="${searchUrl}?currentPageNo=<%=i %>
					&searchTag=${searchTag}&search=${search}"><%=i %></a>
				<% } %>
				
				<% if(pagingVO.getLastPageNo() < pagingVO.getTotalPageCount()){ %>
					<a href="${searchUrl}?currentPageNo=${pagingVO.firstPageNo + pagingVO.pageSize}
					&searchTag=${searchTag}&search=${search}">다음</a>
				<% } %>
				</td>
			</tr>
		</tfoot>
		<% } %>
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


<script>
		window.onload = function(){
			
			let idValid = false;
			let pwValid = false;
			let phoneValid = false;
			let emailVaild = false;
			let nameValid = false;
			
			$('#idCheck').on('click', function(){
				
				let idVal = $('#id').val();
				
				$.ajax({
					url: "${idCheckUrl}",
					type: "get",
					data: { "id" : idVal},
					dataType: "json",
					success: function(res){
						console.log(res.flag);
						if(res.flag === "success"){
							$('#lblcheck').html("사용할 수 있는 아이디입니다");
							idValid = true;
						}else{
							$('#lblcheck').html("이미 사용중인 아이디입니다");
							idValid = false;
						}
					},
					error: function(xhr){
						console.log("status : " + xhr.status + "\ntext : " + xhr.statusText);
					}
				})
			})
			

			$('#btnRegister').on('click', function(){
				$('#btnSubmit').show();
				$('#btnCancle').show();
				$('#register').show();
				$('#memList').hide();
				$('#btnRegister').hide();
				$('#btnSearch').hide();
				$('#btnList').hide();
			})
			$('#btnCancle').on('click', function(){
				$('#btnSubmit').hide();
				$('#btnCancle').hide();
				$('#register').hide();
				$('#memList').show();
				$('#btnRegister').show();
				$('#btnSearch').show();
				$('#btnList').show();
			})
		
		$('#name').on('keyup', function(){
			let nameVal = $('#name').val();
			let nameReg = /^[가-힣]{2,5}$/;
			if(nameReg.test(nameVal)){
				$('#name').css("border","");
				nameValid = true;
				console.log("name");
				activeSubmit();
			}else{
				$('#name').css("border","4px solid red");
				nameValid = false;
			}
			if(nameVal == ""){
				$('#name').css("border","");
				nameValid = false;
			}
		})
		$('#pwd').on('keyup', function(){
			let pwdVal = $('#pwd').val();
			let pwdReg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,12}$/;
			if(pwdReg.test(pwdVal)){
				$('#pwd').css("border","");
				pwValid = true;
				console.log("pwd");
				activeSubmit();
			}else{
				$('#pwd').css("border","4px solid red");
				pwValid = false;
			}
			if(pwdVal == ""){
				$('#pwd').css("border","");
				pwValid = false;
			}
		})
		$('#id').on('keyup', function(){
			let idVal = $('#id').val();
			let idReg = /^([0-9a-zA-Z_-]).{4,20}$/;
			if(idReg.test(idVal)){
				$('#id').css("border","");
				console.log("id");
				activeSubmit();
			}else{
				$('#id').css("border","4px solid red");
				idValid = false;
			}
			if(idVal == ""){
				$('#id').css("border","");
				idValid = false;
			}
		})
		$('#email').on('keyup', function(){
			let emailVal = $('#email').val();
			let emailReg = /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			if(emailReg.test(emailVal)){
				$('#email').css("border","");
				emailVaild = true;
				console.log("email");
				activeSubmit();
			}else{
				$('#email').css("border","4px solid red");
				emailVaild = false;
			}
			if(emailVal == ""){
				$('#email').css("border","");
				emailVaild = false;
			}
		})
		$('#phone').on('keyup', function(){
			let phoneVal = $('#phone').val();
			let phoneReg = /\d{2,3}-?\d{3,4}-?\d{4}$/;
			if(phoneReg.test(phoneVal)){
				$('#phone').css("border","");
				phoneValid = true;
				console.log("phone");
				activeSubmit();
			}else{
				$('#phone').css("border","4px solid red");
				phoneValid = false;
			}
			if(phoneVal == ""){
				$('#phone').css("border","");
				phoneValid = false;
			}
		})
		
		
		
		function activeSubmit(){
			console.log(idValid, pwValid, phoneValid, emailVaild, nameValid);
			if(idValid && pwValid && phoneValid && emailVaild && nameValid){
				$('#btnSubmit').attr("disabled", false);
			}else{
				$('#btnSubmit').attr("disabled", true);
			}
		}
	}
		
</script>

</body>
</html>