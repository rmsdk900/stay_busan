<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./common/header.jsp" %>

<style>

	table {
		width:100%;
	}
	
	.fileDrop{
		width:100%;
		height:150px;
		border:1px solid gray;
		background-color:lightslategray;
		margin:auto;
	}
	
	.uploadList{
		width:100%;
	}
	
	.uploadList li{
		float:left;
		padding:20px;
	}
	
	ul li{
		list-style:none;
	}
	
	.clear{
		clear:both;
	}
	
	li a{
		font-size:12px;
		text-decoration:none;
		color:gray;
	}
	
</style>
	<form action="${pageContext.request.contextPath}/room/detail" method="get">
		<input type="text" name="r_no" />
		<input type="submit" value="번 글 상세보기"/>
	</form>
	<form action="${pageContext.request.contextPath}/user/show" method="get">
		<input type="text" name="u_no"/>
		<input type="submit" value="번 유저 마이페이지 이동" />
	</form>
	<div>
		<label>File Drop Here</label>
		<div class="fileDrop">
		
		</div>
	</div>
	<div>
		<ul class="uploadList">
			
		</ul>
	</div>
	
	<a href="room/transfer">transfer</a>
	
	<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
	<script>
		var message = '${message}';
		console.log("예약 여부 확인 : "+message);
		
		if(message == 'y'){
			alert("예약 성공!");
		}else if(message=='n') {
			alert("예약 실패!");
		}
		
		$(".fileDrop").on("dragenter dragover",function(event){
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files;
			
			var maxSize = 10485760;
			
			var formData = new FormData();
			
			for(var i=0; i<files.length;i++){
				if(files[i].size > maxSize){
					alert("업로드 할 수 없는 파일이 포함되어 있습니다."+files[i].size);
					return;
				}
				console.log(files[i]);
				formData.append("file",files[i]);
			}
			
			$.ajax({
				type : "POST",
				data : formData,
				url : contextPath+"/uploadFile/"+1+"/"+2,
				dataType : "json",
				processData : false,
				contentType : false,
				success : function(data){
					console.log(data.length);
					for(var i =0; i< data.length; i++){
						console.log(data[i]);
						var fileInfo = getFileInfo(data[i]);
						
						var html = "<li>";
							html += "<img src='"+fileInfo.imgSrc+"' alt='attachment'/>";
							html += "<div>";
							html += "<a href='"+fileInfo.getLink+"' target='_blank'>";
							html += fileInfo.fileName;
							html += "</a>";
							html += "&nbsp;&nbsp;&nbsp;";
							html += "<a href='"+fileInfo.fullName+"' class='delBtn'>[삭제]</a>";
							html += "</div>";
							html += "</li>";
						$(".uploadList").append(html);
					}
				},
				error : function(res){
					alert(res.responseText);
				}
			});
		});	
	</script>
	
</body>
</html>