<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>Hello world!</h1>

<P>  The time on the server is ${serverTime}. </P>

<input type="button" onclick="location.href='./empList.do';" value="사원 명부 확인하기">
<input type="button" onclick="location.href='./empListVO.do';" value="사원 명부 확인하기_VO">
<input type="button" onclick="location.href='./empListParam.do';" value="사원여부 확인하기">
<br><br>
<input type="button" onclick="location.href='./login.do';" value="로그인 하러가기">
<br><br>
<input type="button" onclick="location.href='./stairs.do';" value="계층쿼리 테이블 관련">
<input type="button" onclick="location.href='./list.do';" value="계층쿼리 제이쿼리">
<input type="button" onclick="location.href='./listPractice.do';" value="계층쿼리 제이쿼리 연습">
<br><br>
<input type="button" onclick="location.href='./product.do';" value="상품관리">
<input type="button" onclick="location.href='./initemMain.do';" value="입고관리">
<input type="button" onclick="location.href='./outitemMain.do';" value="출고관리">
<br><br>
<input type="button" onclick="location.href='./filePracMain.do';" value="첨부파일 연습">

</body>
</html>
