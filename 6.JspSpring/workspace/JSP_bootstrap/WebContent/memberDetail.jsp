<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
		<div>
			<h1>회원관리 카드</h1>
			<hr>
		</div>
		
		<div>
			<div>
				<table class="table table-sm show" id="memDetail">
					<tr>
						<td>이름</td>
						<td colspan="3">${member.name}</td>
					</tr>
					<tr>
						<td>아이디</td>
						<td>${member.id}</td>
						<td>비밀번호</td>
						<td>${member.pwd}</td>
					</tr>
					<tr>
						<td>권한</td>
						<td>${member.authority}</td>
						<td>등록자</td>
						<td>${member.register}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td colspan="3">${member.address}</td>
					</tr>
					<tr>
						<td>입사일</td>
						<td>${member.regdate}</td>
						<td>재직여부</td>
						<td>${status}</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td colspan="3">${member.phone}</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td colspan="3">${member.email}</td>
					</tr>
				</table>
		
				<form id="update" class="hidden" method="post" action="modify">
					<table class="table table-sm">
						<tr>
							<td>이름</td>
							<td colspan="3"><input type="text" name="name" id="name" value="${member.name}"></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input type="text" name="id" value="${member.id}" id="id" readonly required></td>
							<td>비밀번호</td>
							<td><input type="password" name="pwd" id="pwd" value="${member.pwd}"required></td>
						</tr>
						<tr>
							<td>권한</td>
							<td>				
								<select name="authority" id="authority">
									<option value="ROLE_USER" selected>ROLE_USER</option>
									<option value="ROLE_ADMIN">ROLE_ADMIN</option>
								</select>
							</td>
							<td>등록자</td>
							<td><input type="text" name="register" value="${member.register}" readonly></td>
						</tr>
						<tr>
							<td>주소</td>
							<td colspan="3"><input type="text" name="address" value="${member.address}"></td>
						</tr>
						<tr>
							<td>입사일</td>
							<td><input type="date" name="regdate"></td>
							<td>재직여부</td>
							<td>
								<select name="enabled" id="enabled">
									<option value="0">퇴사</option>
									<option value="1" selected>재직</option>
									<option value="2">휴직</option>
								</select>						
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td colspan="3"><input type="text" name="phone" id="phone" value="${member.phone}" required></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td colspan="3"><input type="text" name="email" id="email" value="${member.email}" required></td>
						</tr>
					</table>
					<div class="row">
						<div class="form-group col-sm-1">
							<input type="submit" value="제출" id="btnSubmit" class="form-control hidden">
						</div>
						<div class="form-group col-sm-1">
							<input type="button" value="취소" id="btnCancle" class="form-control hidden" onclick="hideUpdateForm()">
						</div>
				    </div>
				</form>			
			</div>
		</div>
		<div class="row">
			<div class="form-group col-sm-1">
				<input type="button" value="수정" id="btnUpdate" class="form-control show" onclick="showUpdateForm()">
			</div>
			<div class="form-group col-sm-1">
			<form method="post" action="remove">
				<input type="hidden" value="${member.id}" name="id">
				<input type="submit" value="삭제" id="btnDelete" class="form-control show">
			</form>
			</div>
			<div class="form-group col-sm-1">
				<input type="button" value="목록" id="btnList" onclick="location.href='/JSP_bootstrap/list?page=${page}'" class="form-control">      
			</div>   
	    </div>	
      </div>
     </div>
   </div>
<script>
//모든 조건이 만족했을 때만 버튼을 활성화 시키기 위해
//각 정규식의 결과를 저장하는 배열
let testResults = [];

window.onload = function(){
	
	// 버튼 이벤트 등록
	$('#btnRegister').on('click', toggle);
	$('#btnUpdate').on('click', toggle);
	$('#btnCancle').on('click', toggle);
	
	// 정규식 검사 이벤트 등록
	regexTestOn($('#name'), 	/^[가-힣]{2,5}$/);
	regexTestOn($('#pwd'), 		/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,12}$/);
	regexTestOn($('#email'), 	/^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/);
	regexTestOn($('#phone'), 	/\d{2,3}-?\d{3,4}-?\d{4}$/);
	
	// id 중복을 검사하기 위한 원소를 추가한다.
	testResults.push(false);
	
	//아이디 중복검사
	$('#idCheck').on('click', idCheck);
	
	
}

// 아이디 중복체크
function idCheck(){
	let idVal = $('#id').val();
	
	$.ajax({
		url: "/JSP_bootstrap/idCheck",
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
}

//정규식 검사를 추가한다
function regexTestOn(target, regex){
	// 정규식의 결과값을 담는 한 원소를 testResults에 추가한다. 
	let position = testResults.length;
	testResults.push(false);
	
	// 해당 원소는 keyup event가 일어날 때마다 정규식 검사결과를 저장한다
	target.on('keyup', function(){
		let value 	= target.val();
		let flag 	= regex.test(value);
		// 정규식 검사 결과에 따라 border에 css를 준다
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

//testResults를 순회하며 모든 원소가 true이면 제출 버튼을 활성화한다.
function activateButton(){
	for(let i = 0; i < testResults.length; i++){
		if(!testResults[i]) return;
	}
	$('#btnSubmit').attr("disabled", false);
}

function toggle(){
	console.log("toggle");
	
	const toggles = document.querySelectorAll('.toggle');
	const shows = document.querySelectorAll('.show');
	console.log(hiddens);
	console.log(shows);
	shows.forEach(function(element){
		element.classList.remove('show');
		element.classList.add('hidden');
	})
	hiddens.forEach(function(element){
		element.classList.remove('hidden');
		element.classList.add('show');
	})	
}
		
</script>
</body>
