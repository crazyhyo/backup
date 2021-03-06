<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
table tr td {
	overflow: hidden;
	white-space: initial;
	text-overflow: ellipsis;
	-webkit-box-orient: vertical;
	word-break: break-all;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="ltct-bookmark-list-template" >
{{#each .}}
          <tr
			data-ltct-no="{{ltctNo}}" data-inst-no="{{instNo}}" data-inst-nm="{{instNm}}" data-inst-telno="{{instTelno}}" data-emp-cnt="{{empCnt}}"
			data-rmnd-sckbd-cnt="{{rmndSckbdCnt}}" data-sckbd-cnt="{{sckbdCnt}}" data-op-rate="{{opRate}}" data-inst-adres="{{instAdres}}"
            onclick="showDetail('{{ltctNo}}', '{{instAdres}}')"
            class="each-ltct-element" style="cursor: pointer;">
            <td style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">{{instNm}}</td>
            <td style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;" data-adres-map="{{instAdres}}">{{instAdres}}</td>
            <td>{{rmndSckbdCnt}}/{{sckbdCnt}}</td>
            <td style="text-align:center;"><span class="badge badge-{{fnBadge opRate}}" style="width: 35px;">{{opRate}}%</span></td>
          </tr>
{{/each}}
</script>
<script type="text/x-handlebars-template"  id="inptnt-pagination-template" >
    <li class="page-item each-inptnt-pagination-element"><a class="page-link" href="1"> <i class="fas fa-angle-double-left" style="color:#1a4f72;"></i>
    </a></li>
    <li class="page-item each-inptnt-pagination-element"><a class="page-link {{checkDisabled prev}}" href="{{#if prev}}{{prevPageNum}}{{/if}}"> <i class="fas fa-angle-left" style="color:#1a4f72;"></i>
    </a></li>

{{#each pageNum}}
    <li class="page-item each-inptnt-pagination-element {{signActive this}}" ><a class="page-link" href="{{this}}" >{{this}}</a></li>
{{/each}}

    <li class="page-item each-inptnt-pagination-element"><a class="page-link {{checkDisabled next}}" href="{{#if next}}{{nextPageNum}}{{/if}}"> <i class="fas fa-angle-right" style="color:#1a4f72;"></i>
    </a></li>
    <li class="page-item each-inptnt-pagination-element"><a class="page-link" href="{{realEndPage}}"> <i class="fas fa-angle-double-right" style="color:#1a4f72;"></i>
</a></li>
</script>

<script>
Handlebars.registerHelper({
"prettifyDate" : function(timeValue){
  var dateObj = new Date(timeValue);
  var year = dateObj.getFullYear();
  var month = dateObj.getMonth() + 1;
  var date = dateObj.getDate();
  return year + "-" + month + "-" + date;
},
"checkDisabled" : function(flag){
    if(!flag) return 'disabled';
},
"signActive" : function(pageNum){
  if(pageNum == page) return 'active';
},
"fnBadge" : function(opRate){
	if(opRate > 79){
		return "danger";
	}
	if(opRate < 71){
		return "primary";
	}
	else{
		return "warning";
	}
}
});
</script>

<script>
function process_go(type){
	
	var check = confirm('???????????? ???????????????????');
	if(!check) return;	
	
	var closeWindow = false;
	var message = '';
	
	if(type == 'A'){
		process_url = '<%=request.getContextPath()%>/rest-hspt/process-dgnss-sckbdreq-isoptnt';
		closeWindow = true;
		message = '??????????????? ?????????????????????.';
		$(opener.document).find('form[name="processForm"] input[name="closeWindow"]').val(closeWindow);
		
		processForm = $(opener.document).find('form[name="processForm"]');
		
		$.ajax({
			url : process_url,
			type : 'post',
			data : processForm.serialize(),
			dataType : 'json',
			success : function(dataMap) {
				
  				if(dataMap.msg == 'success'){
  					alert(message);
	  				window.opener.location.reload(true);
	  				window.close();
  				}else{
  					alert(dataMap.msg);
	  				window.opener.location.reload(true);
	  				window.location.reload(true);  
  				}		
			},
			error : function(error) {
				alert('error' + error.status);
			}
		});
	}
	if(type == 'C'){
		process_url = '<%=request.getContextPath()%>/rest-hspt/process-rejected-or-cancled-sckbdreq-to-sckbdreq-isoptnt';
		
		var data = 
		{
			 manageNo : $('#go-isoptnt-btn').attr('data-manage-no')
			,toLtctNo : $('#go-isoptnt-btn').attr('data-ltct-no')
			,sckbdreqNo : '${sckbdreqNo}'
		};
		
		$.ajax({
			url : process_url,
			type : 'post',
			data : data,
			dataType : 'json',
			success : function(dataMap) {
				
				
				message = '??????????????? ?????????????????????.';
				console.log(dataMap.colseWindow);
				
				if(dataMap.msg == 'success'){
					alert(message);
					$(opener.document).find('#jobForm').find("[name='typeCode']").val("C104");
	
					$(opener.document).find("#searchType option:eq(0)").prop("selected", true);
					$(opener.document).find('#keywordId').val("");
					
					var templateId = '#req-sckbd-ltct-list-template'
					var targetId = "#req-sckbd-ltct-list-table-tbody";
					var pagenationId = "#inptnt-req-list-pagination-ul";
					var page = 1;
					
					window.opener.list_go('<%=request.getContextPath()%>/rest-hspt/sckbdreq-list', page, targetId, pagenationId, templateId);
					
	  				window.close();			
				}else{
  					alert(dataMap.msg);
	  				window.opener.location.reload(true);
	  				window.location.reload(true); 					
				}
				
  				
			},
			error : function(error) {
				alert('error' + error.status);
			}
		});
	}
}
</script>

<script>

var page = 1;

var targetId = '';

var pagenationId = '';

var instNm ="";

var sckbdCnt ="";

var url = '<%=request.getContextPath() %>/rest-hspt/ltct-list-to-isoptnt';
window.onload = function(){
	
	
 	
	addEvnetWaitTab();
	addEvnetReqTab();
	
	$('#go-isoptnt-btn').attr('disabled', true);
	$('#bookmark-btn').attr('disabled', true);	
	
  list_go(url, page, targetId, pagenationId);
	$('ul.pagination').on('click','li a',function(event){
		if($(this).attr("href")) {
			page=$(this).attr("href");
			getPage(url, make_form(page), targetId, pagenationId);
		}
		
		return false;
	});
}
function make_form(pageParam){
  var jobForm=$('#jobForm');
  
  if(!pageParam) page = 1;
  
  page = pageParam;
  
  jobForm.find("[name='page']").val(page);
  jobForm.find("[name='perPageNum']").val($('select[name="perPageNum"]').val());
  jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
  jobForm.find("[name='keyword']").val($('#keywordId').val());
  
  return jobForm;
}

function list_go(url, pageParam, targetId, pagenationId){
	
	
  getPage(url, make_form(pageParam), targetId, pagenationId);
}

function getPage(handelbarsProcessingURL, form, targetId, pagenationId){
	
	
	if(!targetId) targetId='#ltct-bookmark-list-table-tbody';
	if(!pagenationId) pagenationId = '#inptnt-list-pagination-ul';
	
	console.log(handelbarsProcessingURL, form, targetId, pagenationId);
	
	$.ajax({
    url : handelbarsProcessingURL,
    type : 'post',
    dataType : 'json',
    data : form.serialize(),
    success : function(dataMap){

    	if(dataMap.ltctList.length == 0){

    		$('#go-isoptnt-btn').attr('disabled', true);
    		$('#bookmark-btn').attr('disabled', true);	

    		$('#ltct-all-list-table-tbody').html('<tr class="each-ltct-element"><td id="initialTd" colspan="4" style="text-align: center;">????????? ????????? ?????????.</td></tr>');
    		$('#ltct-bookmark-list-table-tbody').html('<tr class="each-ltct-element"><td id="initialTd2" colspan="4" style="text-align: center;">????????? ????????? ?????????.</td></tr>');
    		
	    	$('#initialTd').html('???????????? ????????????.');
	    	$('#initialTd2').html('???????????? ????????????.');
    		
    	  dataMap.pageMaker.endPage = 1;
	      printPagination(dataMap.pageMaker, $(pagenationId), $('#inptnt-pagination-template'), '.each-inptnt-pagination-element');
    	}else{
	      printData(dataMap.ltctList, $(targetId), $('#ltct-bookmark-list-template'), '.each-ltct-element');
	      printPagination(dataMap.pageMaker, $(pagenationId), $('#inptnt-pagination-template'), '.each-inptnt-pagination-element');
    	}
      initKakaoMap(dataMap.ltctList, dataMap.adres);
      
    },
    error : function(error){
      alert('error' + error.status);
    }
  })
 }



//jsonArray??? ResponseEntity?????? ????????? List??? ???????????? ??????
//target??? handlebars??? ????????? ???????????? append??? ???????????? jquery???????????? ??????????????? ??? ?????? ?????? tbody??? id??? ?????? target?????? ?????????.
//templateObject??? handlebars??? ???????????? ?????? ??????????????? jquery????????????.
//removeClass??? append???????????? ????????? ?????? ?????????<???????????? handlebars??? ?????? ?????? ??????>??? ????????? ????????? '.(???????????????)'??? ?????????.
//?????? ????????? templateObject?????? handlebars??? ?????? ?????? ????????? ????????? class??? ????????? ??????. ???????????? .each-inptnt-element??????,
//tr????????? ????????????.
function printData(jsonArray, target, templateObject, removeClass) {

		// templateObject??? json data??? ????????? ???????????? return?????? function template??? ????????????.
		var template = Handlebars.compile(templateObject.html());

		// ?????? template??? ???????????? jsonArray??? ????????? ???????????? html??? ????????????.
		var html = template(jsonArray);

		// ?????? html????????? append?????? ?????? ????????? ?????? ????????? ?????????. (???????????? ????????? ????????? 10????????? ????????? ??? ????????? 10???, 20???, 30??? ??? ????????? ????????? ????????? 10?????? ???????????????)
		$(removeClass).remove();

		// html????????? append??????.
		target.append(html);
	}

function printPagination(pageMaker, target, templateObject, removeClass) {

	var pageNum = new Array(pageMaker.endPage - pageMaker.startPage + 1);

	for (var i = 0; i < pageMaker.endPage - pageMaker.startPage + 1; i++) {
		pageNum[i] = pageMaker.startPage + i;
	}
	pageMaker.pageNum = pageNum;
	pageMaker.prevPageNum = pageMaker.startPage - 1;
	pageMaker.nextPageNum = pageMaker.endPage + 1;

	var template = Handlebars.compile(templateObject.html());
	var html = template(pageMaker);
	target.html("").html(html);
}
</script>



<script>
function addEvnetWaitTab(){
	var dgnssWaitTab = $('#custom-ltct-bookmark-list-tab');
	dgnssWaitTab.on('click',function(){
		$('#keywordId').val("")
		$('#jobForm').find("[name='typeCode']").val("");
		
		$('#searchType').val('');
		
		$('#go-isoptnt-btn').attr('disabled', true);
		$('#bookmark-btn').attr('disabled', true);
		$('#bookmark-btn').attr('data-ltct-no', '');
		
		targetId = "#ltct-bookmark-list-table-tbody";
		pagenationId = "#inptnt-list-pagination-ul";
		page = 1;
		list_go(url, page, targetId, pagenationId);
	})
}

function addEvnetReqTab(){
	var dgnssReqTab = $('#custom-ltct-all-list-tab');
	dgnssReqTab.on('click',function(){
		$('#keywordId').val("")
		$('#jobForm').find("[name='typeCode']").val("all");
		
		$('#searchType').val('');
		
		$('#go-isoptnt-btn').attr('disabled', true);
		$('#bookmark-btn').attr('disabled', true);
		$('#bookmark-btn').attr('data-ltct-no', '');
		
		targetId = "#ltct-all-list-table-tbody";
		pagenationId = "#inptnt-all-pagination-template";
		page = 1;
		list_go(url, page, targetId, pagenationId);
	})
}
function showDetail(ltctNo, instAdres){
	
	$('#go-isoptnt-btn').attr('disabled', true);	
	
	var trs = $('tr.each-ltct-element');
	
	trs.removeClass('on');
	
	var target = $('tr[data-ltct-no="'+ltctNo+'"]');
	
	target.addClass('on');	
	
	$('#bookmark-btn').attr('disabled', false);
	$('#bookmark-btn').attr('data-ltct-no', ltctNo);	
	if($(opener.document).find('form[name="processForm"]')){
	   	$(opener.document).find('form[name="processForm"] input[name="toLtctNo"]').val(ltctNo);
	}
	
	$('#go-isoptnt-btn').attr('data-ltct-no', ltctNo);

	if(target.attr('data-rmnd-sckbd-cnt') > 0){
		$('#go-isoptnt-btn').attr('disabled', false);
	}
	var rmndSckbdCnt = target.attr('data-rmnd-sckbd-cnt');
	var sckbdCnt = target.attr('data-sckbd-cnt');
	var parseRmndSckbdCnt = parseInt(rmndSckbdCnt);
	var parseSckbdCnt = parseInt(sckbdCnt);
	var isoptnt = parseSckbdCnt - parseRmndSckbdCnt;
	$.ajax({
	    url : '<%=request.getContextPath()%>/rest-hspt/get-bookmark-check',
	    type : 'post',
	    dataType : 'json',
	    data : 
	    	{
	    		'toInstNo' :  ltctNo
	    	}
	    	,
	    success : function(dataMap){
	    	
	    	$('#inst_nm').html(target.attr('data-inst-nm'));
	    	$('#op_rate').html(target.attr('data-op-rate') + "% (" + isoptnt + "/" + parseSckbdCnt + ")");
	    	$('#inst_telno').html(target.attr('data-inst-telno'));
	    	$('#emp_cnt').html(target.attr('data-emp-cnt'));
	    	$('#inst_adres').html(target.attr('data-inst-adres'));	    	
		   	mapOpen(target.attr('data-inst-adres'), target.attr('data-inst-nm'), target.attr('data-rmnd-sckbd-cnt'), target.attr('data-op-rate'), dataMap.bookmarkFlag, ltctNo);
		   	
	    },
	    error : function(error){
	      alert('error' + error.status);
	    }
	  })	
	
}
</script>

<script>
function rmndSckbdCntCheckBox(){
	
	var url = '<%=request.getContextPath()%>/rest-hspt/ltct-list-to-isoptnt';
	
	var check = $("#rmndSckbdCntCheck").is(':checked');
	
	$('#jobForm').find('[name="rmndSckbdCntCheck"]').val(check);
	
	var formCheck = $('#jobForm').find("[name='typeCode']").val();
	
	if(formCheck == "all"){
		targetId = "#ltct-all-list-table-tbody";
		pagenationId = "#inptnt-all-pagination-template";
		page = 1;
		list_go(url, page, targetId, pagenationId);
	}else{
		targetId = "#ltct-bookmark-list-table-tbody";
		pagenationId = "#inptnt-list-pagination-ul";
		page = 1;
		list_go(url, page, targetId, pagenationId);
	}

}
</script>

<div class="ddoing" style="height: 455px">
<table class="table table-bordered" style="table-layout: fixed;">
	<thead>
		<tr style="text-align: center;">
			<th class="col-md-2" style="width:20%;overflow: true;">?????????</th>
			<th class="col-md-6">??????</th>
			<th class="col-md-2" style="width:10%;">?????????</th>
			<th class="col-md-2" style="width: 10%;">?????????</th>
		</tr>
	</thead>
	<tbody id="ltct-bookmark-list-table-tbody">
		<tr class="each-ltct-element">
			<td id="initialTd" colspan="4" style="text-align: center;">????????? ????????? ?????????.</td>
		</tr>
	</tbody>
</table>
</div>
<div class="card-footer clearfix pb-0 pt-0" style="background-color: white;">
	<ul class="pagination justify-content-center m-0" id="inptnt-list-pagination-ul">
	</ul>
</div>
