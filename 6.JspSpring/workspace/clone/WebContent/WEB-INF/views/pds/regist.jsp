<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<head></head>

<title>자료등록</title> 

<body> 
   <!-- Content Header (Page header) -->
    <section class="content-header">
    	<div class="container-fluid">
    		<div class="row mb-2">
    			<div class="col-sm-6">
	      			<h1>자료실</h1>
	      		</div>	      		
	    	
	       		
	       		<div class="col-sm-6">
			      <ol class="breadcrumb float-sm-right">
			        <li class="breadcrumb-item"><a href="list.do"><i class="fa fa-dashboard"></i>자료실</a></li>
			        <li class="breadcrumb-item active">자료등록</li>		        
			      </ol>
		      	</div>
	     	</div>	     	
      	</div>
    </section>

    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h4>글등록</h4>
					</div><!--end card-header  -->
					<div class="card-body">
						<form enctype="multipart/form-data" role="form" method="post" action="regist.do" name="registForm">
							<div class="form-group">
								<label for="writer">작성자</label> 
								<input type="text" id="writer" readonly
									name="writer" class="form-control" value="${loginUser.id }">
							</div>
							<div class="form-group">
								<label for="title">제 목</label> 
								<input type="text" id="title"
									name='title' class="form-control" placeholder="제목을 쓰세요">
							</div>
							<div class="form-group">
								<label for="content">내 용</label>
								<textarea class="form-control" name="content" id="content" rows="5"
									placeholder="1000자 내외로 작성하세요."></textarea>
							</div>
							<div class="form-group">								
								<div class="card card-outline card-success">
									<div class="card-header">
										<h5 style="display:inline;line-height:40px;">첨부파일 : </h5>
										&nbsp;&nbsp;<button class="btn btn-xs btn-primary"
										onclick="addFile_go();"	type="button" id="addFileBtn">Add File</button>
									</div>									
									<div class="card-footer fileInput">
									</div>
								</div>
							</div>
						</form>
					</div><!--end card-body  -->
					<div class="card-footer">
						<button type="button" class="btn btn-primary" id="registBtn" onclick="regist_go();">등 록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn" id="cancelBtn" onclick="CloseWindow();">취 소</button>
					</div><!--end card-footer  -->
				</div><!-- end card -->				
			</div><!-- end col-md-12 -->
		</div><!-- end row -->
    </section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="pds-uploadFileInput-template" >
<div class='inputRow' data-no={{dataNum}}>
	<input type='file' name='uploadFile' style='display:inline'>
	<button onclick='remove_go({{dataNum}});' style='border:0;outline:0' class='badge bg-red' type='button'>X</button>
</div>
</script>

<script>

var dataNum = 0;

function handlebars(JSONdata, jsObject, appendTarget){
	var template = Handlebars.compile(jsObject.innerHTML);
	var html = template(JSONdata);
	
	appendTarget.append(html);
}

function addFile_go(){
	
	if($('input[name="uploadFile"]').length >= 5){
		alert('파일추가는 5개까지만 가능합니다.');
		return;
	}
	handlebars({dataNum:dataNum}, document.getElementById('pds-uploadFileInput-template'), $('.fileInput'));
	
// 	var template = Handlebars.compile(document.getElementById('pds-uploadFileInput-template').innerHTML);
// 	var html = template({dataNum:dataNum});
 	
// 	alert(html);
// 	console.log(html);

// 	$('.fileInput').append(html);
// 	document.querySelector('.fileInput').innerHTML += html;
	
	dataNum++;
}


function remove_go(dataNum){
	$('div[data-no="'+dataNum+'"]').remove();
}
</script>    
    
</body>
