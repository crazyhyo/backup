<%@page import="kr.or.ddit.jobOpening.vo.JOCardVO"%>
<%@page import="kr.or.ddit.jobOpening.service.JobOpeningServiceImpl"%>
<%@page import="kr.or.ddit.jobOpening.service.IJobOpeningService"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.company.vo.CompanyVO"%>
<%@page import="kr.or.ddit.company.service.CompanyServiceImpl"%>
<%@page import="kr.or.ddit.company.service.ICompanyService"%>
<%@page import="kr.or.ddit.hr.vo.HRMyInfoVO"%>
<%@page import="kr.or.ddit.hr.service.HRServiceImpl"%>
<%@page import="kr.or.ddit.hr.service.IHRService"%>
<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <% 
  
MemberVO loginMember = session.getAttribute("memVO") == null?
             null : (MemberVO)session.getAttribute("memVO");
IMemberService memberService = MemberServiceImpl.getInstance();
int memNo = loginMember.getMemNo();

IHRService hrService = HRServiceImpl.getInstance();
int hrNo = hrService.getHrNo(memNo);	

HRMyInfoVO myInfoVO = hrService.selectMyInfo(memNo);
// HR Detail page visit count
int hrCnt = myInfoVO.getHrCnt();
	
ICompanyService comService = CompanyServiceImpl.getInstance();
List<CompanyVO>  folComList = comService.getFolCompany(hrNo);
List<CompanyVO> favComList = comService.getFavCompany(hrNo);

IJobOpeningService joService = JobOpeningServiceImpl.getInstance();
List<JOCardVO> clipList = joService.getClipByHR(hrNo);
  
  
  %>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://kit.fontawesome.com/d3ee6ce800.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../css/main.css">

<script src="../js/myPagePerson.js"></script>

<!--????????? ?????? ??????   -->
<link href='../css/myCalendar.css' rel='stylesheet' />
<link href='../css/myCalendar.min.css' rel='stylesheet' />
<script src='../js/myCalendarLocales-all.js'></script>
<script src='../js/myCalendar.js'></script>
<script src='../js/myCalendar.min.js'></script>
<!-- ????????????????????? ?????? -->
<script src="../js/prod.js"></script>


<script>

 document.addEventListener('DOMContentLoaded', ()=> {
    
	
	 
    const calendarEl = document.querySelector('#myCalendar');
       
    

 /*    let memNo = 1; 
     //?????? ?????? ??? ???????????? mwmNo??? ??????????????? ??????.
     
     
    let goInfoBtn = document.querySelector('#goInfoBtn');
     console.log(goInfoBtn);
     goInfoBtn.addEventListener('click',()=>{
   	 console.log('click');
   	  $.ajax({
	    		url : '/CodePeople/HRMyInfo.do',
	    		type : 'get',
	    		data : {"memNo" :memNo},
	    		dataType : 'json',
	    		success : function(res){
	    			console.log(res);
	    		},
	    		error : function(xhr){
	    			alert(`status : ${xhr.status}\ntext : ${xhr.statusText}`);
	    		}
	    	})
     })
     */
    
    
    
        var calendar = new FullCalendar.Calendar(calendarEl, {
           headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
              },   
          locale: 'ko',    
          editable: true,
          initialView: 'dayGridMonth',
          navLinks: true, // can click day/week names to navigate views
          selectable: true,
          selectMirror: true,
          select: function(arg) {
            var title = prompt('????????? ????????? ??????????????????.');
            if (title) {
              calendar.addEvent({
                title: title,
                start: arg.start,
                end: arg.end,
                allDay: arg.allDay
              })
            }
            calendar.unselect()
          },
          eventClick: function(arg) {
            if (confirm('????????? ?????????????????????????')) {
              arg.event.remove()
            }
          },
          editable: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: [
            {
              title: 'All Day Event',
              start: '2020-09-01'
            },
            {
              title: 'Long Event',
              start: '2020-09-07',
              end: '2020-09-10'
            },
            {
              groupId: 999,
              title: 'Repeating Event',
              start: '2020-09-09T16:00:00'
            },
            {
              groupId: 999,
              title: 'Repeating Event',
              start: '2020-09-16T16:00:00'
            },
            {
              title: 'Conference',
              start: '2020-09-11',
              end: '2020-09-13'
            },
            {
              title: 'Meeting',
              start: '2020-09-12T10:30:00',
              end: '2020-09-12T12:30:00'
            },
            {
              title: 'Lunch',
              start: '2020-09-12T12:00:00'
            },
            {
              title: 'Meeting',
              start: '2020-09-12T14:30:00'
            },
            {
              title: 'Happy Hour',
              start: '2020-09-12T17:30:00'
            },
            {
              title: 'Dinner',
              start: '2020-09-12T20:00:00'
            },
            {
              title: 'Birthday Party',
              start: '2020-09-13T07:00:00'
            },
            {
              title: 'Click for Google',
              url: 'http://google.com/',
              start: '2020-09-28'
            }
          ]
          
        });
        
        
        
        calendar.render();
        
        
     
      });

 $(function () {
		$(".list-group .memInfo").click(function (e) { 
			let submenu = $(this).next("ul");

			if (submenu.is(":visible")) {
				submenu.slideUp();
			} else {
				submenu.slideDown();
			}
		});
	});

 
      
  
    </script>

