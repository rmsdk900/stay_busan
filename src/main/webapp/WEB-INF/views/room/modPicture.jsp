<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 사진 더 보기 모달 -->
<style>
	.pictures_add{
		/* width:100%;
		height: 150px; */
		/* border:1px solid gray;
		background-image: url("${pageContext.request.contextPath}/resources/img/box.png");
		background-repeat: no-repeat;
		background-size: auto;
		margin:auto; */
	}
	
	.pictures_add img {
		width: 100%;
	}
	
	.mod_imgs {
		width: 100%;
	}
	.mod_imgs img {
		width: 100%;
	}
	.pictures_preview {
		display : grid;
		grid-template-columns: auto auto auto; 
		
	}
</style>
<div class="modal fade" id="modPicture" 
tabindex="-1" role="dialog" 
aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" 
				data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true" >&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">사진 편집</h4>
			</div>
			<div class="modal-body">
				<div class="pictures_add">
					<img src="${pageContext.request.contextPath}/resources/img/box.png" alt="이미지 업로드" />
				</div>
				<form id="modifyForm" action="modRoomImgs" method="post">
					<input type="hidden" name="u_no" value="${roomInfo.roomVO.u_no}"/>
					<input type="hidden" name="r_no" value="${roomInfo.roomVO.r_no}"/>
					<div class="pictures_preview">
					</div>	
				</form>
								
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="updateImgBtn">변경</button>
			</div>
		</div>
	</div>
</div>