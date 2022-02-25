<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="card" style="width:650px; height:180px; margin-left:10px; margin-top: 15px;">
	<div class="card-header" style="background-color: #1a4f72">
		<h3 class="card-title"><span style="color: white">기관수정</span></h3>
	</div>
	<form role="form" action="./inst-modify" method="get">
	<div class="row" style="margin: 10px;">
			<label for="note">기관명</label>
			<div class="col-sm-4">
				<input type="text" name="instNm" class="form-control" value="${inst.instNm}">
			</div>
			<label style="margin-left:60px;" for="sort">연락처</label>
			<div class="col-sm-4">
				<input name="instTelno" type="text" class="form-control"  value="${inst.instTelno }">
			</div>
		</div>
		
		<div class="row" style="margin: 10px;">
			<label style="" for="sort">주소</label>
			<div class="col-sm-10 input-group-append">
				<input name="instAdres" style="margin-left:13px;" type="text" class="form-control" value="${inst.instAdres}">
			</div>
		</div>
		<div class="row">
			<div style="margin-left: 540px;">
				<input id="instNoModify" type="hidden" name="instNo" value="${inst.instNo}">
				<button type="submit" class="btn btn-primary user-list" style="background: #1a4f72; border-color: #1a4f72;padding-top: 3px; ">
					<span style="display: block;text-align: center; ">저장</span>
				</button>
			</div>
			<div  style="margin-left: 10px;">
				<button onclick="CloseWindow()" type="button" class="btn btn-primary user-list" style="background: #1a4f72; border-color: #1a4f72;padding-top: 3px; ">
					<span style="display: block;text-align: center; ">취소</span>
				</button>
			</div>
		</div>
	 </form>
</div>

</body>
</html>