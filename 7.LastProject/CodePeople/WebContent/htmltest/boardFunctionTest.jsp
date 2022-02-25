<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	MemberVO vo = (MemberVO)session.getAttribute("vo");
    	
    	int memNo = vo.getMemNo();
    %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>게시판 기본2</title>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/d3ee6ce800.js" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/CodePeople/js/jquery-3.6.0.min.js"></script>

    <!-- include summernote css/js/ codemirror-->
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.css">
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/monokai.css">
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    
    
    <link rel="stylesheet" href="/CodePeople/css/main.css">
    <script src="/CodePeople/js/board.js"></script>    
    <script src="/CodePeople/js/jquery.serializejson.min.js"></script>
    
    
<script>

	reply = {};
	
    $(function(){
    	
    	listServer();
    	
        $(document).ready(function () {
            $('.summernote').summernote({
                height: 300,                 // set editor height
                minHeight: null,             // set minimum height of editor
                maxHeight: null,             // set maximum height of editor
                focus: true,                 // set focus to editable area after initializing summernote
                codemirror: {                // codemirror options
                theme: 'monokai'
  			 }
            });
        });
        $(document).ready(function () {
            $('#summernote').summernote();
        });
		
        //'작성완료' 전송 버튼 이벤트
        $('#send').on('click', function () {
            var fdata = $('#fid').serializeJSON();
            console.log(fdata);
            
            $.ajax({
            	type : "post",
            	url	 : "/CodePeople/BoardInsert.do",
            	data : fdata,
            	dataType: "json",	
            	success : function(res) {
					listServer();
				},
				error : function(xhr) {
					alert("상태 : " + xhr.status + " text : " + xhr.statusText);
				}
            	
            });
            
        }); //글작성 끝
        
        //글 수정,삭제 / 댓글 등록 수정 삭제 버튼 이벤트 
        $(document).on('click', '.action' , function() {
       
           var vname = $(this).attr('name');
           var vidx = $(this).attr('idx');
           var vidy = $(this).attr('idy');
           
           console.log(this);
           
           $('.getBoardNo').val(vidx);
           $('.getBoardCodeNo').val(vidy);
        	
        	if(vname == "update"){
        		
        		alert(vidy + "번 코드");
        		alert(vidx + "번 글 수정");
        		alert(vname + "버튼네임이다 네임")
        		btnupdate = this;
        		
        		parent = $(this).parents('.card');
        		
        		//제목 태그 내용
        		writer = $(parent).find('.writer').text();
        		title = $(parent).find('.title').html();
        		content = $(parent).find('.content').html().trim();
        		
        		
        		console.log(writer);
        		console.log(title);
        		console.log(content);
        		
        		
				$('#updateModal .mwriter').val(writer);        		
				$('#updateModal .mtitle').val(title);        		
				$('#updateModal .note-editable').html(content);
				$('#updateModal .boardNo').val(vidx);
				
        		$('#updateModal').modal('show');
        	
        	//게시글 삭제	
        	}else if(vname == "delete"){
        		//alert(vidx + "번글 삭제할거임")
        		
        		/* btndelete = this; */
        		
        		
        		deleteBoardServer();
        	
        	//댓글 등록
        	}else if(vname == 'reply'){
        		alert(vidx + "번 글에 댓글")
        		
        		cont = $(this).prev().val();
        		console.log("댓글 등록 창에 쓴 글 " + cont);
        		boardNo = vidx;
        		console.log("댓글 쓰려는 게시판 번호 " + boardNo);
        		let boardCodeNo = 3;
        		
        		reply.boardNo = boardNo;
        		reply.repCont = cont;
        		reply.memNo = 1;
        		reply.boardCodeNo = boardCodeNo;
        		console.log(reply.boardNo);
        		console.log(reply.repCont);
        		console.log(reply.memNo);
        		
        		replyInsertServer(reply);
        		
        	//댓글 리스트	
        	}else if(vname == 'list'){  //글 제목 클릭시 오픈 됨
        		console.log("list")
        		
        		replyListServer(this , vidx);
        		//replyCommentListServer(this, vdix);
        		
        	//댓글 수정
        	}else if(vname == 'rmodify'){
        		//alert("댓글수정버튼")
         		//parent = $(this).parents('.rep')
        		
        		//댓글 원본 가져오기
        		mcont = $(this).parents('.reply-card').find('.reply-content');
        		
        		
        		console.log("댓글 원본" + mcont);
        		
        		
         		//$('#modiForm textarea').val(mcont);
        		
        		$(this).parents('.reply-card').find('.card-body').empty().append($('#modiForm'));
        		$('#modiForm').show();
        	
        	}else if(vname == 'rdelete'){
        		
        		reply.repNo = vidx;
        		
        		replyDeleteServer(this);
        		
        		
        	}
        	
        	
        	
        });
        //수정 완료 버튼 클릭시 이벤트
        $('#upsend').on('click', function() {
			
        	var udatas = $('#updateBoard').serializeJSON();
        	
        	alert(JSON.stringify(udatas));
			console.log("유데이터 : " + udatas);
			
			$.ajax({
				type : 'post',
				url : "/CodePeople/BoardUpdate.do",
				data : udatas,
				dataType : 'json',
				success : function(res) {
					alert(res.flag);
					
					$(btnupdate).parents('.card');
					$(parent).find('.title').text(udatas.title);
					$(parent).find('.content').text(udatas.content);
					
					listServer();
				},
				error : function(xhr) {
					
					alert("상태 : " + xhr);
					
				}
				
			})
			
			$('#updateModal .fin').val("");
			$('#updateModal').modal('hide');
			
		});
        
        //댓글수정 취소버튼 이벤트
        $('#btnreset').on('click', function() {
			
        	replyReset();
		})
        
        //댓글수정 확인 버튼 클릭 시 이벤트
        $('#btnok').on('click', function() {
			
        	mcont = $('#modiForm textarea').val()
        	
        	cp = $('#modiForm').parent();
        	
        	$('body').append($('#modiForm'));
        	$('#modiForm').hide();
        	
        	reply.repCont = mcont;
        	reply.repNo = vidx;
        	console.log("수정된 댓글" + reply.repCont);
        	console.log("수정된 댓글 번호" + reply.repNo);
        	
        	replyUpdateServer();
		});
        
        $('#btnupload').on('click', function() {
			
        	fileUploadServer()
        	
		})
        
        

    });

