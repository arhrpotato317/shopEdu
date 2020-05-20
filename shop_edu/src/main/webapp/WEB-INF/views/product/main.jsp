<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>Product</title>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 대분류 선택시 Ajax 1차분류 가져오기
		$("#categoryBig").change(function() {
			$("#categorySmall").html('<option value="0">--- 선택 ---</option>');
			$.ajax({
				type: "POST",
				url: "./categoryUnder.do",
				data: {
					codeNum: $("#categoryBig").val()
				},
				success: function(response) {
					var optionHtml = "";
					for(var i=0; i<response.cdName.length; i++) {
						optionHtml += '<option value="'+response.cdName[i].CDNO+'">'+response.cdName[i].CDNAME+'</option>';
					}
					$("#categorySmall").append(optionHtml);
				},
				error: function() {
					alert("통신실패");
				}
			});
		});
		
		// 선택 시 값 뿌려주기
		$("#productTable tbody tr").click(function() {
			var tr = $(this);
			var td = tr.children();
			
			var pdCd = td.eq(0).text();
			var pdName = td.eq(1).text();
			var madeCd = td.eq(2).text();
			var madeName = td.eq(3).text();
			var unitCd = td.eq(4).text();
			var unitName = td.eq(5).text();
			var pdUse = td.eq(8).find('input[type="checkbox"]').is(':checked');
			var pdItemclscd = td.eq(-1).find('input[type="hidden"]').val();
			
			$("#productCd").val(pdCd);
			$("#productNm").val(pdName);
			$("#productNm").attr("readonly", true);

			$("#categoryMade").html('<option value="0" disabled>--- 선택 ---</option>');
			$("#categoryUnit").html('<option value="0" disabled>--- 선택 ---</option>');
			
			$("#productclscd").val(pdItemclscd);
			
			$.ajax({
				type: "POST",
				url: "./submitCategory.do",
				success: function(response) {
					for(var i=0; i<response.makeList.length; i++) {
						$("#categoryMade").append('<option value="'+response.makeList[i].CDNO+'" disabled>'+response.makeList[i].CDNAME+'</option>');
						if(response.makeList[i].CDNO == madeCd) {
							$("#categoryMade").val(madeCd).attr("selected", "selected");
						}
					}
					for(var i=0; i<response.unitList.length; i++) {
						$("#categoryUnit").append('<option value="'+response.unitList[i].CDNO+'" disabled>'+response.unitList[i].CDNAME+'</option>');
						if(response.unitList[i].CDNO == unitCd) {
							$("#categoryUnit").val(unitCd).attr("selected", "selected");
						}
					}
				},
				error: function() {
					alert("실패");
				}
			});
			
			if(pdUse) {
				$("#productUse").attr("checked", true);
			} else {
				$("#productUse").attr("checked", false);
			}
		});
		
		// 추가버튼 클릭
		$("#addBtn").click(function() {
			$("#productCd").val("");
			$("#productNm").val("");
			
			$("#productNm").removeAttr("readonly");
			$("#productUse").removeAttr("disabled");
			$("#categoryMade option").removeAttr("disabled");
			$("#categoryUnit option").removeAttr("disabled");
			
			$("#categoryMade").html('<option value="0">--- 선택 ---</option>');
			$("#categoryUnit").html('<option value="0">--- 선택 ---</option>');
			
			$.ajax({
				type: "POST",
				url: "./submitCategory.do",
				success: function(response) {
					for(var i=0; i<response.makeList.length; i++) {
						$("#categoryMade").append('<option value="'+response.makeList[i].CDNO+'">'+response.makeList[i].CDNAME+'</option>');
					}
					for(var i=0; i<response.unitList.length; i++) {
						$("#categoryUnit").append('<option value="'+response.unitList[i].CDNO+'">'+response.unitList[i].CDNAME+'</option>');
					}
				},
				error: function() {
					alert("실패");
				}
			});
			
		});
		
		// 수정버튼 클릭
		$("#modifyBtn").click(function() {
			$("#productNm").removeAttr("readonly");
			$("#productUse").removeAttr("disabled");
			$("#categoryMade option").removeAttr("disabled");
			$("#categoryUnit option").removeAttr("disabled");
		});
	});
</script>
</head>
<body>
<h1>상품관리</h1>

<h4>전체리스트</h4>
<div class="category">
	<form action="./productList.do" method="post">
		카테고리 : 
		<select id="categoryBig" name="categoryBig" style="width: 100px;">
			<option>--- 선택 ---</option>
			<c:forEach items="${productbig}" var="pdbig">
				<option value="${pdbig.CDNO}">${pdbig.CDNAME}</option>
			</c:forEach>
		</select>
		
		1차분류 : 
		<select id="categorySmall" name="categorySmall" style="width: 100px;">
			<option>--- 선택 ---</option>
		</select>
		
		<input type="submit" value="조회">
	</form>
</div>

<div style="overflow-y:scroll;max-height:250px;border:1px solid #cdcdcd; margin-top:15px;">
	<table id="productTable">
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
		<tbody>
			<c:forEach items="${productList}" var="pdList">
				<tr>
					<td>${pdList.ITEMCD}</td>
					<td>${pdList.ITEMNAME}</td>
					<td>${pdList.MADENMCD}</td>
					<td>${pdList.MADENMNAME}</td>
					<td>${pdList.ITEMUNITCD}</td>
					<td>${pdList.ITEMUNITNAME}</td>
					<td>${v.STOCKAMT}</td>
					<c:if test="${pdList.STOCKYN == 'Y'}">
						<td><input type="checkbox" disabled checked></td>
					</c:if>
					<c:if test="${pdList.STOCKYN == 'N'}">
						<td><input type="checkbox" disabled></td>
					</c:if>
					<c:if test="${pdList.USEYN == 'Y'}">
						<td><input type="checkbox" disabled checked></td>
					</c:if>
					<c:if test="${pdList.USEYN == 'N'}">
						<td><input type="checkbox" disabled></td>
					</c:if>
					<td style="display:none;">
						<input type="hidden" id="pdItemclscd" name="pdItemclscd" value="${pdList.ITEMCLSCD}">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<h4>코드내용</h4>
<form action="./submitProduct.do" method="post">
	<table>
		<tr>
			<td>상품코드 : </td>
			<td>
				<input type="text" id="productCd" name="productCd" readonly>
				<input type="hidden" id="productclscd" name="productclscd">
			</td>
		</tr>
		<tr>
			<td>상품명 : </td>
			<td><input type="text" id="productNm" name="productNm" readonly></td>
		</tr>
		<tr>
			<td>제조사 : </td>
			<td>
				<select id="categoryMade" name="categoryMade" style="width: 100px;">
					<option>--- 선택 ---</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>단위명 : </td>
			<td>
				<select id="categoryUnit" name="categoryUnit" style="width: 100px;">
					<option>--- 선택 ---</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>사용여부 : </td>
			<td>
				<input type="checkbox" id="productUse" name="productUse" value="Y" disabled>
				<label for="productUse">사용</label>
			</td>
		</tr>
	</table>
	
	<input type="button" id="addBtn" name="addBtn" value="추가">
	<input type="button" id="modifyBtn" name="modifyBtn" value="수정">
	<input type="submit" id="sudmitBtn" name="sudmitBtn" value="저장">
</form>



</body>
</html>


















