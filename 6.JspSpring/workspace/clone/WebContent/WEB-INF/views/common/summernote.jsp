<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<script>

	function summernote_go(target){
		target.summernote({
			placeholder:'여기에 내용을 적으세요',
			lang:'ko-KR',
			height:250,
			disableResizeEditor: true,
			callbacks:{
				onImageUpload:function(files, editor, welEditable){
					for(var file of files){
						//alert(file.name);
						if(file.name.substring(file.name.lastIndexOf('.') + 1).toUpperCase() != 'JPG' ){
							alert('JPG 이미지 형식만 가능합니다.');
							return;
						}
						if(file.size > 1024 * 1024 * 5){
							alert('이미지는 5MB 미만입니다.');
							return;
						}
						
					}
					for(var file of files){
						sendFile(file, this); // this = $('textarea#content')를 미러링하고 있는 summernote 결국 textarea라고 생각해도 됨
					}
				},
				onMediaDelete:function(target){	//	target 은 미디어태그의 jquery 객체
//					alert(target.attr("src"));
// 					alert(target[0].src);

//					var splitSrc = target.attr("src").split("=");
					
					/* var splitSrc = target[0].src.split("=");
					var fileName = splitSrc[splitSrc.length - 1];
					alert(fileName); */
					
					deleteFile(target[0].src);
				}
			}
			
		});
	}
	
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append("file", file);
		$.ajax({
			data: form_data,
			type: "POST",
			url: '<%=request.getContextPath()%>/uploadImg.do',
			cache: false,
			contentType: false,
			processData: false,
			success: function(img_url){
				$(el).summernote('editor.insertImage', img_url);
			},
			error: function(){
				alert(file.name + " 업로드에 실패했습니다.");
			}
		})
	}
	
	function deleteFile(src){
		var splitSrc = src.split("=");
		var fileName = splitSrc[splitSrc.length - 1];
		var fileData = {fileName:fileName};
		
		alert(JSON.stringify(fileData));
		
		$.ajax({
			url:"<%=request.getContextPath()%>/deleteImg.do",
			data:JSON.stringify(fileData),
			type:"post",
			contentType:"application/json",
			success:function(res){
				console.log(res);
			},
			error:function(){
				alert('이미지 삭제가 풀가합니다.')
			}
		});
	}
</script>