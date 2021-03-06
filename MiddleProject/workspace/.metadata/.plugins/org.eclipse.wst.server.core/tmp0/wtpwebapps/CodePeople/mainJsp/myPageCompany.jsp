<%@page import="kr.or.ddit.hr.vo.HRMyInfoVO"%>
<%@page import="kr.or.ddit.hr.vo.HRInfoVO"%>
<%@page import="kr.or.ddit.jobOpening.service.JobOpeningServiceImpl"%>
<%@page import="kr.or.ddit.jobOpening.service.IJobOpeningService"%>
<%@page import="kr.or.ddit.jobOpening.vo.JOCardVO"%>
<%@page import="kr.or.ddit.hr.vo.HRCardVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.hr.service.HRServiceImpl"%>
<%@page import="kr.or.ddit.hr.service.IHRService"%>
<%@page import="kr.or.ddit.company.vo.CompanyVO"%>
<%@page import="kr.or.ddit.company.service.CompanyServiceImpl"%>
<%@page import="kr.or.ddit.company.service.ICompanyService"%>
<%@page import="kr.or.ddit.cmm.util.SessionCheck"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


MemberVO loginMember = session.getAttribute("memVO") == null?
            null : (MemberVO)session.getAttribute("memVO");


    int memCode = loginMember.getMemCode();
	
    int comNo = SessionCheck.getComNo(session, request);
    
 	   
    
    
    IHRService hrService = HRServiceImpl.getInstance();
    List<HRCardVO> folHRList = hrService.getFolHR(comNo);
    List<HRCardVO> favHRList = hrService.getFavHR(comNo);
    
    IJobOpeningService joService = JobOpeningServiceImpl.getInstance();
    List<JOCardVO> clipList = joService.getClipByCom(comNo);
	List<JOCardVO> applyList = joService.getApplyByCom(comNo);
    
    ICompanyService comService = CompanyServiceImpl.getInstance();
    CompanyVO com = comService.getCompany(comNo);
  
    
    int applyCnt = 0;
    if(applyList.size()>0){	
    	 for(int i = 0; i<applyList.size(); i++){
 	 	 	JOCardVO jo = applyList.get(i);	
 	 	 	int joNo = jo.getJoNo();
 	 	 	List<HRMyInfoVO> hrList = hrService.selectApplyHRByJo(joNo);
 	 	 	for(int j = 0; j < hrList.size(); j++){
 	 	 		applyCnt++;
 	 	 	}  	
 	 	 	}
    }else{
    	applyCnt=0;
    }
    
    
    
    
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


<!-- ????????????????????? ?????? -->
<script src="../js/prod.js"></script>

<!-- ?????????????????? ???????????? -->
<script type="text/javascript">
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
				<a href="/CodePeople/rehearsal/home.html" id="logo"><i class="fas fa-copyright"
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
				<a href="/CodePeople/rehearsal/home.html"><button id="header-login-btn" class="btn btn-primary btn-sm">????????????</button></a>
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
					<li class="list-group-item"><a class="nav-link"
							href="/CodePeople/mainJsp/companyInsert.jsp">????????????</a></li>				
						<li class="list-group-item"><a class="nav-link"
							href="#my-jo">????????????</a></li>
						<li class="list-group-item"><a class="nav-link"
							href="#fav-hr">????????????</a></li>		
							<li class="list-group-item"><a class="nav-link"
							href="#apply-hr">????????????</a></li>							
						<li class="list-group-item"><a class="nav-link" href="#peoplePayment">???????????????</a></li>
						<li class="list-group-item"><a class="nav-link memInfo" href="#">????????????</a>
							<ul class="infoList">
								<li class="list-group-item"><a class="nav-link"
									href="/CodePeople/rehearsal/memUpdate.jsp">??????????????????</a></li>
								<li class="list-group-item"><a class="nav-link" href="/CodePeople/rehearsal/memDelete.jsp">????????????</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
      <div id="content">
      
      
      
      
      
      	<div class="content-box search-result" >
						<div class="card" style="align-items: baseline;">
							<h4 class="card-header">????????? ?????????</h4>
							<div style="margin-right:50px;"></div>
							<h5 class="card-text" style="text-align: center;"><%=clipList.size() %></h5>
						</div>
						<div class="card" style="align-items: baseline;">
							<h4 class="card-header">???????????? ?????????</h4>
							<div style="margin-right:50px;"></div>
							<h5 class="card-text" style="text-align: center;"><%=folHRList.size() %></h5>
						</div>
						<div class="card" style="align-items: baseline;">
							<h4 class="card-header">???????????? ??????</h4>
							<div style="margin-right:50px;"></div>
							<h5 class="card-text" style="text-align: center;"><%=applyCnt %></h5>
						</div>
							<div class="card" style="align-items: baseline;">
							<h4 class="card-header">?????? ??????</h4>
							<div style="margin-right:50px;"></div>
						<%
						if (com.getComRev()==null){
							%>
						<h5 class="card-text" style="text-align: center;">0</h5>
							<% 
						} else{
						%>
						<h5 class="card-text" style="text-align: center;"><%=com.getComRev() %></h5>
						
						<%
						}
						%>
						</div>
						
				</div>
				
				
								
				
				<!-- ???????????? ?????? -->
				<div id="my-jo" class="content-box search-result jo">
					<div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">?????? ??????</h1>
						</div>

					</div>
