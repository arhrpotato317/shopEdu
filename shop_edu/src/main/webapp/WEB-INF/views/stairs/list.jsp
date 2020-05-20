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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
<title>코드관리</title>


<script type="text/javascript">

$(document).ready(function(){

	$("#example-table-1 tr").click(function(){ 	
	
		var tdArr = new Array();	// 배열 선언
		var checkbox = $("input[name=chk_box]").is(':checked');
		
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
		
		// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
		console.log("클릭한 Row의 모든 데이터 : "+tr.text());

		
		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		td.each(function(i){
			tdArr.push(td.eq(i).text());
		});
		
		console.log("배열에 담긴 값 : "+tdArr);
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var cdno = td.eq(0).text();
		var cdlvl = td.eq(1).text();
		var upcd = td.eq(2).text();
		var cdname = td.eq(3).text();
// 		var useyn = td.eq(5).text();
// 		var useyn = $('input:checkbox[name="chk_box"]').is(':checked');

		
		// 체크박스 값 가져옴
		var chk = td.eq(4).find('input[type="checkbox"]').is(':checked') ;

		console.log('----------->>>>>>>>>  ' + chk);

		

		$("#cdno").val(cdno);
		$("#cdlvl").val(cdlvl);
		$("#upcd").val(upcd);
		$("#cdname").val(cdname);
		$("#useyn").val(useyn);
// 		alert("체크박스"+useyn);
		
		
		if(chk){
			$("#useyn").prop("checked", true);
		}else{
			$("#useyn").prop("checked", false);
		}
	
		

	});
	
});



	$(document).ready(function(){
		$("#update_btn").click(function(){

	    // 텍스트 박스 readonly 처리
		// $("#txtBox").attr("readonly",true);
	    
		    $("#cdlvl").removeAttr("readonly");
		    $("#upcd").removeAttr("readonly");
		    $("#cdname").removeAttr("readonly");
		    $("#useyn").removeAttr("disabled");
		   
		    
	   
	}); 
});
	
	$(document).ready(function(){
		
		
		
		$("#add_btn").click(function(){
			
			$("#cdno").val("");
			$("#cdlvl").val("");
			$("#upcd").val("");
			$("#cdname").val("");
			$("#useyn").val("");
		

		
	    $("#cdlvl").removeAttr("readonly");
	    $("#upcd").removeAttr("readonly");
	    $("#cdname").removeAttr("readonly");
	    $("#useyn").removeAttr("disabled");
	    
	    
	}); 
});
	

	    

	
</script>
</head>

<body>


<div class="container">
  <h4>전체리스트</h4> 
  <div style="overflow-y:scroll;max-height:300px;">     
	  <table class="table table-bordered table-hover text-center" id="example-table-1">
	  
	    <thead>
	      <tr>
	        <th>코드번호</th>
	        <th>코드레벨</th>
	        <th>상위코드</th>
	        <th>코드이름</th>
	        <th>사용여부</th>
	        <th style="display: none;">사용여부</th>
	      </tr>
	    </thead>
	    <tbody>
	     	<c:forEach items="${totalList }" var="detailDto">	
		      <tr>
			        <td>${detailDto.cdno}</td>
			        <td>${detailDto.cdlvl}</td>
			        <td>${detailDto.upcd}</td>
			        <td>${detailDto.cdname}</td>
			        <c:if test="${detailDto.useyn == 'Y'}">
			        <td><input type="checkbox" id="chk_box" name="chk_box" disabled checked ></td>
			        </c:if>
			        <c:if test="${detailDto.useyn == 'N'|| detailDto.useyn == null}">
			        <td><input type="checkbox" id="chk_box" name="chk_box" disabled></td>
			        </c:if>
		      </tr>
	   		 </c:forEach>
	    </tbody>
	  </table>
	 
  </div>
  
  
  		<div class="container">
		  <h4>코드내용</h4>
		  <form action="codeAddUpdate.do" method="post" name="CodeForm">
		    <div class="form-group">
		      <label>코드번호:</label>
		      <input type="text" class="form-control" id="cdno" name="cdno" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>코드레벨:</label>
		      <input type="text" class="form-control" id="cdlvl" name="cdlvl" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>상위코드:</label>
		      <input type="text" class="form-control" id="upcd" name="upcd" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>코드이름:</label>
		      <input type="text" class="form-control" id="cdname" name="cdname" readonly checked>
		     
		   
		    </div>
		    
		    <div class="form-group">
		      <label>사용여부:</label>
		        <input type="checkbox" id="useyn" name="useyn" disabled> 사용
		    </div>
		    
		    <button type="button" class="btn btn-secondary" id="add_btn">추가</button>
		    <button type="button" class="btn btn-secondary" id="update_btn">수정</button>
		    <button type="submit" class="btn btn-secondary" id="save_btn">저장</button>
		  </form>
		  
		</div>
  
  
</div>


</body>
</html>