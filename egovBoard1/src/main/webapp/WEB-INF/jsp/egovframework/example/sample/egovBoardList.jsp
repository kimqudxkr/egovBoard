<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
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
    <title><spring:message code="title.sample" /></title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/board.css'/>" />
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 내용 조회 화면 function */
        function fn_egov_select(id) {
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/boardContentView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_write() {
           	document.listForm.action = "<c:url value='/boardWriteView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList(menu) {
        	document.listForm.selectedMenu.value = menu;
        	document.listForm.action = "<c:url value='/egovBoardList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        //-->
    </script>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
    	<div id="wrapper" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9;">
	        <input type="hidden" name="selectedId" />
	        <input type="hidden" name="selectedMenu" />
	        <input type="hidden" id="menu" value="${menu}"/>
	        <div id="content_pop">
	        	<!-- 타이틀 -->
	        	<div id="title">
	        		<h2>좋은삼정병원</h2>
	        	</div>
	        	<!-- List -->
	        	<div id="nav_menu">
	        		<br/><br/><br/>
					<ul >
						<li><a class="all now" href="javascript:fn_egov_selectList('all')" >전체</a></li>
						<li><a class="untreated" href="javascript:fn_egov_selectList('untreated')">미처리</a></li>
						<li><a class="complete" href="javascript:fn_egov_selectList('complete')">처리완료</a></li>
						<li><a class="processing" href="javascript:fn_egov_selectList('processing')">처리중</a></li>
						<li><a class="hold" href="javascript:fn_egov_selectList('hold')">보류</a></li>
					</ul>
	        	</div>
	        	<div id="table">
	        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
	        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
	        			<colgroup>
	        				<col width="43"/>
	        				<col width="36"/>
	        				<col width="410"/>
	        				<col width="145"/>
	        				<col width="57"/>
	        				<col width="36"/>
	        			</colgroup>
	        			<tr>
	        				<th align="center">번호</th>
	        				<th align="center"><input type="checkbox" class="allCheck"/></th>
	        				<th align="center">제목</th>
	        				<th align="center">글쓴이</th>
	        				<th align="center">날짜</th>
	        				<th align="center">조회</th>
	        			</tr>
	        			<c:forEach var="result" items="${noticeList}" varStatus="status">
	            			<tr style="background-color:#eff1f4">
	            				<td align="center" class="listtd" style="font-weight:bold;"><c:out value="공지"/></td>
	            				<td align="center" class="listtd"><input type="checkbox" name="check"/></td>
								<td align="left" class="listtd" ><a style="color:red; font-weight:bold;" href="javascript:fn_egov_select('<c:out value="${result.idx}"/>')"><c:out value="${result.title}"/>&nbsp;</a></td>
	            				<td align="center" class="listtd"><c:out value="${result.writer}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><fmt:formatDate value="${result.regDate }" pattern="MM-dd"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.cnt}"/>&nbsp;</td>
	            			</tr>
	        			</c:forEach>
	        			<c:forEach var="result" items="${resultList}" varStatus="status">
	        				<c:set var="cnt" value="${cnt-1}"/>
	            			<tr>
	            				<td align="center" class="listtd"><c:out value="${cnt+fn:length(resultList)+1}"/></td>
	            				<td align="center" class="listtd"><input type="checkbox" name="check"/></td>
	            				<td align="left" class="listtd"><span class="${result.setting}">
									<c:choose>
										<c:when test="${result.setting=='complete'}">처리완료</c:when>
										<c:when test="${result.setting=='untreated'}">미처리</c:when>
										<c:when test="${result.setting=='processing'}">처리중</c:when>
										<c:when test="${result.setting=='hold'}">보류</c:when>
									</c:choose>
								</span>&nbsp;<a href="javascript:fn_egov_select('<c:out value="${result.idx}"/>')"><c:out value="${result.title}"/>&nbsp;</a></td>
	            				<td align="center" class="listtd"><c:out value="${result.writer}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><fmt:formatDate value="${result.regDate }" pattern="MM-dd"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.cnt}"/>&nbsp;</td>
	            			</tr>
	        			</c:forEach>
	        		</table>
	        	</div>
	        	<div id="sysbtn">
	        	  <ul>
	        	      <li>
	        	          <span class="btn_blue_l">
	        	              <a href="javascript:fn_egov_write();">글쓰기</a>
	                          <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
	                      </span>
	                  </li>
	              </ul>
	        	</div>
	        	<!-- /List -->
	        	<div id="paging">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	        		<form:hidden path="pageIndex" />
	        	</div>
	        </div>
    	</div>
    </form:form>
    <script>
    	$(document).ready(function() {
    		$('.allCheck').click(function() {
    			if($('.allCheck').prop("checked")) {
    				$("input[name=check]").prop("checked", true);
    			} else {
    				$("input[name=check]").prop("checked", false);
    			}
    		});
    		
    		//필터 적용 시 현재 적용중인 필터를 표시하는 부분
    		const menu = $('#menu').val();
    		if(menu != '') {
	    		$('#nav_menu ul li a').removeClass("now");
	    		$('#nav_menu ul li .'+menu).addClass("now");
    		}
    	})
    </script>
</body>
</html>
