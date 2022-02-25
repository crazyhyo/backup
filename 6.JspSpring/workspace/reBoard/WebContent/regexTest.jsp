<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
input{
	outline : none;
}

</style>

</head>
<body>
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
</body>
<script>

// 모든 조건이 만족했을 때만 버튼을 활성화 시키기 위해
// 각 정규식의 결과를 저장하는 배열
let testResults = [];

window.onload = function(){
	
	regexTestOn($('#name'), /^[가-힣]{2,5}$/);
	regexTestOn($('#pwd'), /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,12}$/);
	regexTestOn($('#email'), /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/);
	regexTestOn($('#phone'), /\d{2,3}-?\d{3,4}-?\d{4}$/);
	
	// id 중복을 검사하기 위한 원소를 추가한다.
	testResults.push(false);
	
}

// 정규식 검사를 추가한다
function regexTestOn(target, regex){
	// 정규식의 결과값을 담는 한 원소를 testResults에 추가한다. 
	let position = testResults.length;
	testResults.push(false);
	
	// 해당 원소는 keyup event가 일어날 때마다 정규식 검사결과를 저장한다
	target.on('keyup', function(){
		let value = target.val();
		let flag = regex.test(value);
		// 정규식 검사 결과에 따라 boarder에 css를 준다
		applyCss(target, flag);
		testResults[position] = flag;
		// 정규식이 거짓이면 제출버튼을 비활성화한다
		if(!flag)	$('#btnSubmit').attr("disabled", true);
		// 정규식이 참이면 제출버튼 활성화를 시도한다.
		if(flag)	activateButton();
	})
}

function applyCss(target, flag){
	// input tag가 비어있는 경우 border css를 제거한다
	if(target.val() == ""){
		target.css("border","");
		return;
	}
	if(flag)				target.css("border","");
	if(!flag)				target.css("border","3px solid red");
}

// testResults를 순회하며 모든 원소가 true이면 제출 버튼을 활성화한다.
function activateButton(){
	console.log("activateButton", testResults);
	for(let i = 0; i < testResults.length; i++){
		if(!testResults[i]) return;
	}
	$('#btnSubmit').attr("disabled", false);
}

// 아이디 중복검사
$('#idCheck').on('click', function(){
	
	let idVal = $('#id').val();
	
	$.ajax({
		url: "/reBoard/idCheck",
		type: "post",
		data: { "id" : idVal},
		dataType: "json",
		success: function(res){
			if(res.flag === "success"){
				testResults[testResults.length - 1] = true;
				activateButton();
				$('#lblcheck').html("사용할 수 있는 아이디입니다");
			}else{
				$('#lblcheck').html("이미 사용중인 아이디입니다");
				testResults[testResults.length - 1] = false;  
			}
		},
		error: function(xhr){
			console.log("status : " + xhr.status + "\ntext : " + xhr.statusText);
		}
	})
})

</script>
</html>