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
    <c:set var="registerFlag" value="${boardVO.idx == 0 ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/board.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="boardVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/egovBoardList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteBoard.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
	      	frm.action = "<c:url value="${registerFlag == 'create' ? '/boardWrite.do' : '/updateBoard.do'}"/>";
	        frm.submit();
        }
        -->
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<form:form commandName="boardVO" id="detailForm" name="detailForm">
		<div id="wrapper" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9;">
		    <div id="content_pop" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9; padding:10px; width:750px">
				<form:input path="writer" maxlength="30" cssClass="txt" size="40" value="${userInfo.name}" type="hidden"/>		    	
		    	<!-- 타이틀 -->
		    	<div id="title">
		    		<h2>
		    			<c:if test="${registerFlag == 'create'}">좋은삼정병원 글쓰기</c:if>
	                    <c:if test="${registerFlag == 'modify'}">좋은삼정병원 글수정</c:if>
		    		</h2>
		    	</div>
		    	<!-- // 테이블 -->
		    	<div id="table">
		    	<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
		    		<colgroup>
		    			<col width="150"/>
		    			<col width="?"/>
		    		</colgroup>
		    		<c:if test="${registerFlag == 'modify'}">
		        		<tr>
		        			<td class="tbtd_caption"><label for="idx">idx</label></td>
		        			<td class="tbtd_content">
		        				<form:input path="idx" cssClass="essentiality" maxlength="10" readonly="true" />
		        			</td>
		        		</tr>
		    		</c:if>
		    		<tr>
		    			<td class="tbtd_caption"><label for="option">옵션</label></td>
		    			<td class="tbtd_content">
							<input type="checkbox"/>공지
							<input type="checkbox"/>html
		    			</td>
		    		</tr>
		    		<tr>
		    			<td class="tbtd_caption"><label for="setting">분류</label></td>
		    			<td class="tbtd_content">
		    				<form:select path="setting" cssClass="use">
		    					<form:option value="untreated" label="미처리" />
		    					<form:option value="complete" label="처리완료"/>
		    					<form:option value="processing" label="처리중"/>
		    					<form:option value="hold" label="보류" />
		    					<form:option value="notice" label="공지" />
		    				</form:select>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td class="tbtd_caption"><label for="title">제목</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="title" maxlength="30" cssClass="txt" size="40" autocomplete='off'/>
		    				&nbsp;<form:errors path="title" />
		    			</td>
		    		</tr>
		    		<tr>
		    			<td class="tbtd_caption"><label for="content">내용</label></td>
		    			<td class="tbtd_content">
		    				<form:textarea path="content" rows="15" style="width:100%;"/>&nbsp;<form:errors path="content" />
		                </td>
		    		</tr>
		    		<tr>
		    			<td class="tbtd_caption"><label for="link1">링크1</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="link1" maxlength="30" cssClass="txt" size="40" autocomplete='off'/>&nbsp;<form:errors path="link1" />
		                </td>
		    		</tr>
		    		<tr>
		    			<td class="tbtd_caption"><label for="link2">링크2</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="link2" maxlength="30" cssClass="txt" size="40" autocomplete='off'/>&nbsp;<form:errors path="link2" />
		                </td>
		    		</tr>
		    	</table>
		      </div>
		    	<div id="sysbtn">
		    		<ul>    			
		    			<li>
		                    <span class="btn_blue_l">
		                        <a href="javascript:fn_egov_save();">작성완료</a>
		                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
		                    </span>
		                </li>
		                <li>
		                    <span class="btn_blue_l">
		                        <a href="javascript:fn_egov_selectList();">취소</a>
		                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
		                    </span>
		                </li>
		    			<c:if test="${registerFlag == 'modify'}">
		                    <li>
		                        <span class="btn_blue_l">
		                            <a href="javascript:fn_egov_delete();">삭제</a>
		                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
		                        </span>
		                    </li>
		    			</c:if>
		            </ul>
		    	</div>
		    	<!-- 검색조건 유지 -->
			    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
			    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
			    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		    </div>
		    <div id="user-menu">
	        	 <div class="name-content"><strong id="name">${userInfo.name}</strong>님</div><br/>
	        	 <button type="button">관리자 모드</button><br/>
	        	 <button type="button">유지보수게시판메인</button><br/>
	        	 <button type="button">미처리 게시글 확인</button><br/>
	        	 <button type="button" class="logout" onclick='location.href="logout.do";'>로그아웃</button>
	        </div>
		</div>
	</form:form>
</body>
</html>