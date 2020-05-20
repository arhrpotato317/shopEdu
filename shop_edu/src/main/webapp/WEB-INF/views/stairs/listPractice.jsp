<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>코드관리</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 화면에 값 뿌려주기
		$("#list_table tbody tr").click(function() {
			var tr = $(this);
			var td = tr.children();
			console.log(tr.text());
			
			var cdno = td.eq(0).text();
			var cdlvl = td.eq(1).text();
			var cdup = td.eq(2).text();
			var cdname = td.eq(3).text();
			console.log(cdno + ", " + cdlvl + ", " + cdup + ", " + cdname);
			// 체크박스 값 가져오기
			var cdcheck = td.eq(4).find('input[type="checkbox"]').is(':checked');
			console.log("cdcheck : " + cdcheck);
			
			$("#codeNum").val(cdno);
			$("#codeLvl").val(cdlvl);
			$("#codeUp").val(cdup);
			$("#codeName").val(cdname);
			$("#codeUse").val(cdcheck);
			
			if(cdcheck) {
				$("#codeUse").prop("checked", true);
			} else {
				$("#codeUse").prop("checked", false);
			}
			
			// 배열 연습하기
			var tdArray = new Array();
			td.each(function(i) {
				tdArray.push(td.eq(i).text());
			});
			console.log("tdArray : " + tdArray);
			
		});
		
		// 추가 버튼 클릭
		$("#insertBtn").click(function() {
			$("#codeNum").val("");
			$("#codeLvl").val("");
			$("#codeUp").val("");
			$("#codeName").val("");
			$("#codeUse").val("");
			
			$("#codeLvl").removeAttr("readonly");
			$("#codeUp").removeAttr("readonly");
			$("#codeName").removeAttr("readonly");
			$("#codeUse").removeAttr("disabled");
		});
		
		// 수정 버튼 클릭
		$("#modifyBtn").click(function() {
			$("#codeLvl").removeAttr("readonly");
			$("#codeUp").removeAttr("readonly");
			$("#codeName").removeAttr("readonly");
			$("#codeUse").removeAttr("disabled");
		});
	});
</script>
</head>

<body>


<div class="container">
	<h4>전체리스트</h4>
	
	<div class="allList" style="overflow-y:scroll;max-height:300px;border:1px solid #cdcdcd;">
		<table id="list_table">
			<thead>
				<tr>
					<th>코드번호</th>
					<th>코드레벨</th>
					<th>상위코드</th>
					<th>코드이름</th>
					<th>사용여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${stairsList}" var="list">
					<tr>
						<td>${list.CDNO}</td>
						<td>${list.CDLVL}</td>
						<td>${list.UPCD}</td>
						<td>${list.CDNAME}</td>
					
						<c:if test="${list.USEYN == 'checked'}">
							<td><input type="checkbox" id="userUse" name="userUse" disabled checked></td>
						</c:if>
						<c:if test="${list.USEYN == null}">
							<td><input type="checkbox" id="userUse" name="userUse" disabled></td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<h4>코드내용</h4>
	
	<form action="codeSubmit.do" method="post">
		<table>
			<tr>
				<td>코드번호</td>
				<td><input type="text" id="codeNum" name="codeNum" readonly></td>
			</tr>
			<tr>
				<td>코드레벨</td>
				<td><input type="text" id="codeLvl" name="codeLvl" readonly></td>
			</tr>
			<tr>
				<td>상위코드</td>
				<td><input type="text" id="codeUp" name="codeUp" readonly></td>
			</tr>
			<tr>
				<td>코드이름</td>
				<td><input type="text" id="codeName" name="codeName" readonly></td>
			</tr>
			<tr>
				<td>사용여부</td>
				<td><input type="checkbox" id="codeUse" name="codeUse" disabled>사용</td>
			</tr>
		</table>
		
		<input type="button" id="insertBtn" name="insertBtn" value="추가">
		<input type="button" id="modifyBtn" name="modifyBtn" value="수정">
		<input type="submit" id="submitBtn" name="submitBtn" value="저장">
	</form>
  
</div>


</body>
</html>
























