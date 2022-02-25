var comNoValue = 0;
comListServer = function (currentPageNo) {

	
  $.ajax({
    type: "get",
    url: "/CodePeople/CompanyPagingList.do",
    data: { "currentPageNo" : currentPageNo},
    dataType: "json",
    success: function (res) {

    	code = "";
      $(res).each(function (i, v) {

        code += `<div class="card" idx="${v.comNo}">
                        <div class="card-left">
                            <img src="/CodePeople/images/logo${i}.png" alt="Card image" style="width:64px; height: 64px;">
                        </div>
                        <div class="card-body card-right">
                          <div class="card-top-box">
                            <a href="/CodePeople/CompanyDetailList.do?comNo=${v.comNo}" class="card-link"><h4 class="card-title">${v.comNm}</h4></a>
                                <div class="dropup">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle btn-menu"
                                        data-bs-toggle="dropdown"></button>
                                    <!-- 카드 메뉴정보 -->
                                      <ul class="dropdown-menu">
                                        <!-- 카드 메뉴 헤더 -->
                                        <li>
                                            <h5 class="dropdown-header">관심등록</h5>
                                        </li>
                                        <!-- 카드 메뉴 옵션 -->
                                        <li><a class="dropdown-item addFav" idx=${v.comNo} >관심등록</a></li>
                                        <li><a class="dropdown-item deleteFav" idx=${v.comNo} >관심해제</a></li>
                                        <li>
                                        </ul>
                                </div>
                            </div>
                            <div class="card-rating-box">
                                  <p>${v.comIntro}</p>
                            </div>
                            <a href="/CodePeople/CompanyDetailList.do?comNo=${v.comNo}#review" class="card-link">리뷰</a>
                            <a href="/CodePeople/CompanyDetailList.do?comNo=${v.comNo}#board" class="card-link">게시물</a>
                            <a href="/CodePeople/CompanyDetailList.do?comNo=${v.comNo}#salary" class="card-link">연봉</a>
                            <a href="/CodePeople/CompanyDetailList.do?comNo=${v.comNo}#hr" class="card-link">채용</a>
                        </div>
                    </div>`;
      });

      let parent = document.querySelector('#company-card-list');
      parent.innerHTML= code;
      
      
      addFav = document.querySelectorAll('.addFav');
      deleteFav = document.querySelectorAll('.deleteFav');
      
      
      addFav.forEach( a=>{
      	a.addEventListener('click',event=>{
      		let comCard = event.currentTarget;
      		comNoValue = comCard.getAttribute('idx');
      		console.log(comNoValue);
      		addFavCompany();
      	})
      })

      deleteFav.forEach( a=>{
      	a.addEventListener('click',event=>{
      		let comCard = event.currentTarget;
      		comNoValue = comCard.getAttribute('idx');
      		console.log(comNoValue);
      		deleteFavCompany();			
      	})
      })
      
    },
    error: function (xhr) {
      alert("상태 : " + xhr.status + " text : " + xhr.statusText);
    }
  });

}





$(function() {
	
	$('#cpn-btn').on('click', function () {
		
	    var cdata = $('#comInsert').serializeJSON();
	    console.log(cdata);
	    
	    $.ajax({
	        type: "post",
	        url: "/CodePeople/CompanyInsert.do",
	        data: cdata,
	        dataType: "json",
	        success: function (res) {
	          
	        	if(res.flag == 'true'){
	        		alert("기업등록이 완료되었습니다!");
	        	location.href = "/CodePeople/CompanyPagingList.do";
	        	} else {
	        		alert("기업등록에 실패하였습니다.")
	        	}
	        	
	        },
	        error : function (xhr) {
	         alert("상태 : " + xhr.status + "  text : " + xhr.statusText);
	        }
	      });
	    
	  });
})
  

$(function() {
	
	$('#upd-btn').on('click', function () {
		
	    var cdata = $('#comInsert').serializeJSON();
	    console.log(cdata);
	    
	    $.ajax({
	        type: "post",
	        url: "/CodePeople/CompanyUpdate.do",
	        data: cdata,
	        dataType: "json",
	        success: function (res) {
	          
	        	if(res.flag == 'true'){
	        		alert("기업수정이 완료되었습니다!");
	        	location.href = "/CodePeople/CompanyPagingList.do";
	        	} else {
	        		alert("기업수정에 실패하였습니다.")
	        	}
	        	
	        },
	        error : function (xhr) {
	         alert("상태 : " + xhr.status + "  text : " + xhr.statusText);
	        }
	      });
	    
	  });
})