</script>
   
   
   <style>
       .modal-body label{
            width: 150px;
       }
       
    </style>


</head>



<body>

    <!-- 헤더 -->
    <div id="header">
        <!-- 헤더 메인 메뉴 바 -->
        <div id="header-container">
            <!-- 좌측 메뉴 -->
            <div id="header-left-menu">
                <!-- 로고 -->
                <a href="" id="logo"><i class="fas fa-copyright" style="font-size: 32px;"></i></a>
                <div class="divider"></div>
                <!-- 통합 검색창 -->
                <div id="search-box">
                    <div id="search-item">
                        <i class="fas fa-search item" style="width:15.3px; height:19px;"> </i>
                        <input class="" type="text"
                            style="height:19px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"
                            placeholder="통합검색">
                    </div>
                </div>
            </div>
            <!-- 우측 메뉴 -->
            <div id="header-right-menu">
                <!-- 메인 메뉴 링크 -->
                <div id="header-link-box">
                    <a class="header-link" href="/CodePeople/rehearsal/mainHr.html">인재</a>
                    <a class="header-link" href="/CodePeople/rehearsal/company.html">기업</a>
                    <a class="header-link" href="/CodePeople/rehearsal/mainJo.html">채용</a>
                    <a class="header-link" href="/CodePeople/rehearsal/mainBoard.html">커뮤니티</a>
                    <a class="header-link" href="/CodePeople/rehearsal/mainMypage.html">마이페이지</a>
                </div>
                <div class="divider"></div>
                <!-- 로그인버튼 -->
                <button id="header-login-btn" class="btn btn-primary btn-sm">로그인</button>
            </div>
        </div>
    </div>

    <!-- 바디 -->
    <div id="body">
        <div id="body-container">
            <!-- 바디 메인 좌측 메뉴바 -->
            <div class="nav-left-bar">
                <div class="nav-sticky">
                    <ul class="list-group">
                        <li class="list-group-item active">토픽 베스트</li>
                        <li class="list-group-item">회사 생활</li>
                        <li class="list-group-item">사는 얘기</li>
                        <li class="list-group-item">스터디 모임</li>
                        <li class="list-group-item">이직 커리어</li>
                        <li class="list-group-item">Q & A</li>
                    </ul>
                </div>
            </div>
            <!-- 바디 콘텐츠 -->
            <div id="content">
            <!-- 게시판 메인: 카테고리 검색 -->
            <div class="filter-box content-box board">
                <h1 class="h1">관심있는 내용을 검색해보세요!</h1>
                <div class="search-tags"></div>
                <div class="input-group mb-3 col-lg-10 search-text">
                    <input type="text" class="form-control" placeholder="검색어 입력">
                </div>
                <div class="filter-save-box">
                    <button type="button" class="btn btn-outline-primary filter-save">검색</button>
                </div>
            </div>
			
            <!-- 게시판 게시글 상세 화면 글쓰기 댓글 등등 기능 있음-->
            <div class="content-box search-result board board-main board-life">
                <div class="board-header">
                    <div class="board-name">
                        <i class="fas fa-building"></i>&nbsp;<h1 class="h1">회사생활</h1>
                    </div>
                    <div class="my-btn-box">
                        <button id="write" type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#writeModal">글쓰기</button>
                    </div>
                </div>
					<!-- 게시글 작성(글쓰기) 폼 -->
					<div class="modal" id="writeModal">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h4 class="modal-title">글쓰기</h4>
									<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
								</div>

								<!-- Modal body -->
								<div class="modal-body">
                                    <form id="fid" action="">
									    <label>작성자</label><input class="mobody-input writer" type="text" name="memId" disabled="disabled"><br>
									    <label>제목</label><input class="mobody-input title" type="text" name="boardTitle"><br>
									    <label>Tags</label><input class="mobody-input tag" type="text" name="boardHead">
									    <input type="hidden" name="memNo" value="<%=memNo%>">
