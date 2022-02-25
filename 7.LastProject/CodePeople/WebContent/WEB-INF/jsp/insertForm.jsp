<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 등록 폼 예제</title>
</head>
<body>
	<form action="insert.do" method="post" enctype="multipart/form-data">
			<label>첨부파일:</label>
			<input type="file" name="atchFile" multiple>
		<input type="submit" value="파일 등록">
	</form>

</body>
</html>