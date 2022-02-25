/**
 * 
 */

//"use strict";

function updateBoardServer(){
	
	$.ajax({
		url: '/boardpro/BoardUpdate.do',
		type: 'post',
		data: formData,
		dataType: 'json',
		success: function(res){
			alert(res.flag);
//			listPageServer(currentPage);
			let parent = $(target).parents('.panel');
			$(parent).find('a').text(formData.subject);
			$(parent).find('.mail').text(formData.mail);
			
			let content = formData.content;
			
			content = content.replace(/\r/g,"");
			content = content.replace(/\n/g,"<br>");
			
			$(parent).find('.p3').text(content);
			
		},
		error: function(err){
			alert(`status : ${err.status}\ntext : ${err.statusText}`);
		}
	})
	
}

function listServer(){
    $.ajax({
        url: '/boardpro/List.do',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            var code = '';
            res.datas.forEach(element => {
                code += `<div class="panel-default"> 
                                <div class="panel panel-default">
                                <div class="panel-heading">
                                <h4 class="panel-title">
                                <a data-toggle="collapse" class="collapse show" data-parent="#accordion" href="#collapse${element.num}">${element.subject}</a>
                                </h4>
                                </div>
                                <div id="collapse${element.num}" class="panel-collapse collapse">
                                <div class="panel-body">
                                <p class="p1">
                                작성자 : <span class="name">${element.writer}</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 이메일 : <span class="email">${element.mail}</span>&nbsp&nbsp&nbsp&nbsp
                                작성일 : <span class="date">${element.wdate}</span> &nbsp&nbsp&nbsp&nbsp&nbsp 조회수 : <span class="hit">${element.hit}</span>
                                </p>
                                <p class="p2">
                                <input type="button" idx="${element.num}" value="수정">
                                <input type="button" idx="${element.num}" value="삭제">
                                </p>
                                <p class="p3">
                                ${element.content}
                                </p>
                                <p class="p4">
                                <hr>
                                <textarea cols="128" rows="3"></textarea>
                                <input type="button" name="reply" class="action" value="등록">
                                </p>
                                </div>
                                </div>
                                </div>`
            })

            $('#accordion').html(code);
        },
        error : function(err) {
            alert(`status : ${err.status} \n text : ${err.statusText}`);
        }
    })
}

function replyUpdateServer(){
	$.ajax({
		url : '/boardpro/ReplyUpdate.do',
		type : 'post',
		data : reply,
		dataType : 'json',
		success: function (res){
			alert(res.flag);
		},
		error: function(err){
			alert(`status : ${err.status} \n text : ${err.statusText}`);
		}
	});
}

function replyDelete(btn){

    $.ajax({
        url: '/boardpro/ReplyDelete.do',
        type: 'get',
        data: {"renum" : vidx},
        dataType: 'json',
        success: function (res) {
            $(btn).parents('.rep').remove();
        },
        error : function(err) {
            alert(`status : ${err.status} \n text : ${err.statusText}`);
        }
    })
	
}

function replyListServer(btn){

    $.ajax({
        url: '/boardpro/ReplyList.do',
        type: 'get',
        data: {"bonum" : vidx},
        dataType: 'json',
        success: function (res) {
            let code = '';
            
            console.log('replyListServer');
            
            res.forEach(element => {
                code += `
                    <div class="panel-body rep">

                    <p class="p1">
                    작성자 : <span class="name">${element.name}</span>
                    작성일 : <span class="date">${element.redate}</span>
                    </p>
                    <p class="p2">
                    <input type="button" idx="${element.renum}" name="rmodify" value="댓글수정" class="action">
                    <input type="button" idx="${element.renum}" name="rdelete" value="댓글삭제" class="action">
                    </p>
                    <p class="p3">
                    ${element.cont}
                    </p>
                    </div>`;

            });
            $(btn).parents('.panel').find('.pbody').find('.rep').remove();
            $(btn).parents('.panel').find('.pbody').append(code);
        },
        error : function(err) {
            alert(`status : ${err.status} \n text : ${err.statusText}`);
        }
    })
	
}

