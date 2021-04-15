<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 수정 화면 function */
        function fn_egov_select(id) {
        	console.log("id : "+id);
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/updateBoardView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_write() {
           	document.listForm.action = "<c:url value='/boardWriteView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
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
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/board.css'/>" />
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" />
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>&nbsp;좋은삼정병원</li>
        		</ul>
        	</div>
<!-- 			<ul class="navi-bar"> -->
<!-- 				<li><a href="https://www.naver.com">전체</a></li> -->
<!-- 				<li><a href="https://www.naver.com">미처리</a></li> -->
<!-- 				<li><a href="https://www.naver.com">처리완료</a></li> -->
<!-- 				<li><a href="https://www.naver.com">처리중</a></li> -->
<!-- 				<li><a href="https://www.naver.com">보류</a></li> -->
<!-- 			</ul> -->
        	<!-- List -->
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
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<td align="center" class="listtd"><c:out value="${result.idx}"/></td>
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
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
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
    		})
    	})
    </script>
</body>
</html>
