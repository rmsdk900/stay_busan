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
						<c:if test="${myAllInfo.userVO.u_no == login}">
							<div>
								<input type="button" value="댓글 관리" data-r_no="${room.r_no}" class="btnReview"/>
								<input type="button" value="방 삭제" data-r_no="${room.r_no}" class="btnDelRoom" />
							</div>
						</c:if>
					</c:if>
			</c:forEach>
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
						<c:if test="${myAllInfo.userVO.u_no == login}">
							<div>
								<input type="button" value="방 복원" data-r_no="${room.r_no}" class="btnRestoreRoom" />
							</div>
						</c:if>
					</c:if>
			</c:forEach>
		</div>
		
	</div>
</c:if>
