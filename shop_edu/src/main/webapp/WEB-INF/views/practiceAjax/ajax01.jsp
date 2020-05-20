<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>ajax01</title>
</head>
<body>

<%-- http://blog.naver.com/PostView.nhn?blogId=walterkim990&logNo=221033858070

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
xml


<!-- 코드 불러오기 -->
<select id="code_find" resultType="com.mnet.vo.CodemngVo">
	select * from
	EXAM_MANAGER.CODEMNG where UPCD = 'C0001'
</select>
<!-- 동적으로 코드 가져오기 -->
<select id="code2_find" parameterType="String"
	resultType="com.mnet.vo.CodemngVo">
	select * from EXAM_MANAGER.CODEMNG where UPCD = #{UPCD}
</select>


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
jsp

// body 부분 --%>
	<div class="tester">
		<table>
			<tbody>
				<tr>
					<th scope="row"></th>


					<td>
						<h5>카테고리</h5> 
						<select id="catagory" name="catagory" onchange="productSelect(this.value);">
							<option value="">전체</option>
							<c:forEach var="vo" items="${cList}">
								<option value="${vo.CDNO}">${vo.CDNAME}</option>
							</c:forEach>
					</select>
					</td>
					<td>
						<h5>1차분류</h5> <select id="product" name="product">
							<option value="">전체</option>
							
					</select>
					</td>
					<td><button type="button" class="click_find">조회</button></td>
				</tr>
			</tbody>
		</table>
	</div>


<!-- // ajax 부분 -->

	<script>
		function productSelect(catagory) {
			$.ajax({
				type : "POST",
				url : "productSelect.do",
				dataType : "json",
				data : {
					param : catagory
				},
				success : function(result) {

					//SELECT BOX 초기화           
					$("#product").find("option").remove().end().append(
							"<option value=''>전체</option>");

					//배열 개수 만큼 option 추가
					$.each(result, function(i) {
						$("#product").append(
								"<option value='"+result[i].CDNO+"'>"
										+ result[i].CDNAME + "</option>")
					});
					

					
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("오류가 발생하였습니다.");
				}
			});
		}
		</script>


<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
controller

///////// 불필요한 방식

@RequestMapping(value = "productSelect.do")
	public void productSelect_ajax(Model model, String param) {

		try {
			String catagory = param; // UPCD 대분

			if (catagory != null) {
				// model.addAttribute("c2List", codemngservice.code2_select(param));

				List<CodemngVo> c2List = codemngservice.code2_select(param);

				JSONArray jsonArray = new JSONArray();

				for (int i = 0; i < c2List.size(); i++) {
					jsonArray.add(c2List.get(i));
					System.out.println(jsonArray.get(i).toString());
				}

				// jsonArray 넘김
				response.setContentType("text/html;charset=UTF-8"); // json 한글 세팅 
				PrintWriter pw = response.getWriter(); 
				pw.print(jsonArray.toString());
				pw.flush();
				pw.close();

			}

		} catch (Exception e) {
			System.out.println("에러에러에러");
		}

	}



/////////////  편리한 방식

	@ResponseBody 
	@RequestMapping(value = "productSelect.do")
	public Map<String, Object> productSelect_ajax(Model model, String param) {

		String catagory = param; // UPCD 대분


		List<CodemngVo> c2List = codemngservice.code2_select(param);
				
		Map result = new HashMap();
				
		result.put("data", c2List);

				

		return result;

	}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dao & service

	public List<CodemngVo> code_select(){
		return sql.selectList("code.code_find");
	}
	
	public List<CodemngVo> code2_select(String UPCD){
		return sql.selectList("code.code2_find", UPCD);
	}
	



	public List<CodemngVo> code_select(){
		return dao.code_select();
	}
	
	public List<CodemngVo> code2_select(String UPCD){
		return dao.code2_select(UPCD);
	}



리스트 띄우는 방식 -->
	<script>
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

                  $.each(itemList, function(i) {
                     $('#tabList').append(
                           '<tr ><th>' + itemList[i].ITEMCD
                                 + '</th><th>'
                                 + itemList[i].ITEMNAME
                                 + '</th><th>'
                                 + itemList[i].MADENMCD   
                                 + '</th><th>'
                                 + itemList[i].MADE
                                 + '</th><th>'
                                 + itemList[i].ITEMUNITCD
                                 + '</th><th>'
                                 + itemList[i].EA
                                 + '</th><th>'
                                 + itemList[i].STOCKAMT
                                 + '</th><th><div style="display: none" id = "USEYN_d">'+itemList[i].USEYN+'</div>' 
                                 + '</th><th><div style="display: none" id = "ITEMCLSCD_d">'+itemList[i].ITEMCLSCD+'</div>'
                                 );

                     if(itemList[i].STOCKYN == "Y"){
                        $('#tabList').append('</th><th><input type="checkbox" name = "STOCKYN_1" id = "STOCKYN_1" checked="checked" disabled="disabled"></th></tr><br>')
                     }else{
                        $('#tabList').append('</th><th><input type="checkbox" name = "STOCKYN_1" id = "STOCKYN_1" disabled="disabled"></th></tr><br>')                        
                     }
                     if(itemList[i].USEYN == "Y"){
                        $('#tabList').append('</th><th><input type="checkbox" name = "USEYN_1" id = "USEYN_1" checked="checked" disabled="disabled"></th></tr><br>')
                     }else{
                        $('#tabList').append('</th><th><input type="checkbox" name = "USEYN_1" id = "USEYN_1" disabled="disabled"></th></tr><br>')                        
                     }
                     
                     $("#MADE").append(
                           "<option value='"+itemList[i].MADENMCD+"'>"
                                 + itemList[i].MADE + "</option>")
                     $("#ITEMUNITCD").append(
                           "<option value='"+itemList[i].ITEMUNITCD+"'>"
                                 + itemList[i].EA + "</option>")
                  });
                  
               }
            });
	</script>

</body>
</html>
