<%@page import="org.eclipse.jdt.internal.compiler.ast.MemberValuePair"%>
<%@page import="kr.or.ddit.member.vo.PagingVO"%>
<%@page import="kr.or.ddit.member.vo.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="members" value="${dataMap.members }" />
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:if test="${pageMaker.cri.page * pageMaker.cri.perPageNum > pageMaker.totalCount}">
<c:set var="endRecord" value="${pageMaker.totalCount }" />
</c:if>
<c:if test="${pageMaker.cri.page * pageMaker.cri.perPageNum <= pageMaker.totalCount}">
<c:set var="endRecord" value="${pageMaker.cri.page * pageMaker.cri.perPageNum }" />
</c:if>

<body>
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
		      	
		<div>
			<h1 style="cursor:pointer;" onclick="location.href='/JSP_bootstrap/list'">회원관리</h1>
			<hr>
		</div>
		<div class="row">
			<select class="form-control col-sm-2" name="perPageNum"
				id="perPageNum" onchange="list_go(1);">
				<option value="10">정렬개수</option>
				<option value="2"
					${pageMaker.cri.perPageNum == 2 ? 'selected' : '' }>2개씩</option>
				<option value="3"
					${pageMaker.cri.perPageNum == 3 ? 'selected' : '' }>3개씩</option>
				<option value="5"
					${pageMaker.cri.perPageNum == 5 ? 'selected' : '' }>5개씩</option>
			</select>
			<div class="form-group col-sm-2">
			<select name="searchKey" id="sltSearchTag" class="form-control toggle">
				<option value=''>검색구분</option>
				<option value="id" 
						${pageMaker.cri.searchKey == 'id' ? 'selected' :  ''}>id</option>
				<option value="name" 
						${pageMaker.cri.searchKey == 'name' ? 'selected' :  ''}>이름</option>
				<option value="email" 
						${pageMaker.cri.searchKey == 'email' ? 'selected' :  ''}>이메일</option>
				<option value="phone" 
						${pageMaker.cri.searchKey == 'phone' ? 'selected' :  ''}>전화번호</option>
			</select>
	        </div>
			<div class="form-group col-sm-3">
				<input type="text" class="form-control toggle" name="searchWord"  id="inputSearch"
						value="${pageMaker.cri.searchWord == null ? '' :  pageMaker.cri.searchWord}">
	        </div>
	        <div style="display:inline" class="col-md-1">
				<input type="submit" value="검색" id="btnSearch" class="btn btn-primary toggle" 
						onclick="list_go(1);">
			</div>
        </div>	
		
		
		<div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title" style="cursor:pointer;" onclick="location.href='/JSP_bootstrap/list'">회원관리</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
              	<label>총 ${pageMaker.totalCount } 중 ${endRecord - pageMaker.cri.perPageNum + 1}/${endRecord }</label>
                <table class="table table-sm toggle">
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
		            <c:forEach items="${members}" var="member">
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
			               <!--     <td><a href="/JSP_bootstrap/detail?id=${member.id}&page=${page}">${member.name}</a></td>  -->
			                    <td><a href="javascript:detail_go('${member.id }', '${pageMaker.cri.page }')">${member.name}</a></td>
								<td>${member.id}</td>
								<td>${member.email}</td>
								<td>${member.phone}</td>
								<td>${status}</td>
							</tr>
		            </c:forEach>
					</tbody>
                </table>
				<form id="detailForm">
					<input type='hidden' name='page' value="" />
					<input type='hidden' name='id' value="" />
				</form>
				<script>
					function detail_go(id, page){
						if(!page) page = 1;
						
						var detailForm = $('#detailForm');
						detailForm.find("[name='page']").val(page);
						detailForm.find("[name='id']").val(id);
						
						detailForm.attr({
							action:'detail',
							method:'get'
						}).submit();
					}
				</script>
				
               	<div class="card-footer">
	    			<%@ include file="/common/pagination.jsp" %>
	    		</div>
                
                <form id="register" class="toggle hidden" method="post" action="regist">
					<table class="table table-sm">
						<tr>
							<td>이름</td>
							<td colspan="3"><input type="text" name="name" id="name"></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td>
							<input type="text" name="id" value="" id="id" required>
							<input type="button" value="중복확인" id="idCheck"></td>
							<td>비밀번호</td>
							<td><input type="password" name="pwd" id="pwd" required></td>
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
							<td><input type="text" name="register" value="mimi"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td colspan="3"><input type="text" name="address" value=""></td>
						</tr>
						<tr>
							<td>입사일</td>
							<td><input type="date" name="regdate" value=""></td>
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
							<td colspan="3"><input type="text" name="phone" id="phone" value="" required></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td colspan="3"><input type="text" name="email" id="email" value="" required></td>
						</tr>
					</table>
					
					<input type="submit" value="제출" id="btnSubmit" class="btn btn-primary toggle hidden btn-foot" disabled >
					<input type="button" value="취소" id="btnCancle" class="btn btn-primary toggle hidden btn-foot" onclick="hideRegisterForm()">
					<label id="lblcheck"></label>
				</form>
                
                
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
        </div>
		
		<div class="row">
			<input type="button" value="등록" id="btnRegister" class="toggle btn btn-primary btn-foot" onclick="showRegisterForm()">
			<button type="button" value="목록" id="btnList" class="toggle btn btn-primary btn-foot" onclick="location.href='/JSP_bootstrap/list'">목록</button>
			<button type="button" class="btn btn-primary" onclick="OpenWindow('regist','회원등록',800,850);" >회원등록</button>
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