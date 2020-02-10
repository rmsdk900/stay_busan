<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>

<!-- roomInfo -->
<c:if test="${!empty roomInfo}">
	<div class="room">
		<div class="room_imgs">
			<div>[사진1]</div>
			<div>[사진2]</div>
			<div>[사진3]</div>
			<div>[사진4]</div>
			<div>[사진5]</div>
			<div>
				<a href="#">사진 보기</a>
			</div>
		</div>
		<hr/>
		<div class="room_wrapper">
			<div class="room_primary">
				<div>
					<h2>${roomInfo.roomVO.r_name}</h2>
				</div>
				<div>
					<div>[호스트 사진]</div>
					<div>
						${roomInfo.hostVO.u_name}
						<c:if test="${roomInfo.hostVO.u_type == 2 or roomInfo.hostVO.u_type == 3}" >
							<img src="${pageContext.request.contextPath}/resources/img/vip.png" style="width:20px;height:20px;" />	
						</c:if>
					</div>
					
				</div>
				<div>
					<p>주소 : ${roomInfo.roomVO.r_addr_main}</p>
				</div>
				<div>
					<ul>
						<li>인원 : ${roomInfo.roomVO.r_guests}</li>
						<li>침실 : ${roomInfo.roomVO.r_bedroom}</li>
						<li>침대 : ${roomInfo.roomVO.r_bed}</li>
						<li>욕실 : ${roomInfo.roomVO.r_bath}</li>
					</ul>
				</div>
				
			</div>
			<hr/>
			<div class="room_amenity">
				<ul>
					<li>와이파이 : ${roomInfo.amenityVO.a_wifi == 1 ? '있음' : '없음' }</li>
					<li>난방 : ${roomInfo.amenityVO.a_heating == 1 ? '있음' : '없음' }</li>
					<li>TV : ${roomInfo.amenityVO.a_TV == 1 ? '있음' : '없음' }</li>
					<li>주방 : ${roomInfo.amenityVO.a_kitchen == 1 ? '있음' : '없음' }</li>
					<li>헤어 드라이어 : ${roomInfo.amenityVO.a_hairdryer == 1 ? '있음' : '없음' }</li>
					<li>다리미 : ${roomInfo.amenityVO.a_iron == 1 ? '있음' : '없음' }</li>
					<li>옷걸이 : ${roomInfo.amenityVO.a_hanger == 1 ? '있음' : '없음' }</li>
					<li>수건 : ${roomInfo.amenityVO.a_towel == 1 ? '있음' : '없음' }</li>
					<li>엘리베이터 : ${roomInfo.amenityVO.a_elevator == 1 ? '있음' : '없음' }</li>
					<li>주차가능 : ${roomInfo.amenityVO.a_parking == 1 ? '있음' : '없음' }</li>
					<li>세탁기 : ${roomInfo.amenityVO.a_washer == 1 ? '있음' : '없음' }</li>
					<li>조리기구 : ${roomInfo.amenityVO.a_cookware == 1 ? '있음' : '없음' }</li>
					<li>냉장고 : ${roomInfo.amenityVO.a_refri == 1 ? '있음' : '없음' }</li>
					<li>가스레인지 및 버너 : ${roomInfo.amenityVO.a_burner == 1 ? '있음' : '없음' }</li>
					<li>식기 : ${roomInfo.amenityVO.a_dish == 1 ? '있음' : '없음' }</li>
					<li>전자레인지 : ${roomInfo.amenityVO.a_micro == 1 ? '있음' : '없음' }</li>
					<li>에어컨 : ${roomInfo.amenityVO.a_aircon == 1 ? '있음' : '없음' }</li>
				</ul>
			</div>
			<hr/>
			<div class="room_description">
				<div>
					<p>방 설명 : ${roomInfo.roomVO.r_desc}</p>
				</div>
				<div>
					<input type="button" value="호스트에게 질문"/>
				</div>
			</div>
			<hr/>
			<div class="room_host_description">
				<div>
					<h4>
						호스트 : ${roomInfo.hostVO.u_name}님
						<c:if test="${roomInfo.hostVO.u_type == 2 or roomInfo.hostVO.u_type == 3}" >
							<img src="${pageContext.request.contextPath}/resources/img/vip.png" style="width:20px;height:20px;"/>	
						</c:if>
					</h4>
				</div>
				<div>
					<p>회원가입 : <fmt:formatDate value="${roomInfo.hostVO.u_regdate}" pattern="yyyy년 MM월"/></p>
				</div>
				<div>
					<p>후기 : 개</p>
				</div>
				
				<div>
					<p> 호스트 자기 소개 : </p>
				</div>
				<hr/>
				<div>
					<p>${roomInfo.hostVO.u_introduce}</p>
				</div>
				
				
			</div>
			<hr/>
			<%@ include file="../comment/comment.jsp" %>
			
			<div class="room_reservation">
				<form>
					<div>
						<div>
							<span>${roomInfo.roomVO.r_price}</span>
							<span>/박</span>
						</div>
						<div>[평균 평점]</div>
						<div>(후기 [후기 갯수]개)</div>
						<hr/>
					</div>
					<div>
						<div>날짜</div>
						<div>[달력]</div>
					</div>
					<div>
						<div>인원</div>
						<div>
							<label><input type="number" name="b_guest" /> 명</label>	
						</div>
					</div>
					<div>
						<div>합계</div>
						<div>[총 가격]</div>
					</div>
					<div>
						<input type="button" value="예약하기"/>
					</div>
				</form>
				
			</div>
			<div class="room_message">
				<div>
					<div>
						<h1>쪽지 보내기</h1>
					</div>
				</div>
				<div>
					받을 사람 : ${roomInfo.hostVO.u_name}
				</div>
				<div>
					<div>
						<textarea rows="5" cols="30"></textarea>
					</div>
				</div>
				<div>
					<input type="button" value="send"/>
				</div>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript">
		var contextPath = '${pageContext.request.contextPath}';
		var r_no = ${roomInfo.roomVO.r_no};	
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/comment.js"></script>
</c:if>

<hr/>
<%@ include file="../common/footer.jsp" %>