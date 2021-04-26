<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<form:form commandName="LoginVO" id="detailForm" name="detailForm">
		<div style="text-align:center;">
			<h2>ADBANK 통합유지보수</h2>
			<div style="background-color:white; width:500px; height:150px; margin:0 auto;">
				<div style="padding:20px 20px 20px 90px; text-align:left;">
					<p>회원아이디&nbsp;<form:input path="id" type="text"/></p>
					<p>비밀번호&nbsp;&nbsp;&nbsp;&nbsp;<form:input path="password" type="password"/></p>
					<button type="button" class="loginBtn" style="position:absolute; left:870px; top:190px; padding:20px 15px;">로그인</button>
				</div>
			</div>
		</div>
	</form:form>
</body>
<script>
	$(function() {
		$('.loginBtn').click(function() {
			location.href = 'javascript:fn_egov_login();';
		})
		
		if($('#noResult').val() != "") {
			alert($('#noResult').val());
		}
	});
</script>
</html>