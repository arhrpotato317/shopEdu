<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
	<title>Login</title>
	
	<script type="text/javascript">
		function infoCheck(e) {
			/* e.preventDefault(); */
			
			var userId = document.getElementById("userId").value;
			var userPass = document.getElementById("userPass").value;
			
			if(userId == null || userId == '') {
				alert("아이디를 입력해주세요.");
			} else if(userPass == null || userPass == '') {
				alert("비밀번호를 입력해주세요.");
			} else {
				document.getElementById("userSubmit").submit();
			}
		}
	</script>
</head>
<body>
<h1>로그인</h1>

<form action="loginCheck.do" method="post" id="userSubmit">
	<table>
		<tr>
			<td>아 이 디 :</td>
			<td><input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요."></td>
		</tr>
		<tr>
			<td>비밀번호 :</td>
			<td><input type="password" id="userPass" name="userPass" placeholder="비밀번호를 입력하세요."></td>
		</tr>
	</table>

	<!-- <input type="submit" value="로그인"> -->
	<!-- <a href="#" onclick="infoCheck(event);">로그인</a> -->
	<input type="button" onclick="infoCheck(event);" value="로그인">
	<input type="button" onclick="location.href='./join.do';" value="회원가입">
</form>

<c:if test="${not empty msg}">
	<p style="color: red;">${msg}</p>
</c:if>

</body>
</html>
