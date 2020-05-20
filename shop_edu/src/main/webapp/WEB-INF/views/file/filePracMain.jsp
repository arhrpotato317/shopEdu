<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<html>
<head>
	<title>첨부파일</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("a[name='file-delete']").on("click", function(e) {
				e.preventDefault();
				deleteFile($(this));
			});
		});
		
		function addFile(e) {
			e.preventDefault();
			var str = "<div class='file-group'><input type='file' name='file'><a href='' name='file-delete'>파일 삭제하기</a></div>";
			$("#file-list").append(str);
			
			$("a[name='file-delete']").on("click", function(e) {
				e.preventDefault();
				deleteFile($(this));
			});
		}
		
		function deleteFile(obj) {
			obj.parent().remove();
		}
	</script>
</head>
<body>
	<h1>첨부파일 연습</h1>
	
	<form action="" method="post" enctype="multipart/form-data">
		<div class="form-group" id="file-list">
			<a href="" onclick="addFile(event)">파일 추가하기</a>
			<div class="file-group">
				<input type="file" name="file">
				<a href="" name="file-delete">파일 삭제하기</a>
			</div>
		</div>
		<input type="button" value="작성하기">
	</form>
</body>
</html>
