<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<h1> jsQR test</h1>

<canvas style="border : 1px solid red;" width="200px" height="200px">
</canvas>

<script src="./jsQR.js"></script>
<script>

window.onload = function(){
	
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
    
    let imgElement = new Image();
    img.src = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=http://192.168.43.23/ddit/common/loginForm.do";
    
//	var imgElement = document.getElementById('testImg');

	imgElement.onload = function(){
		ctx.drawImage(imgElement, 0, 0, 200, 200);

	}
	ctx.drawImage(imgElement, 0, 0);
	
	var width = imgElement.width;
	var height = imgElement.height;
	
	var imgData = ctx.getImageData(0,0,width,height);
	
	const code = jsQR(imgData, width, height);
	
	if(code){
		alert('found QR code', code);
	}
	
}



</script>




</body>
</html>