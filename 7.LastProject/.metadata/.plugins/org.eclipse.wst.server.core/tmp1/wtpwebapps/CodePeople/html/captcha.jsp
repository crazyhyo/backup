<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html> <html> <head> <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
<title>reCAPTCHA �׽�Ʈ</title>
 <script src='https://www.google.com/recaptcha/api.js'>
 </script>
  <script type="text/javascript"> 
  /* ����� ���� ��ĸí üũ ���� �� Ȯ���մϴ�. */ 
  function FormSubmit() { 
	  if (grecaptcha.getResponse() == ""){ 
		  alert("��ĸí�� üũ�ؾ� �մϴ�."); 
		  return false; 
		  } else { return true; } 
	  } 
  </script> 
  </head> 
  <body> 
  <br/> 
  <form name="testForm" method="post" action="" onsubmit="return FormSubmit();">
   �̸� : <input type="text" name="name" /><br />
    ��ȭ��ȣ : <input type="text" name="tel" /><br />
     <input type="submit" name="submit" value="����">
     <br />
     <br/> 
     <div class="g-recaptcha" data-sitekey="6LdMUdwcAAAAAGOxxD9DJc2VAA3DiQJWPImbZYgb">
     </div> 
     </form> 
     </body> 
     </html>