<!--                                         <div class="mobody-input" name="note" id="summernote"></div>  -->
                                        <textarea name="boardCont" class="summernote"></textarea>
                                    </form>
<!--                                      action="/CodePeople/upload" method="post" enctype="multipart/form-data" -->
                                    <form id="fileUpload">
                                    <button type="button" id="send" class="btn btn-primary" data-bs-dismiss="modal">작성완료</button>
                                   	<input type="file" name="uploadfile" class="btn btn-primary">
                                   	<button type="submit" id="btnupload" value="업로드" class="btn btn-primary">업로드</button>
									<button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
                                    </form>
								</div>

								<!-- Modal footer -->
								<div class="modal-footer">
								</div>

							</div>
						</div>
					</div>

	


					<div class="board-body">
                <div class="divider"></div>
                <!-- 아코디언 : 게시판 게시글들 시작 -->
                    <div id="accordion">
                        <!-- 게시글의 한단위  -->
                        <!-- card-hear 안 a태그와 게시글의 아이디를 맞춰주세요 -->
                        <div class="card">
                            <div class="card-header">
                                <a class="btn title-btn" data-bs-toggle="collapse" href="#collapseOne">
                                    <span class="board-detail-title">회사 다니기 싫다.</span>
                                </a>
                                <div class="board-icon-box">
                                    <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-thumbs-up"></i>&nbsp;<span class="board-like board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-comment"></i>&nbsp;<span class="board-comment board-sm-font">100</span>&nbsp;&nbsp;
                                </div>
                            </div>
                            <!-- 게시글을 담고있는 곳 a 태그가 가르키는 곳 -->
                            <div id="collapseOne" class="collapse show" data-bs-parent="#accordion">
                                <div class="card-body">
                                    <div class="board-info-box">
                                        작성자&nbsp;:&nbsp;<span class="board-detail-writer">홍길동</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        작성일&nbsp;:&nbsp;<span class="board-detail-date">2021/10/18</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="" style="text-decoration: none;">추천</a>&nbsp;&nbsp;
                                        <a href="" style="text-decoration: none;">신고</a>
                                    </div>
                                    <span class="board-detail-content">
                                        다닐 회사가 있는 건 좋은 거지요 룰루랄라<br>
                                        안에 또 내용 넣어야 하는데 무어가 있을까 <br>
                                        작성자 작성일 끝?<br>
                                        아니야 신고 버튼 추천 버튼도 만들어야해요<br>
                                        하하하하하<br>
                                    </span>
                                    <!-- 수정, 삭제 버튼 -->
                                    <div class="my-btn-box my-btn-box-cv">
                                        

											
											
											<!-- 삭제  -->
											<button type="button" class="btn btn-outline-primary" id="delete">삭제</button>
                                    </div>
                                    
                                    
                                    
                                </div>
                                <div class="board-divider"></div>
                                <div class="board-bottom-icon-box">  
                                    <div class="board-icon-item"><i class="far fa-thumbs-up"></i>&nbsp;<span class="board-like board-sm-font">100</span></div>
                                    <div class="board-icon-item"><i class="far fa-comment"></i>&nbsp;<span class="board-comment board-sm-font">댓글</span></div>
                                    <div class="board-icon-item"><i class="far fa-frown"></i>&nbsp;<span class="board-comment board-sm-font">신고</span></div>
                                </div>
                                <div class="reply-box">
                                <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="댓글을 입력하세요">
                                        <button class="btn btn-outline-primary" type="button">등록</button>
                                    </div>
                                    <div class="reply-card bg-light text-dark">                                        
                                        <div class="reply-writer-box">&nbsp;&nbsp;작성자&nbsp;&nbsp;<span class="reply-writer">홍**</span></div> 
                                        <div class="card-body"><span class="reply-content">이것은 댓글입니다. 드랍 박스내부에 대댓글을 항목으로 넣어 구현할까 생각 중이에요. 그리고 추천과 신고 대댓글 갯수를 넣으려면, 게시글 위에 보이는 이미지들을 또 쓰겠죠.....그리고 수정 삭제도 드랍박스 안에 넣을 꺼에요.아 모르겠다 이제 ㄴ일 해야지 모두들 꿋잠...</span></div>
                                        <div class="reply-card-icon-box">  
                                            <div class="board-icon-item"><i class="far fa-thumbs-up"></i>&nbsp;<span class="reply-like board-sm-font">좋아요</span></div>
                                            <div class="board-icon-item"><i class="far fa-comment"></i>&nbsp;<span class="reply-reply-cnt board-sm-font">대댓글</span></div>
                                            <div class="board-icon-item"><i class="far fa-frown"></i>&nbsp; <span class="reply-report board-sm-font">신고</span></div>
                                        </div>
                                        <div class="my-btn-box-cv reply-btn-box">
                                            <button type="button" class="btn btn-outline-secondary">수정</button>
                                            <button type="button" class="btn btn-outline-secondary">삭제</button>
                                        
                                        </div>
                                    <div class="reply-card bg-light text-dark" style="width:200px">                                        
                                        <div class="reply-writer-box">&nbsp;&nbsp;작성자&nbsp;&nbsp;<span class="reply-writer">홍**</span></div> 
                                        <div class="card-body"><span class="reply-content">. 그리고 추천과 신고 대댓글 갯수를 넣으려면, 게시글 위에 보이는 이미지들을 또 쓰겠죠.....그리고 수정 삭제도 드랍박스 안에 넣을 꺼에요.아 모르겠다 이제 ㄴ일 해야지 모두들 꿋잠...</span></div>
                                        <div class="reply-card-icon-box">  
                                            <div class="board-icon-item"><i class="far fa-thumbs-up"></i>&nbsp;<span class="reply-like board-sm-font">좋아요</span></div>
                                            <div class="board-icon-item"><i class="far fa-comment"></i>&nbsp;<span class="reply-reply-cnt board-sm-font">대댓글</span></div>
                                            <div class="board-icon-item"><i class="far fa-frown"></i>&nbsp; <span class="reply-report board-sm-font">신고</span></div>
                                        </div>
                                        <div class="my-btn-box-cv reply-btn-box">
                                            <button type="button" class="btn btn-outline-secondary">수정</button>
                                            <button type="button" class="btn btn-outline-secondary">삭제</button>
                                        
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <a class="btn" data-bs-toggle="collapse" href="#collapseTwo">
                                    <span class="board-detail-title">회사 다니기 싫다.</span>
                                </a>
                                <div class="board-icon-box">
                                    <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-thumbs-up"></i>&nbsp;<span class="board-like board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-comment"></i>&nbsp;<span class="board-comment board-sm-font">100</span>&nbsp;&nbsp;
                                </div>
                            </div>
                            <div id="collapseTwo" class="collapse" data-bs-parent="#accordion">
                                <div class="card-body">
                                    <div class="board-info-box">
                                        작성자&nbsp;:&nbsp;<span class="board-detail-writer">홍길동</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        작성일&nbsp;:&nbsp;<span class="board-detail-date">2021/10/18</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="" style="text-decoration: none;">신고</a>
                                    </div>
                                    <span class="board-detail-content">
                                        다닐 회사가 있는 건 좋은 거지요 룰루랄라<br>
                                        안에 또 내용 넣어야 하는데 무어가 있을까 <br>
                                        작성자 작성일 끝?<br>
                                        아니야 신고 버튼 추천 버튼도 만들어야해요<br>
                                        하하하하하<br>

                                    </span>
                                    <div class="my-btn-box my-btn-box-cv">
                                        <button type="button" class="btn btn-outline-primary">수정</button>
                                        <button type="button" class="btn btn-outline-primary">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <a class="btn" data-bs-toggle="collapse" href="#collapseThree">
                                    <span class="board-detail-title">회사 다니기 싫다.</span>
                                </a>
                                <div class="board-icon-box">
                                    <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-thumbs-up"></i>&nbsp;<span class="board-like board-sm-font">100</span>&nbsp;&nbsp;
                                    <i class="far fa-comment"></i>&nbsp;<span class="board-comment board-sm-font">100</span>&nbsp;&nbsp;
                                </div>
                            </div>
                            <div id="collapseThree" class="collapse" data-bs-parent="#accordion">
                                <div class="card-body">
                                    <div class="board-info-box">
                                        작성자&nbsp;:&nbsp;<span class="board-detail-writer">홍길동</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        작성일&nbsp;:&nbsp;<span class="board-detail-date">2021/10/18</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="" style="text-decoration: none;">신고</a>
                                    </div>
                                    <span class="board-detail-content">
                                        다닐 회사가 있는 건 좋은 거지요 룰루랄라<br>
                                        안에 또 내용 넣어야 하는데 무어가 있을까 <br>
                                        작성자 작성일 끝?<br>
                                        아니야 신고 버튼 추천 버튼도 만들어야해요<br>
                                        하하하하하<br>

                                    </span>
                                    <div class="reply-btn-box">
                                        <button type="button" class="btn btn-outline-primary">수정</button>
                                        <button type="button" class="btn btn-outline-primary">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        
            </div>


            <!-- 게시판 메인 화면에서 보이는 각 게시판 카드-->
            <div class="content-box search-result board board-main board-best">
                <div class="board-header">
                    <div class="board-name">
                        <i class="fas fa-crown"></i>&nbsp;<h1 class="h1">토픽 베스트</h1>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-box search-result board board-main board-life">
                <div class="board-header">
                    <div class="board-name">
                        <i class="fas fa-building"></i>&nbsp;<h1 class="h1">회사생활</h1>
                    </div>
                    <div class="board-btn-box">
                        <button type="button" class="btn btn-outline-primary">더보기 ></button>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-box search-result board board-main board-blah">
                <div class="board-header">
                    <div class="board-name">
                        <div class="board-name"><i class="fas fa-comment-dots"></i>&nbsp;<h1 class="h1">사는얘기</h1>
                        </div>
                    </div>
                    <div class="board-btn-box">
                        <button type="button" class="btn btn-outline-primary">더보기 ></button>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-box search-result board board-main board-meetup">

                <div class="board-header">
                    <div class="board-name">
                        <div class="board-name"><i class="fas fa-handshake"></i>&nbsp;<h1 class="h1">스터디 모임</h1>
                        </div>
                    </div>
                    <div class="board-btn-box">
                        <button type="button" class="btn btn-outline-primary">더보기 ></button>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="content-box search-result board board-main board-career">
                <div class="board-header">
                    <div class="board-name">
                        <div class="board-name"><i class="fas fa-briefcase"></i>&nbsp;<h1 class="h1">이직 커리어</h1>
                        </div>
                    </div>
                    <div class="board-btn-box">
                        <button type="button" class="btn btn-outline-primary">더보기 ></button>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="content-box search-result board board-main board-qna">
                <div class="board-header">
                    <div class="board-name">
                        <div class="board-name"><i class="fas fa-question"></i>&nbsp;<h1 class="h1">Q & A</h1>
                        </div>
                    </div>
                    <div class="board-btn-box">
                        <button type="button" class="btn btn-outline-primary">더보기 ></button>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">회사 때려치고 싶어요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <!-- 시연을 위한 코드입니다 우측 카드를 사용해주세요 -->
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">프론트 적성에 안맞아요</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
                <div class="board-card">
                    <div class="board-detail">
                        <a href="#" class="card-link"><span class="board-title">에라 모르겠다</span></a>&nbsp;&nbsp;
                        <div class="view-box">
                            <i class="far fa-eye"></i>&nbsp;<span class="board-view board-sm-font">100</span>
                        </div>
                    </div>
                </div>
            </div>


        </div>
     </div>
    </div>

    <!--  풋터-->
    <div id="footer">
        <div id="footer-container"></div>
    </div>
    
    
	<!-- 게시글 수정 폼 -->
	<div class="modal" id="updateModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!--Modal Header  -->
				<div class="modal-header">
					
					<h4 class="modal-title">수정하기</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="updateBoard">
						<label>작성자</label><input class="mobody-input fin mwriter" type="text" name="memId" readonly><br>
						<label>제목</label><input class="mobody-input fin mtitle" type="text" name="boardTitle"><br> 
						<label>Tags</label><input class="mobody-input fin mtag" type="text" name="boardHead">
<!-- 					<div class="mobody-input" name="note" id="summernote"></div>  -->
						<textarea name="boardCont" class="summernote fin mcont" placeholder="hi"></textarea>
						<input type='hidden' name="boardNo" class="boardNo" value="" id="getBoardNo">
						<input type='hidden' name="boardCodeNo" class="boardCodeNo" value="" id="getboardCodeNo">
					<button type="button" id="upsend" class="btn btn-primary" data-bs-dismiss="modal">수정완료</button>
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

		<!-- 댓글 수정폼 -->
		<div id="modiForm" style="display: none">
	      <textarea rows="5" cols="30"></textarea>
	      <input type="button" id="btnok" value="확인"> 
	      <input type="button" id="btnreset" value="취소">
	   </div>



</body>


</html>