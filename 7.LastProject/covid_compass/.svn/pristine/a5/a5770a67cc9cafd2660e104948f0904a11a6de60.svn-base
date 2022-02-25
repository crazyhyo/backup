<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head></head>

<title></title>

<body>
	<div class="card" style="margin:1px;">
				<!-- /.row -->
			<div class="card-body" style="height: 70px;">
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
							<tr >
								<th>게시판 번호</th>
								<th style="width: 45%;">제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<tr onclick="go_detail();">
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
				<%@ include file="../template/list-footer.jsp" %>
		</div>

<script>


function go_detail(){
	
	location.href = "<%=request.getContextPath()%>/hsptl/notice-detail";
}

</script>





</body>