<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align:left; margin:0 auto; display:inline; padding-top:100px;">
	<div id="content_pop">
		<p>${boardVO.setting} | ${boardVO.title}</p>
		<p><input type="checkbox"/>개발여부</p>
		<p>작성자 ${boardVO.writer}(222.96.6.150)     <fmt:formatDate value="${boardVO.regDate }" pattern="yy-MM-dd HH:MM:SS"/> 조회 ${boardVO.cnt}</p>
		<p>${boardVO.content}</p>
	</div>
</body>
</html>