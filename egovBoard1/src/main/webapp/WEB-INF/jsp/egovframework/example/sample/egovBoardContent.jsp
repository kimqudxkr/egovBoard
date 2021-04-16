<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 수정 화면 function */
        function fn_egov_updateBoard() {
           	document.detailForm.action = "<c:url value='/updateBoardView.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_deleteBoard() {
           	document.detailForm.action = "<c:url value='/deleteBoard.do'/>";
           	document.detailForm.submit();
        }
        -->
    </script>
</head>
<body style="text-align:left; margin:0 auto; display:inline; padding-top:100px;">
<form:form commandName="boardVO" id="detailForm" name="detailForm">
	<div id="content_pop">
		<input type="hidden" name="idx" class="idx" value="${boardVO.idx}"/>
		<p><strong>
			<c:choose>
				<c:when test="${boardVO.setting=='complete'}">처리완료</c:when>
				<c:when test="${boardVO.setting=='untreated'}">미처리</c:when>
				<c:when test="${boardVO.setting=='processing'}">처리중</c:when>
				<c:when test="${boardVO.setting=='hold'}">보류</c:when>
			</c:choose> | ${boardVO.title}</strong></p>
		<p><input type="checkbox"/>개발여부</p>
		<p>작성자<strong>${boardVO.writer} ${boardVO.idx}</strong>(222.96.6.150) <fmt:formatDate value="${boardVO.regDate }" pattern="yy-MM-dd HH:mm:ss"/> 조회 ${boardVO.cnt}</p>
		<HR>
		<div class="btn-group">
			<button type="button" class="modify">수정</button>
			<button type="button" class="delete">삭제</button>
			<button type="button" class="list">목록</button>
			<button type="button" class="write">글쓰기</button>
		</div>
		<p>${boardVO.content}</p>
	</div>
</form:form>
</body>
<script>
	$(function() {
		$('.list').click(function() {
			location.href = 'egovBoardList.do';
		})
		
		$('.modify').click(function() {
			location.href = 'javascript:fn_egov_updateBoard();';
		})
		
		$('.delete').click(function() {
			if(confirm("삭제하시겠습니까?")) {
				location.href = 'javascript:fn_egov_deleteBoard();';
			}
		})
	});
</script>
</html>