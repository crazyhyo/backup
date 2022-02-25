<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head></head>

<title></title>

<body>
	<section class="content">
	<div class="card" style="margin:1px; margin-top:13px;">
				<!-- /.row -->
			<div class="card-body" style="height: 70px;">
				<!-- search bar -->
			<button type="button" class="btn btn-primary" style="background:#1a4f72; border:0px;width: 90px;"
				onclick="OpenWindow('notice-registForm', '공지사항 등록', 800,700)">등록</button>
				<!-- search bar -->
					<div class="input-group  float-right" style="max-width:600px;">
						<!-- sort num -->
						<select class="form-control " name="perPageNum"	id="perPageNum" onchange="list_go(1);" >
							<option value="10">정렬개수</option>
							<option value="2" ${pageMaker.cri.perPageNum == 2 ? 'selected':''}>2개씩</option>
							<option value="3" ${pageMaker.cri.perPageNum == 3 ? 'selected':''}>3개씩</option>
							<option value="5" ${pageMaker.cri.perPageNum == 5 ? 'selected':''}>5개씩</option>
						</select>
						
						<!-- search bar -->
						<select class="form-control " name="searchType" id="searchType" >
								<option value="" ${pageMaker.cri.searchType eq '' ? 'selected':''}>검색구분</option>
								<option value="i"
									${pageMaker.cri.searchType eq 'i' ? 'selected':''}>성명</option>
								<option value="n"
									${pageMaker.cri.searchType eq 'n' ? 'selected':''}>연락처</option>
						</select>
						
						<!-- keyword -->
						<input class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="${pageMaker.cri.keyword }" style="width: 18%;display: inline-block;"/>
						<span class="input-group-append"> 
							<button class="btn btn-primary" type="button" id="searchBtn" 
								    style="background: #1a4f72; color: #ffffff; border-color: #1a4f72;
								    	   display: inline-block;margin-bottom: 4px;margin-left: -7px;"
								data-card-widget="search" onclick="">
								<i class="fa fa-fw fa-search" ></i>
							</button>
						</span>
						<!-- end : search bar -->
				    </div>
	  
		 	 </div>
							
							
				<!-- /.card-header -->
				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap" style="text-align: center;">
						<thead>
							<tr>
								<th>게시판 번호</th>
								<th style="width: 45%;">제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<tr data-widget="expandable-table" aria-expanded="false">
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr class="expandable-body d-none">
			                      <td colspan="5">
				                        <div class="card-body" style="display: none; text-align: left;">
											<div class="form-group">
												<label for="inputName">제목</label> 
												<input type="text" id="inputName" class="form-control modifyPossible" readonly value="테스트 공지">
											</div>
	
											<div class="form-group">
												<label for="inputWriter">작성자</label> 
												<input type="text" id="inputWriter" class="form-control " readonly value="작성자">
											</div>
	
											<div class="form-group">
												<label for="inputDescription">내용</label>
												<textarea class="form-control" rows="3" placeholder="내용" readonly="readonly">테스트 입니다.</textarea>
											</div>
	
											<div class="form-group" style="border: none;">
												<label for="inputClientCompany">첨부된 파일</label> 
												<input type="text" id="inputFile" style="border: none; display: block;" value="첨부된 파일 없음">
											</div>
	
											<div class="form-group" style="border: none; text-align: right;">
												<button onclick="location.href='notice-modifyForm'" class="btn btn-success" style="background: #1a4f72; border-color: #1a4f72;">수정</button>
												<button class="btn btn-success" style="margin-left: 1%; background: #1a4f72; border-color: #1a4f72;">삭제</button>
											</div>
	
								       </div>
			                      </td>
                    		</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							<tr>
								<td>183</td>
								<td>테스트 공지</td>
								<td>홍길동</td>
								<td><span class="tag tag-success">22-01-05 21:16</span></td>
								<td>10</td>
							</tr>
							
						</tbody>
					</table>
				</div>
				<div class="card-footer clearfix" style="background: white;">
					<%@ include file="../template/list-footer.jsp" %>	
				</div>
				
		</div>
		</section>

<script>
	window.onload = function() {
		// Summernote
		$('#summernote').summernote({
			height : 120
		})
		$('#summernote').summernote('disable');
	}
	
	function go_detail(){
		
		location.href = "<%=request.getContextPath()%>/ltct/notice-detail";
	}
	function noneHover(){
		document.getElementById('hover').style.background="white";
	}	

</script>





</body>