<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  
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
.table {
	border-collapse: collapse;

	width: 600px;
	height: 400px;
	text-align: center;
}  
.table th {
	text-align: center;
}
.table th, .table td {
	padding: 10px;
	border: 1px solid #ddd;
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
	<h1>회원관리 카드</h1>
	<hr>
</div>

<div class="section">
	<div class="article">
		<table class="table table-hover" id="memDetail">
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

		<form id="update" class="hidden" method="post" action="${updateUrl}">
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
<input type="button" value="수정" id="btnUpdate">
<form method="post" action="${deleteUrl}">
	<input type="hidden" value="${member.id}" name="id">
	<input type="submit" value="삭제" id="btnDelete">
</form>
<a href="${listUrl}?currentPageNo=${currentPageNo}"><input type="button" value="목록" id="btnList"></a>

<script>

		window.onload = function(){
			let idValid = true;
			let pwValid = true;
			let phoneValid = true;
			let emailVaild = true;
			let nameValid = true;
			
			$('#btnUpdate').on('click', function(){
				$('#btnSubmit').show();
				$('#btnCancle').show();
				$('#memDetail').hide();
				$('#update').show();
				$('#btnUpdate').hide();
				$('#btnDelete').hide();
			})
			$('#btnCancle').on('click', function(){
				$('#btnSubmit').hide();
				$('#btnCancle').hide();
				$('#update').hide();
				$('#memDetail').show();
				$('#btnUpdate').show();
				$('#btnDelete').show();
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
					idValid = true;
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