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
		if(($('.id').val() !== '') && ($('.password').val() !== '') && ($('.name').val() !== '') && ($('.password').val() === $('.confirmPassword').val())) {
	 		document.detailForm.action = "<c:url value='/startJoin.do'/>";
	 		document.detailForm.submit();
		} else if($('.id').val() === '') {
			alert("아이디를 입력하세요!");
		} else if($('.password').val() === '') {
			alert("비밀번호를 입력하세요!");
		} else if($('.password').val() !== $('.confirmPassword').val()) {
			alert("비밀번호 확인 값이 다릅니다!");
		} else if($('.name').val() === '') {
			alert("이름을 입력하세요!");
		}
	}
-->
</script>
</head>
<body style="background-color:#eeeeee; margin-top:100px;">
	<input type="hidden" value="${duplicated}" id="duplicated"/>
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
						<p><form:input path="name" type="text" class="name"/></p>
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
		
		//회원가입 실패 시
		if($('#duplicated').val() != "") {
			alert($('#duplicated').val());
		}
	});
</script>
</html>