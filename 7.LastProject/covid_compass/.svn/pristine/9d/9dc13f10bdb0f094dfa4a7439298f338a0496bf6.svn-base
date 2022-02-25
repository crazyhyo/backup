<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head></head>

<title></title>

<body>
	<div class="card card-info">
              <div class="card-header" style="background: #1a4f72">
                <h3 class="card-title" >확진결과조회</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form class="form-horizontal" name="testResultCheck" >
                <div class="card-body pb-0 pt-0">
                  <div class="form-group row ">
                    <label for="inputEmail3" class="col-sm-3 col-form-label">성명</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="pstiNm" name="pstiNm" placeholder="홍길동">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-3 col-form-label pt-0">주민등록 번호</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" name="rrn" id="rrn" maxlength="14" oninput="rrnAutoHyphen(this)" placeholder="20220118-1234567">
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                  <button type="button" class="btn btn-info " onclick="lookUp();" style="background: #1a4f72; border-color: #1a4f72;">조회</button>
                  <button type="button" class="btn btn-default float-right" onclick="openClose();" style="background: #1a4f72; border-color: #1a4f72; color: white;">취소</button>
                </div>
                <!-- /.card-footer -->
              </form>
            </div>
            
<script>
function openClose(){
	var check = confirm("취소 하시겠습니까?");

      if(check) window.close();
}
	
function lookUp(){
	
		var rrn = $('#rrn').val();
		var nm = $('#pstiNm').val();
		
		var rrn_length = $('#rrn').val().length;
		if(rrn_length < 14){
			alert("주민/외국인등록번호를 잘못 입력하셨습니다.")
			return false;
		}

		if(!(rrn && nm)){
			alert("이름과 주민등록번호를 모두 작성해 주세요.");
			return false;
		}
		
		 var check = confirm("조회 하시겠습니까?");

	     if(check) {
	    	 
	     window.close();
		
		 var gsWin = window.open('about:blank','testResultCheck','width=580,height=440');
	     var frm =document.testResultCheck;
	     frm.action = 'testResultCheck';
	     frm.target ="testResultCheck";
	     frm.method ="post";
	     frm.submit();
	     }else{
	    	 return false;
	     }
		
	//OpenWindow('testResultCheck', '확진결과', 580,440)
	
}	

const rrnAutoHyphen = (target) =>{
	target.value = target.value.replace(/[^0-9]/, '').replace(/^(\d{6})(\d{1,7})$/,`$1-$2`);
}


</script>            
            
</body>