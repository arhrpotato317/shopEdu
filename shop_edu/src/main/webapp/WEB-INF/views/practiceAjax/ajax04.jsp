<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>ajax04</title>
</head>
<body>

<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////jsp	 -->
	<h5>리스트</h5>
	<div style="height: 300px; overflow: auto">
		<table>

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
			<tbody id="tabList"></tbody>
		</table>
	</div>
	<h5>금일 입고 리스트</h5>
	<div style="height: 300px; overflow: auto">
		<table>

			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>제조사코드</th>
				<th>제조사명</th>
				<th>단위코드</th>
				<th>단위명</th>
				<th>입고수량</th>
			</tr>
			<tbody id="tabList2"></tbody>
		</table>
	</div>


<!-- //ajax -->
	<script>
			var select2_option = $("#product option:selected").val();
				// 전체 리스트
				$.ajax({
					type : "POST",
					url : "itemList.do",
					dataType : "json",
					data : {
						param : select2_option
					},
					success : function(itemList) {
						//배열 개수 만큼 option 추가

						$("#tabList").empty();

						$.each(itemList.data, function(i) {
							$('#tabList').append(
									'<tr ><th>' + itemList.data[i].itemcd
											+ '</th><th>'
											+ itemList.data[i].itemname
											+ '</th><th>'
											+ itemList.data[i].madenmcd
											+ '</th><th>'
											+ itemList.data[i].made
											+ '</th><th>'
											+ itemList.data[i].itemunitcd
											+ '</th><th>'
											+ itemList.data[i].ea
											+ '</th><th>'
											+ itemList.data[i].stockamt
											+ '</th><th><div style="display: none" id = "USEYN_d">'+itemList.data[i].useyn+'</div>' 
											+ '</th><th><div style="display: none" id = "ITEMCLSCD_d">'+itemList.data[i].itemclscd+'</div>'
											
											);

							if(itemList.data[i].stockyn == "Y"){
								$('#tabList').append('</th><th><input type="checkbox" name = "STOCKYN_1" id = "STOCKYN_1" checked="checked" disabled="disabled"></th></tr><br>');
							}else{
								$('#tabList').append('</th><th><input type="checkbox" name = "STOCKYN_1" id = "STOCKYN_1" disabled="disabled"></th></tr><br>');								
							}
							if(itemList.data[i].useyn == "Y"){
								$('#tabList').append('</th><th><input type="checkbox" name = "USEYN_1" id = "USEYN_1" checked="checked" disabled="disabled"></th></tr><br>');
							}else{
								$('#tabList').append('</th><th><input type="checkbox" name = "USEYN_1" id = "USEYN_1" disabled="disabled"></th></tr><br>');								
							}
							
							$("#MADE").append(
									"<option value='"+itemList.data[i].madenmcd+"'>"
											+ itemList.data[i].made + "</option>");
							$("#ITEMUNITCD").append(
									"<option value='"+itemList.data[i].itemunitcd+"'>"
											+ itemList.data[i].ea+ "</option>");
							
							
						});
						
					}
				});
				
			//금일 입고리스트
			
				$.ajax({
					type : "POST",
					url : "inItemList.do",
					dataType : "json",
					data : {
						param : select2_option
					},
					success : function(inItemList) {
						//배열 개수 만큼 option 추가
						
					console.log(inItemList.data[0]);
					console.log(inItemList.data.length);

						$("#tabList2").empty();

						$.each(inItemList.data, function(i) {
							$('#tabList2').append(
									'<tr ><th>' + inItemList.data[i].itemcd
											+ '</th><th>'
											+ inItemList.data[i].itemname
											+ '</th><th>'
											+ inItemList.data[i].madenmcd	
											+ '</th><th>'
											+ inItemList.data[i].made
											+ '</th><th>'
											+ inItemList.data[i].itemunitcd
											+ '</th><th>'
											+ inItemList.data[i].ea
											+ '</th><th>'
											+ inItemList.data[i].insamt
											+ '</th><th>'
											+ '</th><th><div style="display: none" id = "INSITEMLISTCD">'+inItemList.data[i].insitemlistcd+'</div>' 
// 											+ '</th><th><div style="display: none" id = "ITEMCLSCD_d">'+inItemList[i].ITEMCLSCD+'</div>'
											);

						});
						
					}
				});
				
				
			} else {
				alert("조회가 되지 않습니다.");
			}

		});
		</script>

<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////controller
	@ResponseBody
	@RequestMapping(value = "itemList.do")
	public Map<String, Object> itemList(Model model, String param) {
		
	
			String CDNO = param; // CDNO 소분류
		
			List<ItemListVo> itemList = itemListService.itemList(CDNO);
			
			Map<String, Object> result = new HashMap<>(); 
			
			result.put("data", itemList);
			
			return result;			
		
	}

	@ResponseBody
	@RequestMapping(value = "inItemList.do")
	public Map<String, Object> inItemList(Model model, String param) {
		

			String CDNO = param; // CDNO 소분류
	
			List<ItemListVo> inItemList = itemListService.inItemList(CDNO);
			
			Map<String, Object> result = new HashMap();
			
			result.put("data", inItemList);
			
			return result;
				
	
	}-->
		

</body>
</html>