function updateHitServer(){
	$.ajax({
		url: '/boardpro/UpdateHit.do',
		data: {"num" : vidx},
		type: 'get',
		dataType: 'json',
		success: function (res) {

        },
        error : function(err) {
            alert(`status : ${err.status} \n text : ${err.statusText}`);
        }
	})
}

function replySaveServer(btn){

    $.ajax({
        url: '/boardpro/ReplySave.do',
        type : 'post',
        data: reply,
        dataType: 'json',
        success: function(res){
        	replyListServer(btn);
        },
        error: function(err){
            alert(`status : ${err.status}\ntext : ${err.statusText}`);
        }
    })
	
}

function deleteBoardServer(){
	$.ajax({
		url: '/boardpro/DeleteBoard.do',
		type: 'get',
		data: { "num" : vidx },
		dataType: 'json',
        success: function(res){
        	if(res.flag == "success"){
        		if(currentPage > parseInt(res.totalPage)){
        			currentPage = parseInt(res.totalPage); 
        		}
        	}
        	listPageServer(currentPage);
        },
        error: function(err){
            alert(`status : ${err.status}\ntext : ${err.statusText}`);
        }
	})
}

function listPageServer(spage){
	$.ajax({
        url: '/boardpro/List.do',
        type: 'post',
        data: {"spage" : spage},
        dataType: 'json',
        success: function(res){
            var code = '';
            res.datas.forEach(element => {
                code += `       <div class="panel panel-default">
                                <div class="panel-heading">
                                <h4 class="panel-title">
                                <a class="action" name="list" idx="${element.num}" data-toggle="collapse" class="collapse show" data-parent="#accordion" href="#collapse${element.num}">${element.subject}</a>
                                </h4>
                                </div>
                                <div id="collapse${element.num}" class="panel-collapse collapse">
                                <div class="panel-body pbody">
                                <p class="p1">
                                작성자 : <span class="name">${element.writer}</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 이메일 : <span class="email">${element.mail}</span>&nbsp&nbsp&nbsp&nbsp
                                작성일 : <span class="date">${element.wdate}</span> &nbsp&nbsp&nbsp&nbsp&nbsp 조회수 : <span class="hit">${element.hit}</span>
                                </p>
                                <p class="p2">
                                <input type="button" idx="${element.num}" name="modify" value="수정" data-toggle="modal" data-target="#updateBoard" class="action">
                                <input type="button" idx="${element.num}" name="delete" value="삭제" class="action">
                                </p>
                                <p class="p3">
                                ${element.content}
                                </p>
                                <p class="p4">
                                <hr>
                                <textarea cols="128" rows="3"></textarea>
                                <input type="button" idx="${element.num}" name="reply" class="action" value="댓글">
                                </p>
                                </div>
                                </div>
                                </div>`
            });
            $('#accordion').html(code);
            var pager = ``;
            
            res.spage = parseInt(res.spage);
            res.tpage = parseInt(res.tpage);
            res.epage = parseInt(res.epage);
            res.cpage = parseInt(res.cpage);
            
            if(res.spage > 1){
            	pager += `<ul class="pager">
            		<li class="previous"><a href="#">Previous</a></li>
            		</ul>`;
            }
            pager += ` <ul class="pagination">`;
            for(let i = res.spage;  i <= res.epage; i++){
                if(res.cpage == i){
                          pager += `<li class="active"><a href="#">${i}</a></li>`;
                }else{
                          pager += `<li><a href="#">${i}</a></li>`;
                }
            }
            pager += `</ul>`;

            if(res.epage < res.tpage){
            	pager += `<ul class="pager">
            		<li class="next"><a href="#">Next</a></li>
            		</ul>`;
            }
            document.getElementById("pageBar").innerHTML=pager;
        },
        error : function(err) {
            alert(`status : ${err.status} \n text : ${err.statusText}`);
        }
	})
}