<style>
		.list-group .memInfo {
			cursor: pointer;
		}

		.list-group .infoList {
			display: none;
			padding: 0px;
		}
		.list-group .infoList li:hover{
			filter: brightness(95%); 
		}
		.preRemain{
			border : 1px solid silver;
			margin-bottom : 14px;
			border-radius: 0.8em;
			text-align: center;
		}
	
</style>
</head>
<body>
	<!-- ?????? -->
	<div id="header">
		<!-- ?????? ?????? ?????? ??? -->
		<div id="header-container">
			<!-- ?????? ?????? -->
			<div id="header-left-menu">
				<!-- ?????? -->
				<a href="/CodePeople/rehearsal/index.jsp" id="logo"><i class="fas fa-copyright"
					style="font-size: 32px;"></i></a>
				<div class="divider"></div>
				<!-- ?????? ????????? -->
				<div id="search-box">
					<div id="search-item">
						<i class="fas fa-search item" style="width: 15.3px; height: 19px;">
						</i> <input class="" type="text"
							style="height: 19px; border: none; border-right: 0px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;"
							placeholder="????????????">
					</div>
				</div>
			</div>
			<!-- ?????? ?????? -->
			<div id="header-right-menu">
				<!-- ?????? ?????? ?????? -->
				<div id="header-link-box">
				 <a class="header-link" href="/CodePeople/MainHR.do">??????</a>
            <a class="header-link" href="/CodePeople/CompanyPagingList.do">??????</a>
            <a class="header-link" href="/CodePeople/mainJsp/mainJO.jsp">??????</a>
            <a class="header-link" href="/CodePeople/EachBoardPaging.do">????????????</a>
            <a class="header-link myPage" href="/CodePeople/GoMyPage.do">???????????????</a>
				</div>
				<div class="divider"></div>
				<!-- ??????????????? -->
				<a href="/CodePeople/rehearsal/logout.jsp"><button id="header-login-btn" class="btn btn-primary btn-sm">????????????</button></a>
			</div>
		</div>
	</div>
	<!-- ?????? -->
	<div id="body">
		<div id="body-container">
			<!-- ??????????????? ?????? ????????? -->
			<div class="nav-left-bar nav-my">
				<div class="nav-sticky">
					<ul class="list-group">
						<li class="list-group-item"><a class="nav-link" href="/CodePeople/HRMyInfo.do?memNo=1">????????????</a>						
						</li>
						
						<li class="list-group-item"><a class="nav-link"
							href="#fav-company">????????????</a></li>
						<li class="list-group-item"><a class="nav-link"
							href="#fav-jo">????????????</a></li>
						<li class="list-group-item"><a class="nav-link" href="#myCalendar">?????????</a></li>
				
						<li class="list-group-item"><a class="nav-link" href="#peoplePayment">???????????????</a></li>
							<li class="list-group-item"><a class="nav-link memInfo">????????????</a>
							<ul class="infoList">
								<li class="list-group-item"><a class="nav-link" href="/CodePeople/rehearsal/memUpdate.jsp">??????????????????</a></li>
								<li class="list-group-item"><a class="nav-link" href="/CodePeople/rehearsal/memDelete.jsp">????????????</a></li>
								<li class="list-group-item"><a class="nav-link" href="/CodePeople/rehearsal/memCertification.html">??????????????????</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
			<!-- ?????? ????????? -->
			<div id="content">
				<!-- ??????????????? -->

				<div class="content-box search-result" >
						<div class="card" style="align-items: baseline;">
						<h4 class="card-header">????????? ??????</h4>
						<div style="margin-right:50px;"></div>
						<h5 class="card-text" style="text-align: center;"><%=hrCnt %></h5>
						</div>
						<div class="card" style="align-items: baseline;">
						<h4 class="card-header">?????? ?????????</h4>
						<div style="margin-right:50px;"></div>
						<h5 class="card-text" style="text-align: center;"><%=folComList.size() %></h5>
						</div>
						<div class="card" style="align-items: baseline;">
						<h4 class="card-header">?????? ??????</h4>
						<div style="margin-right:50px;"></div>
						<h5 class="card-text" style="text-align: center;"><%=hrCnt %></h5>
						</div>
						<div class="card" style="align-items: baseline;">
						<h4 class="card-header">?????? ??????</h4>
						<div style="margin-right:50px;"></div>
						<h5 class="card-text" style="text-align: center;"><%=favComList.size() %></h5>
						</div>
						
				</div>
				<!-- ???????????? ?????? -->
				<div id="fav-company" class="content-box search-result company">
					<div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">????????????</h1>
						</div>
					</div>
					
