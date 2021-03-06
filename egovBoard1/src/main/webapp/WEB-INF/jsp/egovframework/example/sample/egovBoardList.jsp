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
        	document.listForm.selectedMenu.value = $('#menu').val();
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/boardContentView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_write() {
           	document.listForm.action = "<c:url value='/boardWriteView.do'/>";
           	document.listForm.submit();
        }
        
        /* 필터링 적용 function */
        function fn_egov_selectList(menu) {
        	document.listForm.selectedMenu.value = menu;
        	document.listForm.action = "<c:url value='/egovBoardList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovBoardList.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 검색 function */
        function fn_egov_selectListBySearch(menu) {
        	document.listForm.selectedMenu.value = menu;
        	document.listForm.action = "<c:url value='/egovBoardListBySearch.do'/>";
           	document.listForm.submit();
        }
        
        /* 내가 작성한 게시글 function */
        function fn_egov_myBoards() {
        	const name = $('#name').text();
        	$('#searchValue').val(name);
        	$('#searchType option:eq(4)').prop("selected", true);
        	
        	document.listForm.action = "<c:url value='/egovBoardListBySearch.do'/>";
        	document.listForm.submit();
        }
        -->
    </script>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
    	<div id="wrapper" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9;">
	        <input type="hidden" name="selectedId" />
	        <input type="hidden" name="selectedMenu" />
	        <input type="hidden" name="menu" id="menu" value="${menu}"/>
	        <input type="hidden" name="idxCnt" id="idxCnt" value="${idxCnt}" />
	        <!-- 유저 메뉴 -->
	        <div id="user-menu">
	        	 <div class="name-content"><strong id="name">${userInfo.name}</strong>님</div><br/>
	        	 <button type="button" onclick="javascript:fn_egov_myBoards();">내가 작성한 게시글</button><br/>
	        	 <button type="button" onclick='location.href="egovBoardList.do"'>게시글목록</button><br/>
	        	 <button type="button" class="logout" onclick='location.href="logout.do";'>로그아웃</button>
	        </div>
	        <div id="content_pop">
	        	<!-- 타이틀 -->
	        	<div id="title">
	        		<h2>게시글목록</h2>
	        	</div>
	        	<!-- 게시글 필터 메뉴 -->
	        	<div id="nav_menu">
	        		<br/><br/><br/>
					<ul >
						<li><a class="all now" href="javascript:fn_egov_selectList('all')" >전체 게시글</a></li>
						<li><a class="free" href="javascript:fn_egov_selectList('free')">자유 게시판</a></li>
						<li><a class="qna" href="javascript:fn_egov_selectList('qna')">질문 게시판</a></li>
						<li><a class="review" href="javascript:fn_egov_selectList('review')">리뷰 게시판</a></li>
					</ul>
	        	</div>
	        	<!-- 게시글들이 표시될 테이블 -->
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
	        			<!-- 공지 게시글들 표시 부분 -->
	        			<c:forEach var="result" items="${noticeList}" varStatus="status">
	            			<tr style="background-color:#eff1f4">
	            				<td align="center" class="listtd" style="font-weight:bold;"><c:out value="공지"/></td>
	            				<td align="center" class="listtd">
	            					<c:if test="${userInfo.name eq result.writer || userInfo.name eq '최고관리자'}">
	            						<input type="checkbox" name="check" class="check_${result.idx}"/>
            						</c:if>
	            				</td>
								<td align="left" class="listtd" >
									<a style="color:red; font-weight:bold;" href="javascript:fn_egov_select('<c:out value="${result.idx}"/>')">
										${result.title} 
										<strong class="replyCnt"><c:if test="${not empty result.replyCnt}">[${result.replyCnt}]</c:if></strong>&nbsp;
									</a>
								</td>
	            				<td align="left" class="listtd"><c:out value="${result.writer}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><fmt:formatDate value="${result.regDate }" pattern="MM-dd"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.cnt}"/>&nbsp;</td>
	            			</tr>
	        			</c:forEach>
	        			<!-- 일반 게시글들 표시 부분 -->
	        			<c:forEach var="result" items="${resultList}" varStatus="status">
	        				<c:set var="cnt" value="${cnt-1}"/>
	            			<tr>
	            				<td align="center" class="listtd"><c:out value="${cnt+1+nonNotice-(pageIndex-1)*15}"/></td>
	            				<td align="center" class="listtd">
	            					<c:if test="${userInfo.name eq result.writer || userInfo.name eq '최고관리자'}">
	            						<input type="checkbox" name="check" class="check_${result.idx}"/>
	            					</c:if>
	            				</td>
	            				<td align="left" class="listtd"><span class="${result.setting}">
									<c:choose>
										<c:when test="${result.setting=='free'}">자유</c:when>
										<c:when test="${result.setting=='qna'}">질문</c:when>
										<c:when test="${result.setting=='review'}">리뷰</c:when>
									</c:choose>
								</span>&nbsp;
									<a href="javascript:fn_egov_select('<c:out value="${result.idx}"/>')">
										${result.title} 
										<strong><c:if test="${not empty result.replyCnt}">[${result.replyCnt}]</c:if></strong>
										<c:if test="${not empty result.link1}">
											<img src="<c:url value='/images/egovframework/example/small_link.png'/>" alt=""/>
										</c:if>
									</a></td>
	            				<td align="left" class="listtd"><c:out value="${result.writer}"/></td>
	            				<td align="center" class="listtd"><fmt:formatDate value="${result.regDate }" pattern="MM-dd"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.cnt}"/>&nbsp;</td>
	            			</tr>
	        			</c:forEach>
	        		</table>
	        	</div>
	        	<!-- 하단 버튼들 -->
	        	<div class="btn-group">
					<div class="btn-group-left" style="padding: 10px; float: left">
						<button type="button" class="delete_select">선택삭제</button>
					</div>
					<div class="btn-group-right" style="padding: 10px; float: right">
						<button type="button" class="write" onclick='javascript:fn_egov_write();'>글쓰기</button>
					</div>
				</div>
	        	<!-- 페이징 -->
	        	<div id="paging">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	        		<form:hidden path="pageIndex" />
	        	</div>
	        	<!-- 검색 메뉴 -->
	        	<div id="search-menu">
	        		<select name="searchType" id="searchType" class="search-select">
	        			<option value="" <c:if test="${searchType eq ''}">selected</c:if>>선택</option>
	        			<option value="title" <c:if test="${searchType eq 'title'}">selected</c:if>>제목</option>
	        			<option value="content" <c:if test="${searchType eq 'content'}">selected</c:if>>내용</option>
	        			<option value="titleOrContent" <c:if test="${searchType eq 'titleOrContent'}">selected</c:if>>제목+내용</option>
	        			<option value="writer" <c:if test="${searchType eq 'writer'}">selected</c:if>>글쓴이</option>
	        		</select>
	        		<input type="text" class="search-input" id="searchValue" name="searchValue" value="${searchValue}"/>
	        		<button type="button" class="search-btn" onclick="javascript:fn_egov_selectListBySearch('${menu}');">검색</button>
	        	</div>
	        </div>
	        
    	</div>
    </form:form>
    <script>
    	$(document).ready(function() {
    		//표 제목의 체크박스를 선택 시 전부 선택되는 효과
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
    		
    		//선택 삭제 버튼 클릭 시
    		$('.delete_select').click(function() {
    			const checkArr = [];
				$('input[name=check]:checked').each(function() {
					const check = $(this).attr('class');
					const words = check.split('_');
					
					checkArr.push(words[1]);
				})
				
				const objParams = {
					"idxs": checkArr
				};
				
				if(checkArr.length !== 0) {
					if(confirm("선택한 게시글을 삭제하시겠습니까?")) {
						$.ajax({
							url:"deleteBoardMany.do",
							data: objParams,
							type:'POST',
							success : function(result) {
		 						location.reload();
							},
							error : function(request, status, error) {
								console.log("=========error=======");
								console.log("request : "+request.getOwnPropertyNames());
								console.log("status : "+status);
								console.log("error : "+error);
							}
						});
					}
				} else
					alert("하나 이상 선택하세요");
    		});
    		
    		//미처리 게시글 확인 버튼 누를 시
    		$('.checkUntreated').click(function() {
    			location.href = 'javascript:fn_egov_selectList(\'untreated\');';
    		})
    	})
    </script>
</body>
</html>
