<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.show_host_rooms_list_room_img{
		width: 296px;
		height: 200px;
	}
	.show_host_rooms_list_room_img img {
		width: 100%;
		height: 100%;
	}
</style>
<c:if test="${!empty myAllInfo.hosting}">
	<div class="show_host_rooms_wrapper">
		<div>
			<h3>
				<c:out value="${myAllInfo.userVO.u_name}"/>의 숙소
			</h3>
		</div>
		<div class="show_host_rooms_list">
			<c:forEach var="room" items="${myAllInfo.hosting}">
					<c:if test="${room.r_deleted == 0}">
						<div class="show_host_rooms_list_room_img">
							
							<a href="${pageContext.request.contextPath}/room/detail?r_no=${room.r_no}">
								<img src="${pageContext.request.contextPath}/displayFile?fileName=${room.imgList[0]}" alt="대표 이미지" />
							</a>
							
						</div>
						<div>
							<h4>${room.r_name}</h4>
						</div>
						<div>
							<span>★ </span>
							<span>
								<fmt:formatNumber value="${room.r_star}" pattern="0.##"/>
							</span>
							
						</div>
						<div>
							<span>총 예약 : </span>
							<span><c:out value="${room.r_bookedcnt}"/></span>
						</div>
						<c:if test="${myAllInfo.userVO.u_no eq login}">
							<div>
								<input type="button" value="댓글 관리" data-r_no="${room.r_no}" class="btnReview" />
								<input type="button" value="${room.r_no}번 방 삭제" data-r_no="${room.r_no}" data-toggle="modal"
								data-target="#delRoom"  class="modalBtnDelRoom"/>
							</div>
							
							
							
						</c:if>
					</c:if>
			</c:forEach>
			<!-- 방 삭제 기능 구현 -->
			<div class="delRoomView"></div>
		</div>
		
	</div>
	<div class="deleted_host_rooms_wrapper">
		<div>
			<h3>
				<c:out value="${myAllInfo.userVO.u_name}"/>의 삭제된 숙소
			</h3>
		</div>
		<div class="show_host_rooms_list">
			<c:forEach var="room" items="${myAllInfo.hosting}">
					<c:if test="${room.r_deleted == 1}">
						<div class="show_host_rooms_list_room_img">
							
							<a href="${pageContext.request.contextPath}/room/detail?r_no=${room.r_no}">
								<img src="${pageContext.request.contextPath}/displayFile?fileName=${room.imgList[0]}" alt="대표 이미지" />
							</a>
							
						</div>
						<div>
							<h4>${room.r_name}</h4>
						</div>
						<div>
							<span>★ </span>
							<span>
								<fmt:formatNumber value="${room.r_star}" pattern="0.##"/>
							</span>
							
						</div>
						<div>
							<span>총 예약 : </span>
							<span><c:out value="${room.r_bookedcnt}"/></span>
						</div>
						
					</c:if>
			</c:forEach>
		</div>
		
	</div>
</c:if>
<script>
	$(".modalBtnDelRoom").on("click", function(){
		var r_no=$(this).attr("data-r_no");
		
		var html = "";
		
		html += "<div class='modal fade' id='delRoom' ";
		html += " tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true' >";
		html += "	<div class='modal-dialog modal-sm'>";
		html += "		<div class='modal-content'>";
		html += "			<div class='modal-header'>";
		html += "				<button type='button' class='close' data-dismiss='modal' aria-label='close' >";
		html += "					<span aria-hidden='true'>&times;</span>";
		html += "				<button>";
		html += "				<h4 class='modal-title' id='myModalLabel' >"+r_no+"번 방 삭제 확인</h4>";
		html += "			</div>";
		html += "			<div class='modal-body'>";
		html += "				<p>"+r_no+"번 방을 정말 삭제하시겠습니까?</p>";
		html += "			</div>";
		html += "			<div class='modal-footer'>";
		html += "			<button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>";
		html += "			<button type='button' class='btn btn-primary' id='btnDelRoom' data-r_no='"+r_no+"'>방 삭제</button>";
		html += "			</div>";
		html += "		</div>";
		html += "	</div>";
		html += "</div>";
		
		$(".delRoomView").html(html);
		
	});
	
	$(".delRoomView").on("click", "#btnDelRoom", function(){
		var r_no = $(this).attr("data-r_no");
		console.log(r_no);
		$.post(contextPath+"/room/hide", {
			r_no: r_no
		}, function(data){
			console.log(data);
			location.reload();
		});
	});
</script>