<%
if (favComList.size()==0){
%>	
	<p style="text-align: center;">????????? ??????????????? ????????????.</p>
<%	
}else{
	for (int i = 0; i < favComList.size(); i++){
		CompanyVO favCom = favComList.get(i); 
%>
					<!-- ???????????? ?????? -->
					<div class="card" idx="<%=favCom.getComNo()%>">
						<!-- ????????? ?????????????????? ???????????? ???????????? src alt??? ?????? ???-->
						<div class="card-left">
						<img src="/CodePeople/images/logo<%=i %>.png" alt="Card image" style="width:64px; height: 64px;">
						</div>
						<!-- ????????? ?????? -->
						<div class="card-body card-right">
							<div class="card-top-box">
								<a href="/CodePeople/CompanyDetailList.do?comNo=<%=favCom.getComNo()%>" class="card-link">
								<h4 class="card-title"><%=favCom.getComNm()%></h4></a>
							</div>
							<!-- ?????? ?????? ??????????????? ???????????? -->
							<div class="card-rating-box">
								<div class="card-rating-star">
									<!-- ???????????? ????????????????????? -->
			<% 
			if(favCom.getComRev()!=null){
				int comRevStar = Math.round(favCom.getComRev());	
				for (int j = 0; j < comRevStar; i++) {
			%>
			<span>???</span>
			<% 
				}for (int j = comRevStar; j < 5; i++) { 
			%>
			<span>???</span>
				</div>
								<div class="card-rating-text">(<%=comRevStar %>)</div>
			<% 
				} 
			}else{
			%>
			<span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
			</div>
								<div class="card-rating-text">????????????</div>
			<%	
			}
			%>
							
							</div>
							<!-- ????????? ???????????? ???????????? -->
							<a href="/CodePeople/CompanyDetailList.do?comNo=<%=favCom.getComNo()%>#review" class="card-link">??????</a>
							<a href="/CodePeople/CompanyDetailList.do?comNo=<%=favCom.getComNo()%>#board" class="card-link">?????????</a>
							<a href="/CodePeople/CompanyDetailList.do?comNo=<%=favCom.getComNo()%>#salary" class="card-link">??????</a>
							<a href="/CodePeople/CompanyDetailList.do?comNo=<%=favCom.getComNo()%>#hr" class="card-link">??????</a>
						</div>
					</div>

<%
	}
}
%>					
				
				</div>
				<!-- ???????????? ?????? -->
				<div id="fav-jo" class="content-box search-result jo">
					<div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">????????????</h1>
						</div>

					</div>