$(function() {
	
	$('#del-btn').on('click', function () {
		
	    var comNo = $('#comNo').val();
	    console.log(comNo);
	    $.ajax({
	        type: "post",
	        url: "/CodePeople/CompanyDelete.do",
	        data: {"comNo" : comNo},
	        dataType: "json",
	        success: function (res) {
	          
	        	if(res.flag == 'true'){
	        		alert("기업삭제가 완료되었습니다.");
	        	location.href = "/CodePeople/CompanyPagingList.do";
	        	} else {
	        		alert("기업삭제에 실패하였습니다.")
	        	}
	        	
	        },
	        error : function (xhr) {
	         alert("상태 : " + xhr.status + "  text : " + xhr.statusText);
	        }
	      });
	    
	  });
})

//세션에서 회원의 회원번호를 반환하는 메서드, 비회원인 경우 0을 반환
function CheckMemRight(){
	
	$.ajax({
		url: '/CodePeople/CheckRight.do',
		type: 'get',
		dataType: 'json',
		success: function(res){
			
			alert('회원구분코드 : ' + res.memCode + '\n' + '회원번호 : ' + res.memNo);
			
			memNo = res.memNo;
			
		},
		error: function(err){
			alert(`status : ${err.status}`);
		}		
	})
	
}

function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function (data) {
      // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var roadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ""; // 참고 항목 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if (data.buildingName !== "" && data.apartment === "Y") {
        extraRoadAddr +=
          extraRoadAddr !== "" ? ", " + data.buildingName : data.buildingName;
      }
      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if (extraRoadAddr !== "") {
        extraRoadAddr = " (" + extraRoadAddr + ")";
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById("postCode").value = data.zonecode;
      document.getElementById("roadAddress").value = roadAddr;

      var roadSido = data.sido;
      var roadSigungu = data.sigungu;

      document.getElementById("cityCodeNo").value = data.sido;
      document.getElementById("provCodeNo").value = data.sigungu;

    },
  }).open();
}

function proc(){
	
	execDaumPostcode();
	
	setTimeout(function(){
		let cityCodeNo = $('#cityCodeNo').val();
		let provCodeNo = $('#provCodeNo').val();
		console.log(cityCodeNo, provCodeNo);
		
		$.ajax({

			url: '/CodePeople/ConvertForm.do',
			type: 'get',
			data: {
				"cityCodeNo" : cityCodeNo,
				"provCodeNo" : provCodeNo
			},
			dataType: 'json',
			success: function(res){
				
				$('#cityCodeNo').val(res.cityCodeNo);
				$('#provCodeNo').val(res.provCodeNo);
				
				console.log(res.cityCodeNo, res.provCodeNo);
			},
			error: function(err){
				alert(`status : ${err.status}`);
			}
		})
	}, 6000)
}

function setValue(ddVal){
	
	if(ddVal != null){
		var inputSet = $(ddVal).text();
		var value = inputSet.substring(3,4); 
		$('#jgval').val(inputSet);
		$('#jgCodeNo').val(value);
	} 
	
}

let addFav = "";
let deleteFav="";
 const addFavCompany = () => {
	 	
	console.log('addFavCompany called...');
	 
         $.ajax({
               url : '/CodePeople/AddFavCompany.do',
               type : 'get',
               data : {"comNo" : comNoValue},
               dataType:"json",
               success : function(res){
                   /*  응답에 따라 alert 효과 발생하도록 해야함*/
            	   alert(res.result);
               },
              error :function(xhr){
                  console.log(`status: ${xhr.satus}\n text : ${xhr.statusText}`);
              }  
           })
    };

const deleteFavCompany = () => {
	
    $.ajax({
        url :'/CodePeople/DeleteFavCompany.do',
        type:'get',
        data:{"comNo" : comNoValue},
        dataType:"json",
        success: function(res){
        	alert(res.result);
        },
        error:function(xhr){
         console.log(`status: ${xhr.status}\ntext : ${xhr.statusText}`);
        }

    })
}