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
				<div class="show_host_rooms_list_room_img">
					<img src="${pageContext.request.contextPath}/displayFile?fileName=${room.imgList[0]}" alt="대표 이미지" />
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
						<input type="button" value="숙소 관리" data-r_no="${room.r_no}" />
						<input type="button" value="댓글 관리" data-r_no="${room.r_no}" class="btnReview"/>
					</div>
				</c:if>
				
			</c:forEach>
			
		</div>
		
	</div>
</c:if>
