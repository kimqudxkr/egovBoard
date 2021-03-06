<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/board.css'/>" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
	/* 글 내용 조회 화면 function */
	function fn_egov_select(id) {
		document.detailForm.selectedId.value = id;
	   	document.detailForm.action = "<c:url value='/boardContentView.do'/>";
	   	document.detailForm.submit();
	}
	
	/* 글 수정 화면 function */
	function checkWriter(type, replyIdx) {
		const name = $('#name').html();
		let writer;
		
		if(type === 'reply') {
			writer = $('#'+type+'_writer_'+replyIdx).text();
		} else {
			writer = $('#'+type+'_writer').text();
		}
		
		if(name === writer || name === '최고관리자')
			return true;
		else
			return false;
	}
	
	function fn_egov_updateBoard() {
		if(checkWriter('content', 0)) {
			document.detailForm.action = "<c:url value='/updateBoardView.do'/>";
			document.detailForm.submit();
		} else {
			alert("작성자가 아닙니다!");
		}
		
	}
	
	/* 글 삭제 function */
	function fn_egov_deleteBoard() {
		if(checkWriter('content', 0)) {
			if (confirm("삭제하시겠습니까?")) {
				document.detailForm.action = "<c:url value='/deleteBoard.do'/>";
				document.detailForm.submit();
			}
		} else {
			alert("작성자가 아닙니다!");
		}
	}

	/* 댓글 수정 화면 function */
	function fn_egov_updateReply(replyIdx) {
		if(checkWriter('reply', replyIdx)) {
			const writeDiv = $('.reply-write');
			const dest = $('.' + replyIdx).parent();

			writeDiv.insertBefore(dest);

			const content = $('.reply-content-' + replyIdx).html();

			$('.reply').val(content);
			
			const btnClass = $('#save_button').removeClass('write_reply');
			btnClass.addClass('modify_reply');
		} else {
			alert("작성자가 아닙니다!");
		}
	}

	/* 댓글 삭제 function */
	function fn_egov_deleteReply(replyIdx) {
		if(checkWriter('reply', replyIdx)) {
			const input = document.getElementById('replyIdx');
			input.disabled = false;
			document.detailForm.replyIdx.value = replyIdx;
			document.detailForm.action = "<c:url value='/deleteReply.do'/>";
			document.detailForm.submit();
		} else {
			alert("작성자가 아닙니다!");
		}
	}

	/* 댓글 등록 function */
	function fn_egov_save() {
		frm = document.detailForm;
		const saveBtn = $('#save_button');

		if (saveBtn.is(".write_reply")) {
			frm.action = "<c:url value='writeReply.do'/>";
		} else if(saveBtn.is('.modify_reply')){
			const input = document.getElementById('replyIdx');
			input.disabled = false;

			const classVal = $('.reply-write').prev().prev().attr('class').split('-');
			const idx = classVal[classVal.length - 1];

			document.detailForm.replyIdx.value = idx;
			document.detailForm.writer = $('#name').text();
			document.detailForm.action = "<c:url value='/updateReply.do'/>";
		}
		frm.submit();
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
</head>
<body style="text-align: center; margin: 0 auto; display: inline; padding-top: 50px;">
	<form:form commandName="replyVO" id="detailForm" name="detailForm">
		<div id="wrapper" style="display:inline-block; border-left:1px solid #dde4e9; border-right:1px solid #dde4e9;">
			<div id="content_pop" style="display: inline-block; border-left: 1px solid #dde4e9; border-right: 1px solid #dde4e9; padding: 10px; width: 750px;">
				<input type="hidden" name="idx" class="idx" value="${boardVO.idx}" />
				<input type="hidden" name="selectedId" />
				<input type="hidden" name="writer" class="writer" value="${userInfo.name}"/>
				<input type="hidden" name="replyIdx" class="replyIdx" id="replyIdx" disabled />
				<input type="hidden" name="afterBoardIdx" id="afterBoardIdx" value="${afterBoardIdx}" />
				<input type="hidden" name="beforeBoardIdx" id="beforeBoardIdx" value="${beforeBoardIdx}" />
				<input type="hidden" name="selectedMenu" value="${menu}"/>
				
				<p style="text-align: left" class="board-content">
					<strong> 
						<c:choose>
							<c:when test="${boardVO.setting=='free'}">자유게시판</c:when>
							<c:when test="${boardVO.setting=='qna'}">질문게시판</c:when>
							<c:when test="${boardVO.setting=='review'}">리뷰게시판</c:when>
							<c:when test="${boardVO.setting=='notice'}">공지</c:when>
						</c:choose> | ${boardVO.title}
					</strong>
				</p>
				<p style="text-align: left" class="board-content"><input type="checkbox" />개발여부</p>
				<p style="text-align: left" class="board-content"> 작성자 
					<strong style="padding-right: 30px;" id="content_writer">${boardVO.writer}</strong>
					<fmt:formatDate value="${boardVO.regDate }" pattern="yy-MM-dd HH:mm:ss" />
					<span style="padding-left: 15px;">조회 ${boardVO.cnt}회</span>
				</p>
				<HR>
				
				<!-- 나중에 파일도 추가해줘야댐 -->
				<c:if test="${not empty boardVO.link1}">
					<div class="linkAndFile" style="text-align:left;">
						<c:if test="${not empty boardVO.link1}">
							<div class="link1">
								<img src="<c:url value='/images/egovframework/example/small_link.png'/>" alt=""/>
								<a href="${boardVO.link1}">${boardVO.link1}</a>
								<HR>
							</div>
						</c:if>
						<c:if test="${not empty boardVO.link2}">
							<div class="link2">
								<img src="<c:url value='/images/egovframework/example/small_link.png'/>" alt=""/>
								<a href="${boardVO.link2}">${boardVO.link2}</a>
								<HR>
							</div>
						</c:if>
					</div>
				</c:if>
				<div class="btn-group">
					<div class="btn-group-left" style="padding: 10px; float: left">
						<c:if test="${beforeBoardIdx ne 0}"><button type="button" class="before">이전글</button></c:if>
						<c:if test="${afterBoardIdx ne 0}"><button type="button" class="after">다음글</button></c:if>
					</div>
					<div class="btn-group-right" style="padding: 10px; float: right">
						<button type="button" class="modify">수정</button>
						<button type="button" class="delete">삭제</button>
						<button type="button" class="list">목록</button>
						<button type="button" class="write">글쓰기</button>
					</div>
				</div>
				<BR /><BR /><BR />
				<p id="content" style="text-align: left; margin-bottom: 30px; white-space:pre-line;" class="board-content">${boardVO.content}</p>
				<BR /><BR />
				<div class="reply" align="left">
					<strong style="margin: 0;">댓글목록</strong>
					<c:if test="${empty replyList}">
						<p id="empty-reply">등록된 댓글이 없습니다.</p>
					</c:if>
					<c:if test="${not empty replyList}">
						<c:forEach var="replyList" items="${replyList}" varStatus="status">
							<hr />
							<p>
								<strong style="padding-right: 10px;" id="reply_writer_${replyList.replyIdx}"><c:out value="${replyList.writer}" /></strong>
								<span>작성일&nbsp;<fmt:formatDate value="${replyList.regDate }" pattern="yy-MM-dd HH:mm"/></span>
							</p>
							<p style="white-space:pre-line;" class="reply-content-${replyList.replyIdx}"><c:out value="${replyList.reply}"/></p>
							<br/>
							<div class="reply-menu" align="right">
								<a class="${replyList.replyIdx}" href="javascript:fn_egov_updateReply(${replyList.replyIdx})">수정</a>
								<a href="javascript:fn_egov_deleteReply(${replyList.replyIdx})">삭제</a>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<BR />
				<div class="reply-write">
					<table>
						<tr>
							<th>비밀글사용</th>
							<td style="text-align: left;"><input type="checkbox" id="secret" /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea class="reply" name="reply" rows="15"></textarea></td>
						</tr>
					</table>
					<br />
					<button type="button" id="save_button" class="write_reply">댓글등록</button>
				</div>
				<br />
				<hr />
				<div class="btn-group">
					<div class="btn-group-left" style="padding: 10px; float: left">
						<c:if test="${beforeBoardIdx ne 0}"><button type="button" class="before">이전글</button></c:if>
						<c:if test="${afterBoardIdx ne 0}"><button type="button" class="after">다음글</button></c:if>
					</div>
					<div class="btn-group-right" style="padding: 10px; float: right">
						<button type="button" class="modify">수정</button>
						<button type="button" class="delete">삭제</button>
						<button type="button" class="list">목록</button>
						<button type="button" class="write">글쓰기</button>
					</div>
				</div>
			</div>
			<div id="user-menu">
	        	 <div class="name-content"><strong id="name">${userInfo.name}</strong>님</div><br/>
	        	 <button type="button" onclick="javascript:fn_egov_myBoards();">내가 작성한 게시글</button><br/>
	        	 <button type="button" onclick='location.href="egovBoardList.do"'>게시글목록</button><br/>
	        	 <button type="button" class="logout" onclick='location.href="logout.do";'>로그아웃</button>
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
			location.href = 'javascript:fn_egov_deleteBoard();';
		})

		$('.write_reply').click(function() {
			location.href = 'javascript:fn_egov_save();';
		})
		
		$('.before').click(function() {
			const beforeIdx = $('#beforeBoardIdx').val();

			location.href = 'javascript:fn_egov_select('+beforeIdx+');';
		})
		
		$('.after').click(function() {
			const nextIdx = $('#afterBoardIdx').val();

			location.href = 'javascript:fn_egov_select('+nextIdx+');';
		})
	});
</script>
</html>