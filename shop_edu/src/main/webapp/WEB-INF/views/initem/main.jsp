<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>입고관리</title>
	<style>
		select {width:100px;}
		h1, h4 {margin:20px 0 10px;}
		form {margin:0;}
		.allList {border:1px solid #d0d0d0;padding:10px;margin-bottom:10px;}
		.intable {border:1px solid #d0d0d0;max-height:150px;overflow-y:scroll;}
		.intable table th {padding:0 10px;}
		.intable table td {text-align:center;}
		.inInput {border:1px solid #d0d0d0;margin-top:10px;padding:10px;}
	</style>
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		// 두번째 카테고리 가져오기
		function cateChange() {
			
			var cateOne = document.getElementById("cateOne").value;
			// JSON형식으로 보내기
			var data = {"cateOne":cateOne}
			
			ajax.onreadystatechange = cateAjax;
			ajax.open("POST", "./cateAjax.do", true);
			/* ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); */
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function cateAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					console.log(response.categoryTwoList);
					var resultHtml = "";
					for(var i=0; i<response.categoryTwoList.length; i++) {
						resultHtml += '<option value="'+response.categoryTwoList[i].CDNO+'">'
							+response.categoryTwoList[i].CDNAME+'</option>'
					}
					document.getElementById("cateTwo").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
		
		// 카테고리 조회 결과
		function categorySubmit() {
			var cateOne = document.getElementById("cateOne").value;
			var cateTwo = document.getElementById("cateTwo").value;
			var data = {"cateOne":cateOne, "cateTwo":cateTwo}
			
			ajax.onreadystatechange = cateRtnAjax;
			ajax.open("POST", "./cateRtnAjax.do", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function cateRtnAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					console.log(response.categoryList);
					var resultHtml = "";
					for(var i=0; i<response.categoryList.length; i++) {
						resultHtml += '<tr>\
							<td>'+response.categoryList[i].ITEMCD+'</td>\
							<td>'+response.categoryList[i].ITEMNAME+'</td>\
							<td>'+response.categoryList[i].MADENMCD+'</td>\
							<td>'+response.categoryList[i].MADENMNAME+'</td>\
							<td>'+response.categoryList[i].ITEMUNITCD+'</td>\
							<td>'+response.categoryList[i].ITEMUNITNAME+'</td>\
							<td>'+response.categoryList[i].STOCKAMT+'</td>\
							<td><input type="checkbox"'+response.categoryList[i].STOCKYN+' disabled></td>\
							<td><input type="checkbox"'+response.categoryList[i].USEYN+' disabled></td>\
						</tr>';
					}
					document.getElementById("itemBody").innerHTML = resultHtml;
					
					// 각각의 상품(테이블 row) 클릭하기
					var itemTable = document.getElementById("itemTable");
					var itemTableTr = itemTable.getElementsByTagName("tr");
					for(var i=0; i<itemTableTr.length; i++) {
						itemTableTr[i].addEventListener("click", function() {
							myFunction(this.children);
						});
					}
				} else {
					alert("실패");
				}
			}
		}
		
		// 상품 클릭 시 입고내용에 뿌려주기
		function myFunction(itemArr) {
			var itemCode = itemArr[0].innerHTML;
			var itemName = itemArr[1].innerHTML;
			var itemCompany = itemArr[3].innerHTML;
			var itemUnit = itemArr[5].innerHTML;
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemName").value = itemName;
			document.getElementById("itemCompany").value = itemCompany;
			document.getElementById("itemUnit").value = itemUnit;
			document.getElementById("itemListCode").value = "";
			document.getElementById("itemStock").value = "";
		}
		
		// 저장버튼
		function saveAjax() {
			var itemListCode = document.getElementById("itemListCode").value;
			var itemCode = document.getElementById("itemCode").value;
			var itemName = document.getElementById("itemName").value;
			var itemCompany = document.getElementById("itemCompany").value;
			var itemUnit = document.getElementById("itemUnit").value;
			var itemStock = document.getElementById("itemStock").value;
			
			if(itemCode == null || itemCode == '') {
				alert("상품코드가 입력되어있어야 합니다.");
				return false;
			}
			
			if(itemName == null || itemName == '') {
				alert("상품명이 입력되어있어야 합니다.");
				return false;
			}
			
			if(itemCompany == null || itemCompany == '') {
				alert("제조사명이 입력되어있어야 합니다.");
				return false;
			}
			
			if(itemUnit == null || itemUnit == '') {
				alert("단위명이 입력되어있어야 합니다.");
				return false;
			}
			
			if(itemStock == null || itemStock == '') {
				alert("수량을 입력해주세요.");
				return false;
			}
			
			data = {
				"itemListCode":itemListCode,
				"itemCode":itemCode,
				"itemName":itemName,
				"itemCompany":itemCompany,
				"itemUnit":itemUnit,
				"itemStock":itemStock
			}
			ajax.onreadystatechange = saveformAjax;
			ajax.open("POST", "./saveformAjax.do", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function saveformAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					console.log("response : " + response);
					
					if(response.hasOwnProperty("itemInsertList")) {
						// 행 추가하기
						var todayTable = document.getElementById("todayTable");
						var todayTableTr = todayTable.insertRow(todayTable.rows.length);
						todayTableTr.innerHTML = '<tr>\
							<td>'+response.itemInsertList.ITEMCD+'</td>\
							<td>'+response.itemInsertList.ITEMNAME+'</td>\
							<td>'+response.itemInsertList.MADENMCD+'</td>\
							<td>'+response.itemInsertList.MADENMNAME+'</td>\
							<td>'+response.itemInsertList.ITEMUNITCD+'</td>\
							<td>'+response.itemInsertList.ITEMUNITNAME+'</td>\
							<td>'+response.itemInsertList.INSAMT+'</td>\
							<td style="display:none;">'+response.itemInsertList.INSITEMLISTCD+'</td>\
						</tr>';
						
						alert("입고상품이 추가되었습니다.");
						document.getElementById("itemStock").readOnly = true;
						
						todayTableTr.addEventListener("click", function() {
							todayClick(this.children);
						});
						
					} else if(response.hasOwnProperty("itemUpdateInfo")){
						// 행 수정하기
						var insAmt = response.itemUpdateInfo.insAmt;
						var itemListCd = response.itemUpdateInfo.itemListCd;
						
						var todayTable = document.getElementById("todayTable");
						var todayTableTr = todayTable.getElementsByTagName("tr");
						for(var i=0; i<todayTableTr.length; i++) {
							if(todayTableTr[i].lastElementChild.innerText == itemListCd) {
								todayTableTr[i].children[6].innerText = insAmt;
							}
						}
						
						alert("입고상품 수량이 수정되었습니다.");
						document.getElementById("itemStock").readOnly = true;
					}
					
					// 전체 리스트 재고수량 수정
					console.log(response.itemStockAmt);
					var updateItemCd = response.itemStockAmt.ITEMCD;
					var updateStockAmt = response.itemStockAmt.STOCKAMT;
					
					var itemTable = document.getElementById("itemTable");
					var itemTableTr = itemTable.getElementsByTagName("tr");
					for(var i=0; i<itemTableTr.length; i++) {
						if(itemTableTr[i].firstElementChild.innerText == updateItemCd) {
							itemTableTr[i].children[6].innerText = updateStockAmt;
						}
					}
					
				} else {
					alert("실패");
				}
			}
		}
		function todayClick(itemArr) {
			var itemCode = itemArr[0].innerHTML;
			var itemName = itemArr[1].innerHTML;
			var itemCompany = itemArr[3].innerHTML;
			var itemUnit = itemArr[5].innerHTML;
			var itemStock = itemArr[6].innerHTML;
			var itemListCode = itemArr[7].innerHTML;
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemName").value = itemName;
			document.getElementById("itemCompany").value = itemCompany;
			document.getElementById("itemUnit").value = itemUnit;
			document.getElementById("itemStock").value = itemStock;
			document.getElementById("itemListCode").value = itemListCode;
		}
		
		// 수정 버튼 클릭
		function updateStock() {
			document.getElementById("itemStock").readOnly = false;
		}
	</script>
</head>

<body>
<h1>입고관리</h1>
<h4>전체 리스트</h4>
<div class="allList">
	카테고리 : 
	<select id="cateOne" onchange="cateChange();">
		<option>--- 선택 ---</option>
		<c:forEach items="${categoryOneList}" var="categoryOne">
			<option value="${categoryOne.CDNO}">${categoryOne.CDNAME}</option>
		</c:forEach>
	</select>
	1차분류 : 
	<select id="cateTwo">
		<option>--- 선택 ---</option>
	</select>
	<input type="button" onclick="categorySubmit();" id="cateSubmit" name="cateSubmit" value="조회">
</div>
<div class="intable">
	<table id="itemTable">
		<thead>
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>제조사코드</th>
				<th>제조사명</th>
				<th>단위코드</th>
				<th>단위명</th>
				<th>재고수량</th>
				<th>재고여부</th>
				<th>사용여부</th>
			</tr>		
		</thead>
		<tbody id="itemBody"></tbody>
	</table>
</div>

<h4>금일 입고리스트</h4>
<div class="intable">
	<table id="todayTable">
		<thead>
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>제조사코드</th>
				<th>제조사명</th>
				<th>단위코드</th>
				<th>단위명</th>
				<th>입고수량</th>
			</tr>		
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(itemInsertList) > 0}">
					<c:forEach items="${itemInsertList}" var="itemList">
						<tr onclick="todayClick(this.children);">
							<td>${itemList.ITEMCD}</td>
							<td>${itemList.ITEMNAME}</td>
							<td>${itemList.MADENMCD}</td>
							<td>${itemList.MADENMNAME}</td>
							<td>${itemList.ITEMUNITCD}</td>
							<td>${itemList.ITEMUNITNAME}</td>
							<td>${itemList.INSAMT}</td>
							<td style="display:none;">${itemList.INSITEMLISTCD}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>

<div class="inInput">
	<h4>입고 내용</h4>
	<form method="post" id="submitForm" name="submitForm">
		<table>
			<tr>
				<td>상품코드 : </td>
				<td>
					<input type="text" id="itemCode" name="itemCode" readonly>
					<input type="hidden" id="itemListCode" name="itemListCode">
				</td>
			</tr>
			<tr>
				<td>상품명 : </td>
				<td><input type="text" id="itemName" name="itemName" readonly></td>
			</tr>
			<tr>
				<td>제조사 : </td>
				<td><input type="text" id="itemCompany" name="itemCompany" readonly></td>
			</tr>
			<tr>
				<td>단위명 : </td>
				<td><input type="text" id="itemUnit" name="itemUnit" readonly></td>
			</tr>
			<tr>
				<td>입고수량 : </td>
				<td><input type="text" id="itemStock" name="itemStock" readonly></td>
			</tr>
		</table>
		
		<input type="button" id="modifyBtn" name="modifyBtn" value="수정" onclick="updateStock();">
		<input type="button" id="saveBtn" name="saveBtn" value="저장" onclick="saveAjax();">
	</form>
</div>
</body>
</html>

















