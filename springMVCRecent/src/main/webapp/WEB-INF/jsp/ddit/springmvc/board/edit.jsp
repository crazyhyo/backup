<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty boardVO.boardSn ? 'create' : 'modify'}"/>
    <title>게시판 <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="boardVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/board/retrievePagingList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/board/delete.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        	
        	if(!validateBoardVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/board/create.do' : '/board/update.do'}"/>";
                frm.submit();
            }
        }
        
        function fncFileDown(boardSn, sequenceNo){
        	document.detailForm.action = "<c:url value='/board/fileDown.do'/>";
        	document.detailForm.boardSn.value = boardSn;
        	document.detailForm.sequenceNo.value = sequenceNo;
           	document.detailForm.submit();
        }
        -->
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="boardVO" enctype="multipart/form-data" id="detailForm" name="detailForm">
	<!-- 검색조건 유지 -->    
    <form:hidden path="boardSn" />
    <form:hidden path="sequenceNo" />
    <form:hidden path="searchCondition" />
    <form:hidden path="searchKeyword" />
    <form:hidden path="pageIndex" />
    <form:hidden path="saveToken" />
    
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </li>
    		</ul>
    	</div>
    	<!-- // 타이틀 -->
    	<div id="table">
    	<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
    		<colgroup>
    			<col width="150"/>
    			<col width="?"/>
    		</colgroup>    		
    		<tr>
    			<td class="tbtd_caption"><label for="title">제목</label></td>
    			<td class="tbtd_content">
    				<form:input path="title" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="title" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="openYn">공개여부</label></td>
    			<td class="tbtd_content">
    				<form:select path="openYn" cssClass="use">
    					<form:option value="Y" label="공개" />
    					<form:option value="N" label="비공개" />
    				</form:select>
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="contents">내용</label></td>
    			<td class="tbtd_content">
    				<form:textarea path="contents" rows="5" cols="58" />&nbsp;<form:errors path="contents" />
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="writer">작성자</label></td>
    			<td class="tbtd_content">
                    <form:input path="writer" maxlength="10" cssClass="txt"  />
        				&nbsp;<form:errors path="writer" />
        		</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="userPassword">비밀번호</label></td>
    			<td class="tbtd_content">
                    <form:password path="userPassword" maxlength="10" cssClass="txt"  />
        				&nbsp;<form:errors path="userPassword" />
        		</td>
    		</tr>
    		<tr>
				<td class="tbtd_caption"><label for="file">첨부파일</label></td>
				<td class="tbtd_content">
					<c:forEach var="attachFileVO" items="${boardVO.attachFileVOList}">						
						<a id="file_<c:out value="${attachFileVO.boardSn}"/>_<c:out value="${attachFileVO.sequenceNo}"/>" href="javascript:fncFileDown('<c:out value="${attachFileVO.boardSn}"/>','<c:out value="${attachFileVO.sequenceNo}"/>')"><c:out value="${attachFileVO.fileSrcName}"/></a>
					</c:forEach>
	    			<input type="file" name="file"/>
	    		</td>
			</tr>
    	</table>
      </div>
    	<div id="sysbtn">
    		<ul>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();"><spring:message code="button.list" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_save();">
                            <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                            <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                        </a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<c:if test="${registerFlag == 'modify'}">
                    <li>
                        <span class="btn_blue_l">
                            <a href="javascript:fn_egov_delete();"><spring:message code="button.delete" /></a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                    </li>
    			</c:if>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();"><spring:message code="button.reset" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
            </ul>
    	</div>
    </div>
    
</form:form>
</body>
</html>