<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>출고관리</title>
	<style>
		.line {border:1px solid #d0d0d0;margin-bottom:10px;padding:10px;}
		.allItemList, .outItemList {overflow-y:scroll;max-height:150px;}
		select {width:100px;}
	</style>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			// 두번째 카테고리 리스트 가져오기 Ajax
			$("#oneCategory").on("change", function() {
				var cateOneValue = $(this).val();
				$("#twoCategory").html('<option>--- 선택 ---</option>');
				$.ajax({
					type: "POST",
					url: "./categoryTwo.do",
					data: {
						cateOneValue: cateOneValue
					},
					success: function(response) {
						var categoryHtml = "";
						for(var i=0; i<response.categoryTwoList.length; i++) {
							categoryHtml += '<option value="'+response.categoryTwoList[i].CDNO+'">'+response.categoryTwoList[i].CDNAME+'</option>'
						}
						$("#twoCategory").append(categoryHtml);
					},
					error: function() {
						alert("통신실패");
					}
				});
			});
			
			// 카테고리 선택 결과 Ajax
			$("#categorySubmit").on("click", function() {
				$.ajax({
					type: "POST",
					url: "./categoryList.do",
					data: {
						cateTwoValue: $("#twoCategory").val()
					},
					success: function(response) {
						$("#cateItemList").empty();
						var tableHtml = "";
						for(var i=0; i<response.categoryItemList.length; i++) {
							var stockYn, useYn = "";
							if(response.categoryItemList[i].STOCKYN == 'Y') {
								stockYn = "checked";
							} else if(response.categoryItemList[i].USEYN == 'Y') {
								useYn = "checked";
							}
							tableHtml += '<tr>\
											<td>'+response.categoryItemList[i].ITEMCD+'</td>\
											<td>'+response.categoryItemList[i].ITEMNAME+'</td>\
											<td>'+response.categoryItemList[i].MADENMCD+'</td>\
											<td>'+response.categoryItemList[i].MADENMNAME+'</td>\
											<td>'+response.categoryItemList[i].ITEMUNITCD+'</td>\
											<td>'+response.categoryItemList[i].ITEMUNITNAME+'</td>\
											<td>'+response.categoryItemList[i].STOCKAMT+'</td>\
											<td><input type="checkbox" '+stockYn+' disabled></td>\
											<td><input type="checkbox" '+useYn+' disabled></td>\
										</tr>';
						}
						$("#cateItemList").append(tableHtml);
						
						// 출고내용에 뿌려주기 (처음 추가 시)
						$("#cateItemList tr").on("click", function() {
							var td = $(this).children();
							var itemCode = td.eq(0).text();
							var itemName = td.eq(1).text();
							var itemCompanyCode = td.eq(2).text();
							var itemCompany = td.eq(3).text();
							var itemUnit = td.eq(5).text();
							
							$("#itemCode").val(itemCode);
							$("#itemName").val(itemName);
							$("#itemCompanyCode").val(itemCompanyCode);
							$("#itemCompany").val(itemCompany);
							$("#itemUnit").val(itemUnit);
							
							$("#outItemListCode").val("");
							$("#userId").val("");
							$("#userName").val("");
							$("#invoiceNum").val("");
							$("#outStock").val("");
							$("#outStockUpdate").val("");
							$("#checkYn").prop("checked", false);
							$("#delivYn").prop("checked", false);
							$("#readyDelivYn").prop("checked", false);
							$("#addrCompany").val("0").attr("selected", "selected");
						});
					},
					error: function() {
						alert("통신실패");
					}
				});
			});
			
			// 수정 버튼
			$("#editOut").on("click", function() {
				$("#userId").attr("readonly", false);
				$("#userName").attr("readonly", false);
				$("#invoiceNum").attr("readonly", false);
				$("#outStock").attr("readonly", false);
				$("#checkYn").removeAttr("disabled");
				$("#delivYn").removeAttr("disabled");
			});
			
			$.fn.todayClick = function(e) {
				var td = $(e).children();
				var itemCode = td.eq(0).text();
				var itemName = td.eq(1).text();
				var itemCompany = td.eq(3).text();
				var itemUnit = td.eq(4).text();
				var userId = td.eq(6).text();
				var userName = td.eq(7).text();
				var invoiceNum = td.eq(15).find('input[type="hidden"]').val();
				var itemStock = td.eq(5).text();
				var checkYn = td.eq(13).find('input[type="checkbox"]').is(':checked');
				var delivYn = td.eq(14).find('input[type="checkbox"]').is(':checked');
				var outItemListCode = td.eq(17).find('input[type="hidden"]').val();
				
				var delivCompany = td.eq(16).find('input[type="hidden"]').val();
				
				$("#itemCode").val(itemCode);
				$("#itemName").val(itemName);
				$("#itemCompany").val(itemCompany);
				$("#itemUnit").val(itemUnit);
				$("#userId").val(userId);
				$("#userName").val(userName);
				$("#invoiceNum").val(invoiceNum);
				$("#outStock").val(itemStock);
				$("#outStockUpdate").val(itemStock);
				$("#checkYn").prop("checked", checkYn);
				$("#delivYn").prop("checked", delivYn);
				$("#readyDelivYn").prop("checked", delivYn);
				$("#outItemListCode").val(outItemListCode);
				$("#addrCompany").val(delivCompany).attr("selected", "selected");
			}
			// 금일 출고리스트 클릭시 출고내용에 뿌려주기 (수정 시)
			$("#todayList tr").on("click", function() {
				$.fn.todayClick(this);
			});
			
			// 저장 버튼
			$("#submitOut").on("click", function() {
				console.log("readyDelivYn:"+ $("#readyDelivYn:checked").val());
				console.log("delivYn:"+ $("#delivYn:checked").val());
				var data = {
					outItemListCode: $("#outItemListCode").val(),
					readyStock: $("#outStockUpdate").val(),
					
					itemCode: $("#itemCode").val(),
					itemName: $("#itemName").val(),
					itemCompanyCode: $("#itemCompanyCode").val(),
					itemCompany: $("#itemCompany").val(),
					itemUnit: $("#itemUnit").val(),
					userId: $("#userId").val(),
					userName: $("#userName").val(),
					invoiceNum: $("#invoiceNum").val(),
					outStock: $("#outStock").val(),
					checkYn: $("#checkYn:checked").val(),
					readyDelivYn: $("#readyDelivYn:checked").val(),
					delivYn: $("#delivYn:checked").val(),
					addrCompany: $("#addrCompany option:selected").val()
				}
				
				// 출고 테이블에 저장하고 금일 출고 리스트에 뿌려주기 Ajax
				$.ajax({
					type: "POST",
					url: "./outSubmit.do",
					data: JSON.stringify(data),
					contentType: "application/json; charset=utf-8",
					success: function(response) {
						console.log(response.resultAmt);
						console.log(response.todayInsertItem);
						console.log(response.todayUpdateItem);
						if(response.hasOwnProperty("todayInsertItem")) {
							// 검수여부, 사용여부
							var checkYn, delivYn = "";
							if(response.todayInsertItem.CHECKYN == 'Y') {
								checkYn = "checked";
							}
							if(response.todayInsertItem.DELIVYN == 'Y') {
								delivYn = "checked";
							}
							
							// 금일 출고리스트 추가
							var todayHtml = '<tr>\
												<td>'+response.todayInsertItem.ITEMCD+'</td>\
												<td>'+response.todayInsertItem.ITEMNAME+'</td>\
												<td>'+response.todayInsertItem.MADENMCD+'</td>\
												<td>'+response.todayInsertItem.MADENMNAME+'</td>\
												<td>'+response.todayInsertItem.ITEMUNITNAME+'</td>\
												<td>'+response.todayInsertItem.DELIVAMT+'</td>\
												<td>'+response.todayInsertItem.ID+'</td>\
												<td>'+response.todayInsertItem.INSUSER+'</td>\
												<td>'+response.todayInsertItem.RELCD+'</td>\
												<td>'+response.todayInsertItem.ADDRCD+'</td>\
												<td>'+response.todayInsertItem.ADDRNAME+'</td>\
												<td>'+response.todayInsertItem.MOBILETELNO+'</td>\
												<td>'+response.todayInsertItem.HOMETELNO+'</td>\
												<td><input type="checkbox" '+checkYn+' disabled></td>\
												<td><input type="checkbox" '+delivYn+' disabled></td>\
												<td><input type="hidden" value="'+response.todayInsertItem.DELIVNO+'"></td>\
												<td><input type="hidden" value="'+response.todayInsertItem.DELIVCORPCD+'"></td>\
												<td><input type="hidden" value="'+response.todayInsertItem.OUTITEMLISTCD+'"></td>\
											</tr>';
							$("#todayList").append(todayHtml);
							
						} else if(response.hasOwnProperty("todayUpdateItem")) {
							// 금일 출고리스트 수정
							console.log("금일 출고리스트 수정");
							
							$("#todayList tr").each(function(index) {
								if($(this).children().eq(17).find('input[type="hidden"]').val() == response.todayUpdateItem.OUTITEMLISTCD) {
									$(this).children().eq(15).find('input[type="hidden"]').val(response.todayUpdateItem.DELIVNO);
									$(this).children().eq(5).text(response.todayUpdateItem.DELIVAMT);
									
									if(response.todayUpdateItem.CHECKYN == 'Y') {
										$(this).children().eq(13).find('input[type="checkbox"]').attr("checked", true);
									} else {
										$(this).children().eq(13).find('input[type="checkbox"]').attr("checked", false);
									}
									if(response.todayUpdateItem.DELIVYN == 'Y') {
										$(this).children().eq(14).find('input[type="checkbox"]').attr("checked", true);
									} else {
										$(this).children().eq(14).find('input[type="checkbox"]').attr("checked", false);
									}
									
									$(this).children().eq(16).find('input[type="hidden"]').val(response.todayUpdateItem.DELIVCORPCD);
								}
							});
							
							// 출고관리 전체리스트 수량변경
							$("#cateItemList tr").each(function(index) {
								if($(this).children().first().text() == response.resultAmt.ITEMCD) {
									$(this).children().eq(14).text(response.todayUpdateItem.DELIVYN);
								}
							});
						}
						
						// 출고관리 전체리스트 수량변경
						$("#cateItemList tr").each(function(index) {
							if($(this).children().first().text() == response.resultAmt.ITEMCD) {
								$(this).children().eq(6).text(response.resultAmt.STOCKAMT);
							}
						});
						
						$("#todayList tr").on("click", function() {
							$.fn.todayClick(this);
						});
					},
					error: function() {
						alert("통신실패");
					}
				});
			});
		});
	</script>
