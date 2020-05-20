<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>rowValue</title>
</head>
<body>
	<script>
	// 동적 row값 가져오기
	$(document).on("click", "#tabList tr", function() {
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();

		console.log("클릭한 Row의 모든 데이터 : " + td.text());

		// td.eq(index)를 통해 값을 가져올 수도 있다.
		ITEMCD = td.eq(0).text();
		ITEMNAME = td.eq(1).text();
		MADENMCD = td.eq(2).text();
		MADE = td.eq(3).text();
		ITEMUNITCD = td.eq(4).text();
		ITEMUNITCD = td.eq(5).text();
		STOCKATM = td.eq(6).text();
		USEYN = td.eq(7).text().trim();
		ITEMCLSCD = td.eq(8).text().trim();

		
		codeInput_itemCd.disabled = true;
		codeInput_itemName.disabled = true;
		codeInput_made.disabled = true;
		codeInput_itemunitCd.disabled = true;
		codeInput_useyn.disabled = true;
		
		
		document.codeForm.ITEMCD.value = ITEMCD;
		document.codeForm.ITEMNAME.value = ITEMNAME;
		document.codeForm.MADE.value = MADENMCD;
//			$('#MADE option[value=MADENMCD]').prop('selected',true);
//			$('select[name="MADE"]').find('option:contains(MADENMCD)').attr("selected",true);
		document.codeForm.ITEMUNITCD.value = ITEMUNITCD;
		document.codeForm.USEYN.value = USEYN;
		document.codeForm.ITEMCLSCD.value = ITEMCLSCD;
		
		if(USEYN == "Y"){
			$( 'input[name="USEYN_RE"]' ).prop( 'checked', true );				
		}else{
			$( 'input[name="USEYN_RE"]' ).prop( 'checked', false );
		}

	});
	</script>
</body>
</html>
