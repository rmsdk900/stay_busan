<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기 테스트</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/room/detail" method="get">
		<input type="hidden" name="r_no" value=1 />
		<input type="submit" value="1번 글 상세보기"/>
	</form>
</body>
</html>