</head>

<body>
<h1>출고관리</h1>
<h4>전체리스트</h4>
<div class="category line">
	카테고리 : 
	<select id="oneCategory">
		<option>--- 선택 ---</option>
		<c:forEach items="${categoryOneList}" var="oneCategory">
			<option value="${oneCategory.CDNO}">${oneCategory.CDNAME}</option>
		</c:forEach>
	</select>
	1차분류 : 
	<select id="twoCategory">
		<option>--- 선택 ---</option>
	</select>
	<input type="button" id="categorySubmit" value="조회"> 
</div>

<div class="allItemList line">
	<table>
		<thead>
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>제조사 코드</th>
				<th>제조사명</th>
				<th>단위코드</th>
				<th>단위명</th>
				<th>재고수량</th>
				<th>재고여부</th>
				<th>사용여부</th>
			</tr>
		</thead>
		<tbody id="cateItemList"></tbody>
	</table>
</div>

<h4>금일 출고 리스트</h4>
<div class="outItemList line">
	<table>
		<thead>
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>제조사 코드</th>
				<th>제조사명</th>
				<th>단위명</th>
				<th>출고수량</th>
				<th>회원 아이디</th>
				<th>이름</th>
				<th>관계</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>휴대전화</th>
				<th>집전화</th>
				<th>검수여부</th>
				<th>배송여부</th>
			</tr>
		</thead>
		<tbody id="todayList">
			<c:forEach items="${todayList}" var="todayList">
				<tr>
					<td>${todayList.ITEMCD}</td>
					<td>${todayList.ITEMNAME}</td>
					<td>${todayList.MADENMCD}</td>
					<td>${todayList.MADENMNAME}</td>
					<td>${todayList.ITEMUNITNAME}</td>
					<td>${todayList.DELIVAMT}</td>
					<td>${todayList.ID}</td>
					<td>${todayList.INSUSER}</td>
					<td>${todayList.RELCD}</td>
					<td>${todayList.ADDRCD}</td>
					<td>${todayList.ADDRNAME}</td>
					<td>${todayList.MOBILETELNO}</td>
					<td>${todayList.HOMETELNO}</td>
					<c:if test="${todayList.CHECKYN == 'Y'}">
						<td><input type="checkbox" checked disabled></td>
					</c:if>
					<c:if test="${todayList.CHECKYN == 'N'}">
						<td><input type="checkbox" disabled></td>
					</c:if>
					<c:if test="${todayList.DELIVYN == 'Y'}">
						<td><input type="checkbox" checked disabled></td>
					</c:if>
					<c:if test="${todayList.DELIVYN == 'N'}">
						<td><input type="checkbox" disabled></td>
					</c:if>
					
					<td><input type="hidden" value="${todayList.DELIVNO}"></td>
					<td><input type="hidden" value="${todayList.DELIVCORPCD}"></td>
					<td><input type="hidden" value="${todayList.OUTITEMLISTCD}"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="outContent line">
	<h4>출고 내용</h4>
	<form>
		<table>
			<tr>
				<td>상품코드 : </td>
				<td>
					<input type="text" id="itemCode" name="itemCode" readonly>
					<input type="hidden" id="outItemListCode" name="outItemListCode">
				</td>
				<td>상품명 : </td>
				<td><input type="text" id="itemName" name="itemName" readonly></td>
				
			</tr>
			<tr>
				<td>제조사 : </td>
				<td>
					<input type="text" id="itemCompany" name="itemCompany" readonly>
					<input type="hidden" id="itemCompanyCode" name="itemCompanyCode">
				</td>
				<td>단위 : </td>
				<td><input type="text" id="itemUnit" name="itemUnit" readonly></td>
				
			</tr>
			<tr>
				<td>회원 아이디 : </td>
				<td><input type="text" id="userId" name="userId" readonly></td>
				<td>회원 이름 : </td>
				<td><input type="text" id="userName" name="userName" readonly></td>
				
			</tr>
			<tr>
				<td>송장번호 : </td>
				<td><input type="text" id="invoiceNum" name="invoiceNum" readonly></td>
				<td>출고수량 : </td>
				<td>
					<input type="text" id="outStock" name="outStock" readonly>
					<input type="hidden" id="outStockUpdate">
				</td>
			</tr>
			<tr>
				<td>검수여부 : </td>
				<td><input type="checkbox" id="checkYn" name="checkYn" value="Y" disabled></td>
				<td>배송여부 : </td>
				<td>
					<input type="checkbox" id="delivYn" name="delivYn" value="Y" disabled>
					<input type="checkbox" id="readyDelivYn" name="readyDelivYn" value="Y" style="display:none;">
				</td>
			</tr>
			<tr>
				<td>배송회사 : </td>
				<td>
					<select id="addrCompany">
						<option value="0">---선택---</option>
						<c:forEach items="${addrCompanyList}" var="companyList">
							<option value="${companyList.CDNO}">${companyList.CDNAME}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<input type="button" id="editOut" name="editOut" value="수정">
		<input type="button" id="submitOut" name="submitOut" value="저장">
	</form>
</div>

</body>
</html>

















