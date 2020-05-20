<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>empList</title>
	
	<style>
		table {
			width: 50%;
			border: 1px solid #cecece;
			padding: 20px;
		}
	</style>
</head>
<body>
	<h1>사원목록</h1>
	
	<form action="empListParam.do" method="post">
		사원번호 : <input type="text" id="empNo" name="empNo" placeholder="사원번호를 입력해주세요.">
		부서번호 : <input type="text" id="deptNo" name="deptNo" placeholder="부서번호를 입력해주세요.">
		<input type="submit" value="검색">
	</form>
	
	<c:if test="${not empty msg}">
		<p>${msg}</p>
	</c:if>
	
	<table>
		<colgroup>
			<col width="10%">
			<col width="10%">
			<col width="30%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>사원명</th>
				<th>판매량</th>
				<th>입사일</th>
				<th>사원번호</th>
				<th>MGR</th>
				<th>직종</th>
				<th>부서번호</th>
				<th>급여</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(empListParam) > 0 }">
					<c:forEach items="${empListParam}" var="emp">
						<tr>
							<td>${emp.ename}</td>
							<td>${emp.comm}</td>
							<td>${emp.hiredate}</td>
							<td>${emp.empno}</td>
							<td>${emp.mgr}</td>
							<td>${emp.job}</td>
							<td>${emp.deptno}</td>
							<td>${emp.sal}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<th colspan="8">조회된 결과가 없습니다.</th>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>