<%
if(clipList.size()==0){
%>
	<p style="text-align: center;">????????? ?????? ????????? ????????????.</p>
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
			
					
			


        <div id="fav-hr" class="content-box search-result human">
          <div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">????????????</h1>
						</div>
					</div>
<%

if (favHRList.size()==0){
%>
	<p style="text-align: center;">????????? ??????????????? ????????????.</p>
		
<% 
}else{
	for(int i = 0 ; i < favHRList.size(); i++){
	HRCardVO favHR = favHRList.get(i);
	String imageHref = "/CodePeople/images/profile" + (int)Math.floor(Math.random() * 20) + ".jpg";
%>		
	 <div class="card">
              <!-- ????????? ?????????????????? ???????????? ???????????? src alt??? ?????? ???-->
              <div class="card-left">
             <img src="/CodePeople/images/imgHr.png" alt="Card image" style="width:64px; height: 64px;">
							 </div>
              <!-- ????????? ?????? -->
              <div class="card-body card-right">
               		 <div class="card-top-box">
							<a href="/CodePeople/HRDetail.do?hrNo=<%= favHR.getHrNo()%>"><h4 class="card-title"><%=favHR.getMemNm()%></h4></a>
	    			      <!-- ????????? ???????????? ??????, ??????, ???????????? -->
                		</div>
                	 <div class="card-text">
                  		<span class="job-title"><%=favHR.getJtCodeNm() %></span>
                 	</div>
                 	<a href="#" class="job-current card-link"><%=favHR.getHrCurrCom() %></a>
                 	<div class="card-text">
                   <span class="job-language"><%=favHR.getPlCodeNm() %></span>
                 	</div>
             </div>
         		
         	</div>
         	
         	
<%	
	}	
}
%>					
			</div>		
                      
                   
         
                   
                   
       
       <div id="apply-hr" class="content-box  ">
          <div class="my-box-item">
						<div class="my-box-header">
							<h1 class="h1">????????????</h1>
						</div>
		  </div>
<%

if(applyList.size()==0){
%>
	<p style="text-align: center;">????????? ????????? ????????? ????????? ????????????.</p>
<% 
	
}else{
	 	 for(int i = 0; i<applyList.size(); i++){
	 	 	JOCardVO jo = applyList.get(i);	
	 	 	int joNo = jo.getJoNo();
	 	 	List<HRMyInfoVO> hrList = hrService.selectApplyHRByJo(joNo);
%>
<div id="accordion" >
	    <div class="content-box" style="display:flex; flex-direction: column;">
	     			 <div class="card-header">
					  	<a class="btn title-btn" data-bs-toggle="collapse" href="#<%=i%>">
					 <label style="font-weight: bold;">????????????&nbsp;</label>&nbsp;&nbsp;:&nbsp;&nbsp;<span class="board-title"><%=jo.getJoNo()%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<label style="font-weight: bold;">????????????&nbsp;</label>&nbsp;&nbsp;:&nbsp;&nbsp;<span class="board-title"><%=jo.getJtCodeNm()%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<label style="font-weight: bold;">????????????&nbsp;</label>&nbsp;&nbsp;:&nbsp;&nbsp;<span class="board-title"><%=jo.getPlCodeNm()%></span>
					</a>
	                 </div>
	                        <div id="collapseOne" class="collapse show" data-bs-parent="#<%=i%>" >
	   					
<% 
			if(hrList.size()==0){
%>
					 	 	<p style="text-align: center;">??????????????? ????????? ????????? ????????????.</p>
<%
		}else{
			for(int j = 0; j < hrList.size(); j++){
					 	 			
					 	 		 HRMyInfoVO	hr = hrList.get(j); 
%>								<div class="card-body">	
					 	 		 <a href="/CodePeople/HRDetail.do?hrNo=<%=hr.getHrNo()%>"><span class="card-title"><%=hr.getMemNm()%></span></a><br>
					             <label for="">????????????&nbsp;</label>:&nbsp;&nbsp;<span class="board-title eduCodeNm" ><%=hr.getHrCmt()%></span><br>
					             <label for="">??????&nbsp;</label>:&nbsp;&nbsp;<span class="board-title eduSchNm" ><%=hr.getJtCodeNm()%></span><br>
					             <label for="">????????????&nbsp;</label>:&nbsp;&nbsp;<span class="board-title eduMajor" ><%=hr.getHrSal()%></span><br> 			
					 			</div> 	
					 		
	<%		
				}			 	 		
					 	 		
			}
					 	 		
	%>	 	 	
							</div>
</div>
	<%
		 }

		}
	 %>		 
 </div>	





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
								????????? ????????? ????????? ??? ????????? ??????????????? ?????????.<br>
								????????? ?????????????????? ???????????? ??????????????? ?????? ???????????????!
							</div>
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
												???????????? 1????????? <br> ?????? ????????????????????? <br> ?????????????????? ??????????
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
											<p>????????? ???????????? ?????? ????????? ??? ?????? ???????????? ??? ?????? ????????? ?????? ??? ???????????????.</p>
											<p>????????? ????????????</p>
										</div>
										<div class="panel-footer">
											<h4>99,900???</h4>
											<hr>
											<button class="btn btn-lg" id="btn3">????????????</button>
										</div>
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