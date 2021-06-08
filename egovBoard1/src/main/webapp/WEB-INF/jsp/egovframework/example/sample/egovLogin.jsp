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
	function fn_egov_login() {
		document.detailForm.action = "<c:url value='/startLogin.do'/>";
		document.detailForm.submit();
	}
-->
</script>
</head>
<body style="background-color:#eeeeee; margin-top:100px;">
	<input type="hidden" value="${result}" id="noResult"/>
	<div style="text-align:center;">
		<h2>게시판</h2>
		<div class="loginDiv">
			<div class="loginInputDiv">
				<form:form commandName="LoginVO" id="detailForm" name="detailForm">
					<p>회원아이디&nbsp;<form:input path="id" type="text"/></p>
					<p>비밀번호&nbsp;&nbsp;&nbsp;&nbsp;<form:input path="password" type="password"/></p>
					<button type="button" class="loginBtn" style="position:absolute; left:870px; top:150px; padding:20px 15px;">로그인</button>
				</form:form>
			</div>
			<button class="joinBtn" onclick='location.href="/egovBoardJoin.do"'>회원가입</button>
		</div>
	</div>
</body>
<script>
	$(function() {
		//로그인 버튼 누를 시
		$('.loginBtn').click(function() {
			location.href = 'javascript:fn_egov_login();';
		})
		
		//로그인 실패 시
		if($('#noResult').val() != "") {
			alert($('#noResult').val());
		}
		
		//비밀번호 칸에서 엔터누르면 로그인 시도
		$('#password').keyup(function(e) {
			if(e.keyCode == 13)
				location.href = 'javascript:fn_egov_login();';
		})
	});
</script>
</html>