<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
	<title>Detail</title>
	
	<style>
		#userDetail {
			display: inline-block;
			border: 1px solid #adadad;
		}
		table {
			padding: 10px;
		}
		table caption {
			padding: 5px 0;
			border-bottom: 1px solid #adadad;
			background: #efefef;
		}
	</style>
	
	<script type="text/javascript">
		function detailSave() {
			var userName = document.getElementById("userName").value;
			var zip = document.getElementById("zip").value;
			var address = document.getElementById("address").value;
			var cellphone = document.getElementById("cellphone").value;
			var homephone = document.getElementById("homephone").value;
			
			if(userName == null || userName == '') {
				alert("성명을 입력해주세요.");
				return false;
			}
			
			if(zip == null || zip == '') {
				alert("우편번호를 입력해주세요.");
				return false;
			}
			
			if(address == null || address == '') {
				alert("주소를 입력해주세요.");
				return false;
			}
			
			if((cellphone == null || cellphone == '') && (homephone == null || homephone == '')) {
				alert("휴대전화 또는 집전화번호를 입력해주세요.");
				return false;
			}
			
			document.getElementById("userDetail").submit();
		}
	</script>
</head>
<body>

<form action="detailSave.do" method="post" id="userDetail">
	<table>
		<caption>상세정보</caption>
		
		<tr>
			<td>성명 : </td>
			<td>
				<input type="text" id="userName" name="userName" placeholder="성명을 입력하세요.">
				<!-- 회원가입에서 받은 아이디 값 -->
				<input type="hidden" id="idDetail" name="idDetail" value="${idDetail}">
			</td>
		</tr>
		<tr>
			<td>관계 : </td>
			<td>
				<select id="relation" name="relation">
					<option value="C0021" selected>본인</option>
					<option value="C0022">부모님</option>
					<option value="C0023">동생</option>
					<option value="C0024">지인</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>우편번호 : </td>
			<td><input type="text" id="zip" name="zip" placeholder="우편번호를 입력하세요."></td>
		</tr>
		<tr>
			<td>주소 : </td>
			<td><input type="text" id="address" name="address" placeholder="주소를 입력하세요."></td>
		</tr>
		<tr>
			<td>휴대전화번호 : </td>
			<td><input type="text" id="cellphone" name="cellphone" placeholder="휴대전화번호를 입력하세요."></td>
		</tr>
		<tr>
			<td>집전화번호 : </td>
			<td><input type="text" id="homephone" name="homephone" placeholder="집전화번호를 입력하세요."></td>
		</tr>
		<tr>
			<td>사용여부 : </td>
			<td>
				<input type="checkbox" id="userUse" name="userUse" value="use" checked>
				<label for="userUse">사용</label>
			</td>
		</tr>
	</table>
	
	<input type="button" onclick="detailSave();" value="저장">
</form>

</body>
</html>