<%
if(clipList.size()==0){
%>
	<p style="text-align: center;">???????????? ????????? ????????????.</p>
<%
}else{
	for(int i = 0; i<clipList.size(); i++){
		JOCardVO clip = clipList.get(i);    
      String comSal = "";
      if (clip.getJoSal()==0){
    	  comSal="????????????";
      }else if(clip.getJoSal()<=2000){
    	  comSal="0-2000??????";
      }else if(clip.getJoSal()<=2500){
    	  comSal="2000-2500??????";
      }else if(clip.getJoSal()<=3000){
    	  comSal="2500-3000??????";
      }else if(clip.getJoSal()<=4000){
    	  comSal="3000-4000??????";
      }else if(clip.getJoSal()<=5000){
    	  comSal="4000-5000??????";
      }else{
    	  comSal="5000?????? ??????";
      }
 	  String rank ="";
 	  if(i%2==0){
 		  rank="??????";
 	  }else{
 		 rank="??????";
 	  }
 	
 			  
%>		
					<!-- ???????????? ?????? -->
					<div class="card card-jo">
						<!-- ????????? ?????????????????? ???????????? ???????????? src alt??? ?????? ???-->
						<div class="card-left">
							<img src="/CodePeople/images/logo<%=i %>.png" alt="Card image"
								style="width: 64px; height: 64px;">
						</div>
						<!-- ????????? ?????? -->
						<div class="card-body card-right">
							<div class="card-top-box">
								<a href="/CodePeople/JOCardDetil.do?joNo=<%=clip.getJoNo()%>"><h4 class="card-title"><%=clip.getJoTitle() %></h4></a>
							</div>
							<!-- ????????? ?????? ??????, ?????? -->
							<div class="card-text card-jobs-detail-company-intro">
								<span class="company-intor"><%=clip.getComIntro() %></span>
							</div>
							<div class="card-text card-jobs-detail-company-jobgroup">
								<span class="company-jobgroup"><%=clip.getJgCodeNm() %></span>
							</div>
							<!-- ????????? ???????????? ?????? -->
							<div class="card-jobs-detail">
								<div class="divider"></div>
								<div class="jobs-detail-top">
									<div class="jobs-detail">
										<a href="#" class="card-link"><span class="jo-title"><%=clip.getComNm() %></span></a>&nbsp;&nbsp; 
										<span
											class="jo-salary jo-sm-font"><%=comSal %></span> 
											<span
											class="jo-sm-font">/</span> 
											<span
											class="jo-career jo-sm-font"><%=rank %></span>
									</div>
									
								</div>

	                   <span class="card-text jo-sm-font"><%=clip.getJgCodeNm() %></span>&nbsp;&nbsp;
                        <span class="jo-start jo-sm-font"><i class="far fa-calendar-alt">&nbsp;</i>
                        <%=clip.getJoSdate().substring(0, 4) %>.
                        <%=clip.getJoSdate().substring(4, 6) %>.
                        <%=clip.getJoSdate().substring(6) %>
                            </span>
                            &nbsp;<span class="jo-start jo-sm-font">~</span>&nbsp;
                        <span class="jo-end jo-sm-font"><i class="far fa-calendar-alt">&nbsp;</i> 
                        <%=clip.getJoEdate().substring(0, 4) %>.
                        <%=clip.getJoEdate().substring(4, 6) %>.
                        <%=clip.getJoEdate().substring(6) %>
                            </span>
							</div>
						</div>
					</div>		
<%		
	}
%>
<%	
}
%>


				</div>
				
				
				<div id="myCalendar" class="content-box"></div>

				<!-- ???????????????  -->
				<div id="peoplePayment" class="content-box  search-result payment-desc my-main-cv">
					<div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">???????????????</h1>
						</div>
					</div>
					<div class="payment-box content-box">
						<!-- ????????? ?????? -->
						<div class="card-body card-right">
						<div class="card-top-box">
								<h4 class="card-title">?????? ???????????? ??????</h4>
							</div>
							<!-- ???????????? ??????-->
							<div class="payment-top-text">
								?????? ???????????? ???????????? ?????? ???????????? ????????? ????????? ?????? ???????????? ????????? ??????????????? ?????????.<br>
								??????????????????????????? ?????? ????????? ????????????????????? ?????? ???????????????.
							</div>
						</div>
						<div class="card-body card-right preRemain">
						 <h4 class="card-title cv-title">?????? ???????????? ?????? : 9999???</h4>
						</div>
						<div class="payment-content-box">					
								<div class="content-box planbox">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="mt-1">1??????</h3>
										</div>
										<hr class="mt-5">
										<div class="panel-body">
											<p class="plan-desc">
												???????????? 1????????? <br> ?????? ?????????????????? <br> ?????????????????? ??????????
											</p>
											<p>?????????????????? ????????? ??????????????? ^^;</p>
										</div>
										<div class="panel-footer">
											<h4>29,900???</h4>
											<hr>
											<button class="btn btn-lg" id="btn1">????????????</button>
										</div>
									</div>
								</div>
								<div class="content-box planbox">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="mt-1">3??????</h3>
										</div>
										<hr class="mt-5">
										<div class="panel-body">
											<p class="plan-desc">
												?????? ??? ???????????? 3?????? ???????????? ????????????? <br> 6???????????? ??????????????? ?????? ?????????????
											</p>
											<p>
												???????????? ?????? <br> ??????????????? ??????;
											</p>
										</div>
										<div class="panel-footer">
											<h4>79,900???</h4>
											<hr>
											<button class="btn btn-lg" id="btn2">????????????</button>
										</div>
									</div>
								</div>
								<div class="content-box planbox">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="mt-1">6??????</h3>
										</div>
										<hr class="mt-5">
										<div class="panel-body">
											<p class="plan-desc">???????????? ????????????</p>
											<p>????????? ???????????? ?????? ????????? ??? ?????? ???????????? ??? ?????? ???????????? ???????????? ???????????????.</p>
											<p>????????? ????????????</p>
										</div>
										<div class="panel-footer">
											<h4>99,900???</h4>
											<hr>
											<button class="btn btn-lg" id="btn3">????????????</button>
										</div>???
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!--  ??????-->
	<div id="footer">
		<div id="footer-container"></div>
	</div>


</body>

</html>