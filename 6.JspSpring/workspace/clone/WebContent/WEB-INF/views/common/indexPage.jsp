<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>


<head></head>

<title></title>

<body>

	<div class="content-wrapper" style="background-color:#fff;">
	 	<iframe name="ifr" src="" frameborder="0" 
	 			style="width:100%;height:85vh;"></iframe>
 	</div>

<script>
function goPage(url, mCode){
	// alert(url);
	// alert(mCode);
	$('iframe[name="ifr"]').attr("src", url);
	//document.querySelector('iframe[name="ifr"]').src = url;
	
	if(typeof(history.pushState) == 'function'){
		var renewURL = location.href;
		
		renewURL = renewURL.substring(0, renewURL.indexOf('.do') + 3);
		
		if(mCode != 'M000000'){
			renewURL += "?mCode=" + mCode;
		}
		history.pushState(mCode, null, renewURL);
	}else{
		location.hash = "#"+mCode;
	}
	
}

function subMenu_go(mCode){
	//alert(mCode);
	if(mCode != 'M000000'){
// 		$.ajax({
<%-- 			url:"<%=request.getContextPath()%>/subMenu.do?mCode="+mCode, --%>
// 			type:"post",
// 			dataType:"application/json",
// 			success:function(data){
// 				console.log(data);
// 			}
// 		})

<%-- 		$.getJSON("<%=request.getContextPath()%>/subMenu.do?mCode="+mCode,function(data){ --%>
// 			printData(data, $('.subMenuList'), $('#subMenu-list-template'), '.subMenu');
// 		});

		var url = "<%=request.getContextPath()%>/subMenu.do?mCode="+mCode;
		var xhr = new XMLHttpRequest();
		xhr.open('GET', url, true);
		xhr.responseType='json';
		xhr.onload = function(){
			var data = xhr.response;
			console.log("xhr!!!");
			console.log(data);
			printData(data, $('.subMenuList'), $('#subMenu-list-template'), '.subMenu');
		}
		xhr.send(null);
		
	}else{
		$(".subMenuList").html("");
	}
}

function printData(dataArr, target, targetObject, removeClass){
	
	var template = Handlebars.compile(targetObject.html());
	
	var html = template(dataArr);
	
// 	alert("printData's html : " + html + "!");
	
	$(removeClass).remove();
	
// 	document.querySelectorAll(removeClass).remove(); // 인터넷 익스플로러는 이 메서드 지원 안함
// 	var child = document.querySelector(removeClass);
// 	child.parent.removeChild(child);					// 크로스 브라우징 고려
	
	target.append(html);
}

window.onload = function(){
	goPage('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');
	// 새로고침시 사이드 서브메뉴가 사라짐을 방지하기 위함
	subMenu_go('${menu.mcode}'.substring(0,3)+'0000');
}

</script> 	

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template" id="subMenu-list-template">
{{#each .}}
	<li class="nav-item subMenu">
		<a href="javascript:goPage('<%=request.getContextPath()%>{{murl}}','{{mcode}}');" class="nav-link">
			<i class="{{micon}}"></i>
			<p>{{mname}}</p>
		</a>
	</li>
{{/each}}
</script>
</body>