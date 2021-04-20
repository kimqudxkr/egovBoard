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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/board.css'/>" />
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
        
        /* 댓글 삭제 function */
        function fn_egov_deleteReply(replyIdx) {
        	document.detailForm.replyIdx.value = replyIdx;
           	document.detailForm.action = "<c:url value='/deleteReply.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
           	frm.action = "<c:url value='writeReply.do'/>";
            frm.submit();
        }
        -->
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:50px;">
	<form:form commandName="replyVO" id="detailForm" name="detailForm">
		<div id="content_pop" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9; padding:10px; width:750px" >
			<input type="hidden" name="idx" class="idx" value="${boardVO.idx}"/>
			<input type="hidden" name="writer" class="writer" value="최고관리자"}/>
			<input type="hidden" name="replyIdx" class="replyIdx"/>
			<p style="text-align:left"><strong>
				<c:choose>
					<c:when test="${boardVO.setting=='complete'}">처리완료</c:when>
					<c:when test="${boardVO.setting=='untreated'}">미처리</c:when>
					<c:when test="${boardVO.setting=='processing'}">처리중</c:when>
					<c:when test="${boardVO.setting=='hold'}">보류</c:when>
					<c:when test="${boardVO.setting=='notice'}">공지</c:when>
				</c:choose> | ${boardVO.title}</strong></p>
			<p style="text-align:left"><input type="checkbox" />개발여부</p>
			<p style="text-align:left">작성자
				<strong style="padding-right:30px;">${boardVO.writer}</strong>
				<fmt:formatDate value="${boardVO.regDate }" pattern="yy-MM-dd HH:mm:ss"/> 
				<span style="padding-left:15px;">조회 ${boardVO.cnt}회</span>
			</p>
			<HR>
			<div class="btn-group">
				<div class="btn-group-left" style="padding:10px; float:left">
					<button type="button" class="before">이전글</button>
					<button type="button" class="after">다음글</button>
				</div>
				<div class="btn-group-right" style="padding:10px; float:right">
					<button type="button" class="modify">수정</button>
					<button type="button" class="delete">삭제</button>
					<button type="button" class="list">목록</button>
					<button type="button" class="write">글쓰기</button>
				</div>
			</div>
			<BR/><BR/>
			<p id="content" style="text-align:left; margin-bottom:30px;">${boardVO.content}</p>
			<BR/><BR/>
			<div class="reply" align="left">
				<strong style="margin:0;">댓글목록</strong>
				<c:if test="${empty replyList}"><p id="empty-reply">등록된 댓글이 없습니다.</p></c:if>
				<c:if test="${not empty replyList}">
					<c:forEach var="replyList" items="${replyList}" varStatus="status">
						<hr/>
						<p>
							<strong style="padding-right:10px;"><c:out value="${replyList.writer}"/></strong><span>작성일&nbsp;<fmt:formatDate value="${replyList.regDate }" pattern="yy-MM-dd HH:mm"/></span>
						</p>
						<p><c:out value="${replyList.reply}"/></p>
						<div class="reply-menu" align="right">
							<a href="/">수정</a>
							<a href="javascript:fn_egov_deleteReply(${replyList.replyIdx})">삭제</a>
						</div>
        			</c:forEach>
				</c:if>
			</div>
			<BR/>
			<div class="reply-write">
				<table>
					<tr>
						<th>비밀글사용</th>
						<td style="text-align:left;"><input type="checkbox" id="secret"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea class="reply" name="reply" rows="15"></textarea></td>
					</tr>
				</table>
				<br/>
				<button type="button" class="write_reply">댓글등록</button>
			</div>
			<br/>
			<hr/>
			<div class="btn-group">
				<div class="btn-group-left" style="padding:10px; float:left">
					<button type="button" class="before">이전글</button>
					<button type="button" class="after">다음글</button>
				</div>
				<div class="btn-group-right" style="padding:10px; float:right">
					<button type="button" class="modify">수정</button>
					<button type="button" class="delete">삭제</button>
					<button type="button" class="list">목록</button>
					<button type="button" class="write">글쓰기</button>
				</div>
			</div>
		</div>
	</form:form>
</body>
<script>
	$(function() {
		$('.list').click(function() {
			location.href = 'egovBoardList.do';
		})
		
		$('.write').click(function() {
			location.href = 'boardWriteView.do';
		})
		
		$('.modify').click(function() {
			location.href = 'javascript:fn_egov_updateBoard();';
		})
		
		$('.delete').click(function() {
			if(confirm("삭제하시겠습니까?")) {
				location.href = 'javascript:fn_egov_deleteBoard();';
			}
		})
		
		$('.write_reply').click(function() {
			location.href = 'javascript:fn_egov_save();';
		})
	});
</script>
</html>