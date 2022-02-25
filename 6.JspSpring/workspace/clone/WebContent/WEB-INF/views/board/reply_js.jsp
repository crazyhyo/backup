<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="reply-list-template" >
{{#each .}}
<div class="replyLi" >
	<div class="user-block">
		<img src="<%=request.getContextPath()%>/member/getPicture.do?picture={{picture}}" class="img-circle img-bordered-sm"/>
    </div>
	
 	<div class="timeline-item" >
  		<span class="time">
    		<i class="fa fa-clock"></i>{{prettifyDate regdate}}
	 		<a class="btn btn-primary btn-xs {{rno}}-a" id="modifyReplyBtn" data-rno={{rno}}
				onclick="replyModifyModal_go('{{rno}}');"				
				style="display:{{VisibleByLoginCheck replyer}};"
	    		data-replyer={{replyer}} data-toggle="modal" data-target="#modifyModal">Modify</a>
  		</span>
	
  		<h3 class="timeline-header"><strong style="display:none;">{{rno}}</strong>{{replyer}}</h3>
  		<div class="timeline-body" id="{{rno}}-replytext">{{replytext}} </div>
	</div>
</div>
{{/each}}
</script>

<script type="text/x-handlebars-template"  id="reply-pagination-template" >
<li class="paginate_button page-item">
   <a href="1" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-double-left'></i>
   </a>
</li>
<li class="paginate_button page-item">
   <a href="{{#if prev}}{{prevPageNum}}{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-left'></i>
   </a>
</li>
{{#each pageNum}}
<li class="paginate_button page-item {{signActive this}} ">
   <a href="{{this}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      {{this}}
   </a>
</li>
{{/each}}

<li class="paginate_button page-item ">
   <a href="{{#if next}}{{nextPageNum}}{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-right'></i>
   </a>
</li>
<li class="paginate_button page-item">
   <a href="{{realEndPage}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-double-right'></i>
   </a>
</li>   
</script>

<script>

window.onload = function(){
	getPage("<%=request.getContextPath()%>/reply/list.do?bno=${board.bno}&page="+replyPage);
	
	$('ul.pagination').on('click','li a', function(event){
// 		alert('ul click');
		
// 		return false;
		if( $(this).attr('href') ){
			replyPage=$(this).attr('href');
			getPage("<%=request.getContextPath()%>/reply/list.do?bno=${board.bno}&page="+replyPage);
		}
		
		return false;
	});
}

var replyPage = 1;

function printData(replyArr, target, templateObject){
	var template = Handlebars.compile(templateObject.html());
	var html = template(replyArr);
	$('.replyLi').remove();
	target.after(html);
}

function getPage(pageInfo){
	$.getJSON(pageInfo, function(data){
		printData(data.replyList, $('#repliesDiv'), $('#reply-list-template'));
		printPagination(data.pageMaker, $('ul#pagination'), $('#reply-pagination-template'));
	});
}

function printPagination(pageMaker, target, templateObject){
	
	var pageNum = new Array(pageMaker.endPage - pageMaker.startPage + 1);
	
	for(var i = 0; i < pageMaker.endPage - pageMaker.startPage + 1; i++){
		pageNum[i] = pageMaker.startPage + i;
	}
	pageMaker.pageNum = pageNum;
	pageMaker.prevPageNum = pageMaker.startPage - 1;
	pageMaker.nextPageNum = pageMaker.endPage + 1;
	
	var template = Handlebars.compile(templateObject.html());
	var html = template(pageMaker);
	target.html("").html(html);

}

Handlebars.registerHelper({
	"prettifyDate" : function(timeValue){
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	},
	"VisibleByLoginCheck" : function(replyer){
		var result = "none";
		if(replyer == "${loginUser.id}") result = "visible";
		return result;
	},
	"signActive" : function(pageNum){
		if(pageNum == replyPage) return 'active';
	}
});

function replyRegist_go(){
	// alert("replyRegist_go");
	
	var replytext = $('#newReplyText').val();
	var bno = $('input[name=bno]').val();
	
	if(!replytext){
		alert('내용은 필수입니다.');
		return;
	}
	
	var data = {
			"bno" : "" + bno + "",
			// "bno" : bno 도 됨, 왜냐하면 json을 넘길 때 JSON.stringify를 하기 때문, 밑도 같음. 원칙은 "로 감싸는 것
			"replyer" : "${loginUser.id}",
			"replytext" : replytext
	};
	
	$.ajax({
		url:"<%=request.getContextPath()%>/reply/regist.do",
		type:"post",
		data:JSON.stringify(data),
		contentType:'application/json',
		success:function(data){
			alert("댓글이 등록되었습니다.\n마지막 페이지로 이동합니다.");
			replyPage = data;
			
			getPage("<%=request.getContextPath()%>/reply/list.do?page="+data+"&bno="+bno);
			$('#newReplyText').val("");
		},
		error:function(){
			alert('댓글등록에 실패햐였습니다.');
		}
	});
}

function replyModifyModal_go(rno){// 이 함수는 모달창을 띄우는 함수가 아니라 모달창에 데이터를 심는 함수임.
	// 모달이 열리고 닫히는 것은 data-target과 data-toggle 설정에서 완료되었음
	$('div#modifyModal div.modal-body #replytext').val($('div#'+rno+'-replytext').text());
	$('div#modifyModal div.modal-header h4.modal-title').text(rno);
	
}

function replyModify_go(){
	// alert("!!!");
	var rno = $('.modal-title').text();
	var replytext = $('#replytext').val();
	
	var sendData = {
			rno : rno,
			replytext : replytext
	};
	
	$.ajax({
		url : "<%=request.getContextPath()%>/reply/modify.do",
		type : "post",
		data : JSON.stringify(sendData),
		contentType : "application/json",
		success : function(){
			alert("수정되었습니다.");
			getPage("<%=request.getContextPath()%>/reply/list.do?page="+replyPage+"&bno=${board.bno}");
		},
		error : function() {
			alert('수정에 실패했습니다.');
		},
		complete : function(){	// try 절의 finally와 같은 녀석
			$('#modifyModal').modal('hide');
		}
	});
	
<%-- 	var url = "<%=request.getContextPath()%>/reply/modify.do"; --%>
	
// 	var xhr = new XMLHttpRequest();
// 	xhr.open("POST", url, true);
// 	xhr.responseType = "json";
// 	xhr.onreadystatechange = function(){
		
// 		if(xhr.readyState === 4){
// 			if(xhr.status === 200){
// 				alert("수정되었습니다.");
<%-- 				getPage("<%=request.getContextPath()%>/reply/list.do?page="+replyPage+"&bno=${board.bno}"); --%>
// 			}else{
// 				alert('수정에 실패했습니다.');
// 			}
// 			$('#modifyModal').modal('hide');
// 		}
		
// 	}
// 	xhr.send(JSON.stringify(sendData));
	
// 	sendAsync({
<%-- 		url : "<%=request.getContextPath()%>/reply/modify.do", --%>
// 		data : JSON.stringify(sendData),
// 		contentType : "json",
// 		success : function(){
// 			alert("수정되었습니다.");
<%-- 			getPage("<%=request.getContextPath()%>/reply/list.do?page="+replyPage+"&bno=${board.bno}"); --%>
// 		},
// 		error : function() {
// 			alert('수정에 실패했습니다.');
// 		},
// 		complete : function(){	// try 절의 finally와 같은 녀석
// 			$('#modifyModal').modal('hide');
// 		}
// 	})
}

// function sendAsync(setting){
// 	var xhr = new XMLHttpRequest();
// 	xhr.open(setting.method, setting.url, true);
// 	xhr.responseType = setting.contentType;
// 	xhr.onreadystatechange = function(){
// 		if(xhr.readyState === 4){
// 			if(xhr.status === 200){
// 				setting.success();
// 			}else{
// 				setting.error();
// 			}
// 			setting.complete();
// 		}
// 	}
// 	xhr.send(setting.data);
// }

function replyRemove_go(){
// 	alert("replyRemove_go");


	var rno = $('.modal-title').text();
	
	$.ajax({
		url : "<%=request.getContextPath()%>/reply/remove.do?page="+replyPage+"&rno="+rno+"&bno=${board.bno}",
		type : "get",
		success : function(page){
			alert("삭제되었습니다.");
			getPage("<%=request.getContextPath()%>/reply/list.do?bno=${board.bno}&page="+page);
			replyPage = page;
		},
		error : function(error){
			alert('삭제되었습니다.');
		},
		complete : function(){
			$('#modifyModal').modal('hide');
		}
	});
}

</script>