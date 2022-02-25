//팝업창들 띄우기
//새로운 Window창을 Open할 경우 사용되는 함수 ( arg : 주소, 창타이틀, 넓이, 길이)
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var win = window.open(UrlStr, WinTitle, "scrollbars = yes, width = " + WinWidth + ", "
			+ "height=" + WinHeight + ", top =  " + wintop + ", left = "
			+ winleft + ", resizable=yes, status=yes");
	
	win.focus();
}

//팝업창 닫기
function CloseWindow(parentURL){
	window.opener.location.reload(true);
	window.close();
}

// 사진 불러오기
function MemberPictureThumb(targetObj, fileName, contextPath){
	
	if(!contextPath) contextPath = ""
	
	targetObj.style.backgroundImage = "url('" + contextPath + "/member/getPicture?picture=" + fileName + "')";
	targetObj.style.backgroundPosition = "center";
	targetObj.style.backgroundRepeat = "no-repeat";
	targetObj.style.backgroundSize = "cover";
	
}
