<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>Stairs</title>
	<style>
		.stairs {width: 500px;height: 300px;overflow-y: scroll;border: 1px solid #cdcdcd;}
		.stairs table {width: 100%;border-spacing: 0px;}
		.stairs table th {padding: 10px;}
		.stairs table td {text-align: center;}
		.stairs tbody tr:hover {background: #eee;}
		.staris_box {margin-top: 20px;width: 500px;}
		.staris_box p {border: 1px solid #cdcdcd;text-align: center;padding: 10px 0;}
	</style>
	
	<script type="text/javascript">
		window.onload = function() {
			document.getElementById("stairs_one").style.display = 'none';
		}
		
		var httpRequest = new XMLHttpRequest();
		
		function stairsAjax(codeNum) {
			document.getElementById("stairs_one").style.display = 'block';
			document.getElementById("btn_submit").style.display = 'none';
			
			if(!httpRequest) {
				alert("XMLHTTP 인스턴트 생성 불가");
				return false;
			}
			
			var cdno = document.getElementById("code"+codeNum).value;
			
			httpRequest.onreadystatechange = function() {
				if(httpRequest.readyState === XMLHttpRequest.DONE) {
					if(httpRequest.status === 200) {
						response = JSON.parse(httpRequest.responseText);
						
						document.getElementById("codeNum").innerHTML=response.CDNO;
						document.getElementById("codeLvl").innerHTML=response.CDLVL;
						document.getElementById("codeUp").innerHTML=response.UPCD;
						document.getElementById("codeName").innerHTML=response.CDNAME;
						document.getElementById("insertUse").checked=response.USEYN;
					} else {
						alert("실패");
					}
				}
			}
			
			httpRequest.open("POST", "./stairsAjax.do", true); // true는 기본값
			httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			httpRequest.send('cdno=' + encodeURIComponent(cdno));
		}
		
		function insertCk() {
			document.getElementById("btn_submit").style.display = 'inline-block';
			
			document.getElementById("codeNum").innerHTML='';
			document.getElementById("codeLvl").innerHTML = '<input type="text" id="codeLvl" name="codeLvl" required>';
			document.getElementById("codeUp").innerHTML = '<input type="text" id="codeUp" name="codeUp" required>';
			document.getElementById("codeName").innerHTML = '<input type="text" id="codeName" name="codeName" required>';
		}
		function modifyCk() {
			document.getElementById("btn_submit").style.display = 'inline-block';
			
			document.getElementById("codeNum").innerHTML = response.CDNO + '<input type="hidden" id="codeNum" name="codeNum" value="' + response.CDNO + '">';
			document.getElementById("codeLvl").innerHTML = '<input type="text" id="codeLvl" name="codeLvl" value="' + response.CDLVL + '">';
			document.getElementById("codeUp").innerHTML = '<input type="text" id="codeUp" name="codeUp" value="' + response.UPCD + '">';
			document.getElementById("codeName").innerHTML = '<input type="text" id="codeName" name="codeName" value="' + response.CDNAME + '">';
		}
	</script>
</head>
<body>
<h1>계층형쿼리</h1>

<p>전체 리스트</p>
<div class="stairs">
	<table>
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
			<c:choose>
				<c:when test="${fn:length(stairsList) > 0 }">
					<c:forEach items="${stairsList}" var="stairs" varStatus="status">
						<tr>
							<td>
								<input type="button" onclick="stairsAjax(${status.count});" id="code${status.count}" value="${stairs.CDNO}">
							</td>
							<td>${stairs.CDLVL}</td>
							<td>${stairs.UPCD}</td>
							<td>${stairs.CDNAME}</td>
							<td><input type="checkbox" id="userUse" name="userUse" ${stairs.USEYN}></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5">조회된 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>

<div id="stairs_one" class="staris_box">
	<p>코드내용</p>
	<form action="./stairsSubmit.do" method="post" id="stairsOne">
		<table>
			<tr>
				<td>코드번호 : </td>
				<td id="codeNum"></td>
			</tr>
			<tr>
				<td>코드레벨 : </td>
				<td id="codeLvl"></td>
			</tr>
			<tr>
				<td>상위코드 : </td>
				<td id="codeUp"></td>
			</tr>
			<tr>
				<td>코드이름 : </td>
				<td id="codeName"></td>
			</tr>
			<tr>
				<td>사용여부 : </td>
				<td>
					<input type="checkbox" id="insertUse" name="insertUse" value="Y">
					<label for="insertUse">사용</label>
				</td>
			</tr>
		</table>
		<input type="button" id="btn_insert" name="btn_insert" onclick="insertCk();" value="추가">
		<input type="button" id="btn_modify" name="btn_modify" onclick="modifyCk();" value="수정">
		<input type="submit" id="btn_submit" name="btn_submit" value="저장">
	</form>
</div>

</body>
</html>




















