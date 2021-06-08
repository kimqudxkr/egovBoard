<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/board.css'/>" />
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
	/* 로그인 function */
	function fn_egov_join() {
		if($('.id').val() !== '') {
			console.log("값 있음");
		} else {
			console.log("값 없음");
		}
// 		document.detailForm.action = "<c:url value='/startJoin.do'/>";
// 		document.detailForm.submit();
	}
-->
</script>
</head>
<body style="background-color:#eeeeee; margin-top:100px;">
	<input type="hidden" value="${result}" id="noResult"/>
	<div style="text-align:center;">
		<h2>회원가입</h2>
		<div class="joinDiv">
			<form:form commandName="LoginVO" id="detailForm" name="detailForm">
				<div class="inputDiv">
					<div class="inputDiv-left">
						<p>회원아이디</p>
						<p>비밀번호</p>
						<p>비밀번호 확인</p>
						<p>이름</p>
					</div>
					<div class="inputDiv-right">
						<p><form:input path="id" type="text" class="id"/></p>
						<p><form:input path="password" type="password" class="password"/></p>
						<p><input type="password" class="confirmPassword"/></p>
						<p><form:input path="name" type="text" clsas="name"/></p>
					</div>
				</div>
				<div class="joinBtnDiv">
					<button type="button" class="joinBtn">회원가입</button>
					<button type="button" class="cancel">취소</button>
				</div>
			</form:form>
		</div>
	</div>
</body>
<script>
	$(function() {
		//로그인 버튼 누를 시
		$('.joinBtn').click(function() {
			location.href = 'javascript:fn_egov_join();';
		})
		
		//취소 버튼 누를 시
		$('.cancel').click(function() {
			window.history.back();
		})
	});
</script>
</html>