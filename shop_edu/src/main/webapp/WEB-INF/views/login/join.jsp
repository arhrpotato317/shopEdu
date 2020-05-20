<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
	<title>Join</title>
	
	<script type="text/javascript">
		// 아이디 중복체크
		function ajax() {
			var httpRequest = new XMLHttpRequest(); // 함수 내 지역변수 선언 권장
			
			if(!httpRequest) {
				alert("XMLHTTP 인스턴트 생성 불가");
				return false;
			}
			
			var userId = document.getElementById("userId").value;
			
			if(userId != null && userId != '') {
				
				// 서버로 보낸 요청에 대한 응답
				httpRequest.onreadystatechange = function() {
					// 요구의 상태값을 검사
					if(httpRequest.readyState === XMLHttpRequest.DONE) { // 상수 4로 정의
						if(httpRequest.status === 200) { // HTTP 응답 상태 코드를 검사
							var response = parseInt(httpRequest.responseText);
							
								if(response > 0) {
									alert("사용 불가능한 아이디 입니다.");
									var idFocus = document.getElementById("userId");
									idFocus.value = null;
									idFocus.focus();
								} else {
									alert("사용 가능한 아이디 입니다.");
									document.getElementById("idCheck").value = "check";
								}
							
						} else {
							alert("서버로의 요청에 실패하였습니다.");
						}
					}		
				}
				
				httpRequest.open("POST", "./idCheck.do", true); // true는 기본값
				httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				httpRequest.send('userId=' + encodeURIComponent(userId));
				
			} else {
				alert("아이디를 입력해주세요.");
			}
			
		}
		
		function saveJoin() {
			var userId = document.getElementById("userId").value;
			var idCheck = document.getElementById("idCheck").value;
			var userPass = document.getElementById("userPass").value;
			var userPassCheck = document.getElementById("userPassCheck").value;
			var userName = document.getElementById("userName").value;
			
			if(userId == null || userId == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if(idCheck == "unCheck") {
				alert("아이디 중복체크를 확인해주세요.");
				return false;
			}
			
			if(userPass == null || userPass == '') {
				alert("비밀번호를 입력해주세요.");
				return false;
			} else if(userPass.length < 5 || userPass.length > 10) {
				alert("비밀번호는 5자리 이상 10자리 이하여야 합니다.");
				document.getElementById("userPass").value = null;
				document.getElementById("userPass").focus();
				return false;
			}
			
			if(userPassCheck == null || userPassCheck == '') {
				alert("비밀번호를 입력해주세요.");
				return false;
			} else if(userPass != userPassCheck) {
				alert("비밀번호가 불일치 합니다.");
				document.getElementById("userPassCheck").value = null;
				document.getElementById("userPassCheck").focus();
				return false;
			}
			
			if (userName == null || userName == '') {
				alert("성명을 입력해주세요.");
				return false;
			}
			
			// 회원가입 상세로 아이디 값 전달
			document.getElementById("idDetail").value = userId;
			
			document.getElementById("joinSubmit").submit();
		}
		
		// 중복체크 이후 아이디 변경 감지
		function changeId() {
			document.getElementById("idCheck").value = "unCheck";
		}
	</script>
</head>
<body>
<h1>회원가입</h1>

<form action="join.do" method="post" id="joinSubmit">
	<table>
		<tr>
			<td>아 이 디 :</td>
			<td>
				<input type="text" id="userId" name="userId" onchange="changeId()" placeholder="아이디를 입력하세요.">
				<input type="button" onclick="ajax();" value="중복체크">
				<input type="hidden" id="idCheck" name="idCheck" value="unCheck">
				<!-- 회원가입 상세로 아이디 값 전달 -->
				<input type="hidden" id="idDetail" name="idDetail">
			</td>
		</tr>
		<tr>
			<td colspan="2">#비밀번호는 5자리 이상 10자리 이하여야 합니다.</td>
		</tr>
		<tr>
			<td>비밀번호 :</td>
			<td><input type="password" id="userPass" name="userPass" placeholder="비밀번호를 입력하세요."></td>
		</tr>
		<tr>
			<td>비밀번호확인 :</td>
			<td><input type="password" id="userPassCheck" name="userPassCheck" placeholder="비밀번호를 입력하세요."></td>
		</tr>
		<tr>
			<td>성명 :</td>
			<td><input type="text" id="userName" name="userName" placeholder="성명을 입력하세요."></td>
		</tr>
	</table>
	
	 <input type="button" onclick="saveJoin();" value="저장">

</form>

</body>
</html>













