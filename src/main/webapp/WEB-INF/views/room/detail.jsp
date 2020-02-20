<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<script type="text/javascript">
	var r_no = ${roomInfo.roomVO.r_no};	
</script>
<style>
	.room_imgs {
		display: grid;
		grid-template-columns: auto auto auto;
		width:100%;
		
	}
	.room_img_primary{
		width: 600px;
		height: 600px;
		overflow: hidden;
	}
	.room_img_etc{
		overflow: hidden;
	}
	.room_img_third{
		overflow: hidden;
	}
	.room_img_primary img {
		transform:scale(1);
		transition:.3s;
	}
	
	.room_img_primary:hover img {
		transform:scale(1.1);
	}
	
	
	
	.room_img_etc{
		width: 300px;
		height: 300px;
	}
	
	.room_img_etc img {
		transform:scale(1);
		transition:.3s;
	}
	
	.room_img_etc:hover img {
		transform:scale(1.1);
	}
	
	.room_host_img{
		width: 100px;
		height: 100px;
	}
	
	.FilledImg{
		
		width: 100%;
		height: 100%;
	}
	
	.room_reservation_people_message{
		display: none;
	}
	
	.text_red{
		color:red;
	}
	
	.text_green{
		color:green;
	}
	
</style>
<!-- roomInfo -->
<c:if test="${!empty roomInfo}">
	<div class="room">
		<div >
			<div class="room_imgs">
				<div class='room_img_primary' onclick="openSlide"></div>
				<div class='room_img_second'></div>
				<div class='room_img_third'></div>
			</div>
			<!-- 모달 연결 버튼 -->
			<div class="room_imgs_more">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#roomPicturesModal">
					사진 보기
				</button>
				<c:if test="${roomInfo.roomVO.u_no == login}">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#">
						사진 변경
					</button>
				</c:if>
			</div>
			
			<%@ include file="./pictureModal.jsp" %>
		</div>
		<hr/>
		<div class="room_wrapper">
			<div class="room_primary">
				<div>
					<h2 class="room_primary_title" >${roomInfo.roomVO.r_name}</h2>
					<input type="text" name="r_name" value="${roomInfo.roomVO.r_name}" 
					class="room_primary_title_modify" />
				</div>
				<div>
					<div class="room_host_img"></div>
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
					<ul class="room_primary_facility">
						<li class="room_primary_guests">인원 : <span>${roomInfo.roomVO.r_guests}</span></li>
						<li class="room_primary_bedroom">침실 : <span>${roomInfo.roomVO.r_bedroom}</span></li>
						<li class="room_primary_bed">침대 : <span>${roomInfo.roomVO.r_bed}</span></li>
						<li class="room_primary_bath">욕실 : <span>${roomInfo.roomVO.r_bath}</span></li>
					</ul>
					<ul class="room_primary_facility_modify">
						<li>
							인원 : <input class="room_primary_guests_modify" type="number" name="r_guests" min="1" step="1" value="${roomInfo.roomVO.r_guests}" />
						</li>
						<li>
							침실 : <input class="room_primary_bedroom_modify" type="number" name="r_bedroom" min="0" step="1" value="${roomInfo.roomVO.r_bedroom}" />
						</li>
						<li>
							침대 : <input class="room_primary_bed_modify" type="number" name="r_bed" min="0" step="1" value="${roomInfo.roomVO.r_bed}" /> 
						</li>
						<li>
							욕실 : <input class="room_primary_bath_modify" type="number" name="r_bath" min="0" step="1" value="${roomInfo.roomVO.r_bath}" />
						</li>
					</ul>
				</div>
				
			</div>
			
			<hr/>
			<div >
				<div>
					<div class="room_description">방 설명 : ${roomInfo.roomVO.r_desc}</div>
					<textarea class="room_description_modify" name="r_desc">${roomInfo.roomVO.r_desc}</textarea>
				</div>
				<div>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#messageModal" data-whatever="${roomInfo.hostVO.u_name}">
						호스트에게 쪽지 보내기
					</button>
				</div>
				
			</div>
			<c:if test="${roomInfo.roomVO.u_no == login}">
					<div class="room_reservation_per_price_modify">
						1박당 1인 가격 : <input type= "number" name="r_price" value="${roomInfo.roomVO.r_price}" 
						class="r_price" step="100" min="0"/> 원
					</div>
					<div class="room_primary_modify_btn">
						<button type="button" class="room_primary_modify" >
							방 기본 정보 수정
						</button>
						<button type="button" class="room_primary_modify_submit">
							수정
						</button>
						<button type="button" class="room_primary_modify_cancel">
							취소
						</button>
					</div>
				</c:if>
			<hr/>
			<div class="room_amenities">
				<ul>
					<li class="room_amenity wifi">와이파이 : <span>${roomInfo.amenityVO.a_wifi == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify">
						와이파이 : 
						<select class="wifi_available" name="a_wifi">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_wifi == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_wifi == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity heating">난방 : <span>${roomInfo.amenityVO.a_heating == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify">
						난방 : 
						<select class="heating_available" name="a_heating">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_heating == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_heating == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity TV">TV : <span>${roomInfo.amenityVO.a_TV == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						TV : 
						<select class="TV_available" name="a_TV">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_TV == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_TV == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity kitchen">주방 : <span>${roomInfo.amenityVO.a_kitchen == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						주방 : 
						<select class="kitchen_available" name="a_kitchen">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_kitchen == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_kitchen == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity hairdryer">헤어 드라이어 : <span>${roomInfo.amenityVO.a_hairdryer == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						헤어 드라이어 : 
						<select class="hairdryer_available" name="a_hairdryer">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_hairdryer == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_hairdryer == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity iron">다리미 : <span>${roomInfo.amenityVO.a_iron == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						다리미 : 
						<select class="iron_available" name="a_iron">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_iron == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_iron == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity hanger">옷걸이 : <span>${roomInfo.amenityVO.a_hanger == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						옷걸이 : 
						<select class="hanger_available" name="a_hanger">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_hanger == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_hanger == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					
					<li class="room_amenity towel">수건 : <span>${roomInfo.amenityVO.a_towel == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						수건 : 
						<select class="towel_available" name="a_towel">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_towel == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_towel == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity elevator">엘리베이터 : <span>${roomInfo.amenityVO.a_elevator == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						엘리베이터 : 
						<select class="elevator_available" name="a_elevator">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_elevator == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_elevator == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity parking">주차가능 : <span>${roomInfo.amenityVO.a_parking == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						주차가능 : 
						<select class="parking_available" name="a_parking">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_parking == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_parking == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity washer">세탁기 : <span>${roomInfo.amenityVO.a_washer == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						세탁기 : 
						<select class="washer_available" name="a_washer">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_washer == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_washer == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity cookware">조리기구 : <span>${roomInfo.amenityVO.a_cookware == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						조리기구 : 
						<select class="cookware_available" name="a_cookware">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_cookware == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_cookware == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity refri">냉장고 : <span>${roomInfo.amenityVO.a_refri == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						냉장고 : 
						<select class="refri_available" name="a_refri">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_refri == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_refri == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity burner">가스레인지 및 버너 : <span>${roomInfo.amenityVO.a_burner == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						가스레인지 및 버너 : 
						<select class="burner_available" name="a_burner">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_burner == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_burner == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity dish">식기 : <span>${roomInfo.amenityVO.a_dish == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						식기 : 
						<select class="dish_available" name="a_dish">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_dish == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_dish == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity micro">전자레인지 : <span>${roomInfo.amenityVO.a_micro == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						전자레인지 : 
						<select class="micro_available" name="a_micro">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_micro == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_micro == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
					<li class="room_amenity aircon">에어컨 : <span>${roomInfo.amenityVO.a_aircon == 1 ? '있음' : '없음' }</span></li>
					<li class="room_amenity_modify" >
						에어컨 : 
						<select class="aircon_available" name="a_aircon">
							<option value="1" <c:out value="${roomInfo.amenityVO.a_aircon == 1 ? 'selected' : '' }"/>>있음</option>
							<option value="0" <c:out value="${roomInfo.amenityVO.a_aircon == 0 ? 'selected' : '' }"/>>없음</option>
						</select>
					</li>
				</ul>
				<c:if test="${roomInfo.roomVO.u_no == login}">
					<div>
						<button type="button" class="room_amenity_modify_btn" >
							방 편의 정보 수정
						</button>
						<button type="button" class="room_amenity_modify_submit" >
							수정
						</button>
						<button type="button" class="room_amenity_modify_cancel" >
							취소
						</button>
					</div>
				</c:if>
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
					<p> 호스트 자기 소개 : </p>
				</div>
				<hr/>
				<div>
					<p>${roomInfo.hostVO.u_introduce}</p>
				</div>
				
				
			</div>
			<hr/>
			<%@ include file="../comment/comment.jsp" %>
			<!-- 예약 폼 -->
			<div class="room_reservation">
				<form id="bookingForm" action="bookingRoom" method="post">
					<input type="hidden" name="r_no" value="${roomInfo.roomVO.r_no}" />
					<!-- 얘는 지금 호스트 번호로 구매를 하게 되어있지만 회원가입 로그인 구현 되면 로그인한 사람으로 바꿀 것! -->
					<input type="hidden" name="u_no" value="${roomInfo.hostVO.u_no}" />
					<div>
						<div>
							<span class="room_reservation_per_price">${roomInfo.roomVO.r_price}</span>
							<span class="room_reservation_days">/ [0] 박</span>
						</div>
						<div class="room_reservation_star">[평균 평점]</div>
						<div class="room_reservation_total">(후기 [후기 갯수]개)</div>
						<hr/>
					</div>
					<div>
						<div>날짜</div>
						<div>
							<input type="text" id="startDate" name="date_from_dummy" readonly>-<input type="text" id="endDate" name="date_to_dummy" readonly>
							<div class="room_reservation_how_many"> 숙박 중 : 
								<span class="room_reservation_how_many_people">0</span>
								 / 
								<span class="room_reservation_how_many_total">${roomInfo.roomVO.r_guests}</span>
								 명
							</div>
						</div>
					</div>
					<div>
						<div>인원</div>
						<div class="room_reservation_people">
							<label><input id="b_guest" type="number" name="b_guest" min="0" max="${roomInfo.roomVO.r_guests}" step="1"/> 명</label>
							<div class="room_reservation_people_message "></div>	
						</div>
					</div>
					<div class="room_reservation_price" style="display:none;">
						<div>합계</div>
						<div class="room_reservation_price_real">[총 가격]</div>
					</div>
					<input type="hidden" name="b_total_price" id="b_total_price" />
					<div>
						<input type="button" class="room_reservation_choose_date"value="날짜선택"/>
						<input type="button" class="room_reservation_submit"value="예약하기" style="display:none;"/>
					</div>
				</form>
			</div>
			<br/>
			<div class="room_message">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#messageModal" data-whatever="${roomInfo.hostVO.u_name}">
					호스트에게 쪽지 보내기
				</button>
				
				<%@ include file="./messageModal.jsp" %>
				
				
			</div>
		</div>
		
	</div>
	
	<script src="${pageContext.request.contextPath}/resources/js/comment.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
	<script>
		$(function(){
			// 가리기 부터
			$(".room_primary_title_modify").hide();
			$(".room_primary_facility_modify").hide();
			$(".room_primary_modify_submit").hide();
			$(".room_primary_modify_cancel").hide();
			$(".room_description_modify").hide();
			$(".room_reservation_per_price_modify").hide();
			
			$(".room_amenity_modify").hide();
			$(".room_amenity_modify_submit").hide();
			$(".room_amenity_modify_cancel").hide();
			
		});
		// 수정에 필요한 것들 보이기
		$(".room_primary_modify").on("click",function(){
			
			$(".room_primary_title_modify").show('slow');
			$(".room_primary_facility_modify").show('slow');
			$(".room_primary_modify_submit").show('slow');
			$(".room_primary_modify_cancel").show('slow');
			$(".room_description_modify").show('slow');
			$(".room_reservation_per_price_modify").show('slow');
			
			$(".room_primary_modify").hide('slow');
			$(".room_primary_title").hide('slow');
			$(".room_primary_facility").hide('slow');
			$(".room_description").hide('slow');
			
		});
		// 취소버튼 눌렀을 때 다시 감추기
		$(".room_primary_modify_cancel").on("click", function(){
			$(".room_primary_title_modify").hide('slow');
			$(".room_primary_facility_modify").hide('slow');
			$(".room_primary_modify_submit").hide('slow');
			$(".room_primary_modify_cancel").hide('slow');
			$(".room_description_modify").hide('slow');
			$(".room_reservation_per_price_modify").hide('slow');
			
			$(".room_primary_modify").show('slow');
			$(".room_primary_title").show('slow');
			$(".room_primary_facility").show('slow');
			$(".room_description").show('slow');
		});
		// 방 기본 정보 수정
		$(".room_primary_modify_submit").on("click", function(){
			
			var r_name = $(".room_primary_title_modify").val();
			var r_guests = $(".room_primary_guests_modify").val();
			var r_bedroom = $(".room_primary_bedroom_modify").val();
			var r_bed = $(".room_primary_bed_modify").val();
			var r_bath = $(".room_primary_bath_modify").val();
			var r_desc = $(".room_description_modify").val();
			var r_price= $(".r_price").val();
			console.log(r_no);
			console.log(r_name);
			console.log(r_guests);
			console.log(r_bedroom);
			console.log(r_bed);
			console.log(r_bath);
			console.log(r_desc);
			console.log(r_price);
			
			$.post(contextPath+"/room/modify", {
				r_no: r_no,
				r_name: r_name,
				r_guests: r_guests,
				r_bedroom: r_bedroom,
				r_bed: r_bed,
				r_bath: r_bath,
				r_desc: r_desc,
				r_price: r_price
			}, function(data){
				console.log(data);
				
				$(".room_primary_title").html(data.r_name);
				$(".room_primary_title_modify").val(data.r_name);
				$(".room_primary_guests span").html(data.r_guests);
				$(".room_primary_guests_modify").val(data.r_guests);
				$(".room_primary_bedroom span").html(data.r_bedroom);
				$(".room_primary_bedroom_modify").val(data.r_bedroom);
				$(".room_primary_bed span").html(data.r_bed);
				$(".room_primary_bed_modify").val(data.r_bed);
				$(".room_primary_bath span").html(data.r_bath);
				$(".room_primary_bath_modify").val(data.r_bath);
				$(".room_description").html(data.r_desc);
				$(".room_description_modify").val(data.r_desc);
				$(".room_reservation_per_price").html(data.r_price);
				$(".r_price").val(data.r_price);
				
				
				
				
				$(".room_primary_title_modify").hide();
				$(".room_primary_facility_modify").hide();
				$(".room_primary_modify_submit").hide();
				$(".room_primary_modify_cancel").hide();
				$(".room_description_modify").hide();
				$(".room_reservation_per_price_modify").hide();
				
				$(".room_primary_modify").show();
				$(".room_primary_title").show();
				$(".room_primary_facility").show();
				$(".room_description").show();
				
			});
			
		});
		
		// 편의시설 정보 수정 창 열기
		$(".room_amenity_modify_btn").on("click",function(){
			$(".room_amenity").hide('slow');
			$(".room_amenity_modify").show('slow');
			
			$(".room_amenity_modify_btn").hide('slow');
			$(".room_amenity_modify_submit").show('slow');
			$(".room_amenity_modify_cancel").show('slow');
		});
		// 취소버튼 클릭 시
		$(".room_amenity_modify_cancel").on("click",function(){
			$(".room_amenity").show('slow');
			$(".room_amenity_modify").hide('slow');
			
			$(".room_amenity_modify_btn").show('slow');
			$(".room_amenity_modify_submit").hide('slow');
			$(".room_amenity_modify_cancel").hide('slow');
		});
		// 편의정보 수정 요청
		$(".room_amenity_modify_submit").on("click",function(){
			var a_wifi = $(".wifi_available").val();
			var a_heating = $(".heating_available").val();
			var a_TV = $(".TV_available").val();
			var a_kitchen = $(".kitchen_available").val();
			var a_hairdryer = $(".hairdryer_available").val();
			var a_iron = $(".iron_available").val();
			var a_hanger = $(".hanger_available").val();
			var a_towel = $(".towel_available").val();
			var a_elevator = $(".elevator_available").val();
			var a_parking = $(".parking_available").val();
			var a_washer = $(".washer_available").val();
			var a_cookware = $(".cookware_available").val();
			var a_refri = $(".refri_available").val();
			var a_burner = $(".burner_available").val();
			var a_dish = $(".dish_available").val();
			var a_micro = $(".micro_available").val();
			var a_aircon = $(".aircon_available").val();
			
			$.post(contextPath+"/room/amenities", {
				r_no: r_no,
				a_wifi: a_wifi,
				a_heating: a_heating,
				a_TV: a_TV,
				a_kitchen: a_kitchen,
				a_hairdryer: a_hairdryer,
				a_iron: a_iron,
				a_hanger: a_hanger,
				a_towel: a_towel,
				a_elevator: a_elevator,
				a_parking: a_parking,
				a_washer: a_washer,
				a_cookware: a_cookware,
				a_refri: a_refri,
				a_burner: a_burner,
				a_dish: a_dish,
				a_micro: a_micro,
				a_aircon: a_aircon
			}, function(data){
				console.log(data);
				
				location.reload();
			});
			
		});
		
		
		$.getJSON(contextPath+"/getImgs/"+r_no, function(data){
			// 첨부파일 목록 = data
			/* console.log(data); */
			
			for(var i=0;i<data.length;i++){
				var fileInfo = getFileInfo(data[i]);
				/* console.log(fileInfo); */
				
				if(i == 0){
					var html = "";
					html += "<img src='"+fileInfo.imgSrc+"' alt='배경 사진"+(i+1)+"' class='FilledImg' onclick='openSlide("+i+")' />";
					$(".room_img_primary").html(html);	
				} else if(i==1 || i==2) {
					var html = "<div ";
					html += "class='room_img_etc' ";
					html += ">";
					html += "<img src='"+fileInfo.imgSrc+"' alt='배경 사진"+(i+1)+"' class='FilledImg' onclick='openSlide("+i+")' />";
					html += "</div>";
					$(".room_img_second").append(html);
				} else if(i==3 || i==4){
					var html = "<div ";
					html += "class='room_img_etc' ";
					html += ">";
					html += "<img src='"+fileInfo.imgSrc+"' alt='배경 사진"+(i+1)+"' class='FilledImg' onclick='openSlide("+i+")' />";
					html += "</div>";
					$(".room_img_third").append(html);
				}else {
					break;
				}
				
				
			}
			
			for(var i=0;i<data.length;i++){
				var fileInfo = getFileInfo(data[i]);
				/* console.log(fileInfo); */
				
				var olli = "";
				olli += "<li data-target='#carousel-example-generic' " +
						"data-slide-to='"+i+"' ";
				if(i==0){
					olli += "class='active' ";
				}
				olli +=	"></li>";
				
				var html = "<div class='item ";
				if (i==0){
					html += "active"; 
				}
				html += "' >";
				html += "<img src='"+fileInfo.imgSrc+"' alt='"+(i+1)+"번째 사진' >";
				html += "<div class='carousel-caption'>...</div>";
				html += "</div>";
				$(".carousel-indicators").append(olli);
				$(".carousel-inner").append(html);
				
			}
		});
		
		$.getJSON(contextPath+"/getHostImg/"+r_no, function(data){
			
			var fileInfo = getFileInfo(data[0]);
			/* console.log(fileInfo); */
			var html = "<img src='"+fileInfo.imgSrc+"' alt='호스트 사진' class='FilledImg' />";
			$(".room_host_img").append(html);
			
		});
		
		function openSlide(i){
			console.log(i);
			$('#roomPicturesModal').modal('show');
			$('.carousel').carousel(i);
		}
		// 공사하자 인원 입력시 안되게 하는 건
		
		$("#b_guest").on("input", function(){
			var cnt = $(this).val();
			if (cnt != null && cnt != ''){
				cnt = parseInt(cnt);
				var booked = parseInt($(".room_reservation_how_many_people").html());
				var total = parseInt($(".room_reservation_how_many_total").html());
				console.log("입력 인원 : "+cnt);
				console.log("예약 및 숙박 인원 : "+booked);
				/* console.log("총 숙박 가능 인원 : "+total); */
				/* console.log("입력 인원 형식 : "+typeof cnt); */
				console.log("넣으려는 인원 : "+(cnt+booked));
				
				
				if(total < (cnt+booked)){
					var message = "<span>최대 숙박 가능한 인원을 초과했습니다.</span>";
					
					$(".room_reservation_people_message").addClass("text_red");
					if($(".room_reservation_people_message").hasClass("text_green")){
						$(".room_reservation_people_message").removeClass("text_green");
					}
					$(".room_reservation_people_message").html(message);	
					$(".room_reservation_people_message").show("slow");	
					
					$(".room_reservation_choose_date").show("slow");
					$(".room_reservation_price").hide("slow");
					$(".room_reservation_submit").hide("slow");
					$(".room_reservation_submit").attr("disabled", true);
				}else if(cnt == 0){
					var message = "<span>0명은 입력할 수 없습니다.</span>";
					$(".room_reservation_people_message").addClass("text_red");
					if($(".room_reservation_people_message").hasClass("text_green")){
						$(".room_reservation_people_message").removeClass("text_green");
					}
					$(".room_reservation_people_message").html(message);	
					$(".room_reservation_people_message").show("slow");		
					
					$(".room_reservation_choose_date").show("slow");
					$(".room_reservation_price").hide("slow");
					$(".room_reservation_submit").hide("slow");
					$(".room_reservation_submit").attr("disabled", true);
				}else if(cnt < 0){
					var message = "<span>0명 이하는 입력할 수 없습니다.</span>";
					$(".room_reservation_people_message").addClass("text_red");
					if($(".room_reservation_people_message").hasClass("text_green")){
						$(".room_reservation_people_message").removeClass("text_green");
					}
					$(".room_reservation_people_message").html(message);	
					$(".room_reservation_people_message").show("slow");		
					
					$(".room_reservation_choose_date").show("slow");
					$(".room_reservation_price").hide("slow");
					$(".room_reservation_submit").hide("slow");
					$(".room_reservation_submit").attr("disabled", true);
				}else {
					var message = "<span>예약 가능합니다.</span>";
					$(".room_reservation_people_message").addClass("text_green");
					if($(".room_reservation_people_message").hasClass("text_red")){
						$(".room_reservation_people_message").removeClass("text_red");
					}
					$(".room_reservation_people_message").html(message);	
					$(".room_reservation_people_message").show("slow");
					
					// 총 금액 계산하기
					calcTotalPrice(cnt);
					// 버튼 바꾸기 
					$(".room_reservation_choose_date").hide();
					$(".room_reservation_price").show("slow");
					$(".room_reservation_submit").show("slow");
					$(".room_reservation_submit").attr("disabled", false);
					
				}
			}else {
				$(".room_reservation_people_message").hide("slow");
				
				$(".room_reservation_choose_date").show("slow");
				$(".room_reservation_price").hide("slow");
				$(".room_reservation_submit").hide("slow");
				$(".room_reservation_submit").attr("disabled", true);
			}
			
		});
		
		function calcTotalPrice(cnt){
			var per_price = $(".room_reservation_per_price").html();
			var nights = $(".room_reservation_days span").html();
			var total_price = per_price*nights*cnt;
			console.log("이 방 최종 가격 : "+total_price);
			$(".room_reservation_price_real").html("￦"+total_price);
			$("#b_total_price").val(total_price);
		}
		
		$(".room_reservation_submit").on("click",function(){
			var b_guest = $("#b_guest").val();
			var date_from = $("#startDate").val();
			var date_to = $("#endDate").val();
			var total_price = $("#b_total_price").val();
			
			if(date_from == null || date_from == ''){
				alert("숙박 시작 날짜를 입력해주세요!");
				$("#startDate").focus();
				return;
			}
			if(date_to == null || date_to == ''){
				alert("숙박 종료  날짜를 입력해주세요!");
				$("#endDate").focus();
				return;
			}
			if(b_guest == null || b_guest == ''){
				alert("숙박 인원을 입력해주세요!");
				$("#b_guest").focus();
				return;
			}
			if(total_price == null || total_price == ''){
				return;
			}
			
			$("#bookingForm").submit();
			
		});
		// 방 기본 정보 수정 number 제한
		$(".room_primary_facility_modify").on("keydown", "input[type=number]", function(e){
			if(e.keyCode == 69 
					|| e.keyCode == 190 
					|| e.keyCode == 109 
					|| e.keyCode == 110 
					|| e.keyCode == 107 
					|| e.keyCode == 189 
					|| e.keyCode == 187){
	            return false;              
	        } 
			
		});
		
		// 돈 입력 양식 제한
		$(".room_reservation_per_price_modify").keydown(function(e){
         if(e.keyCode == 69 || e.keyCode == 190 || e.keyCode == 109 || e.keyCode == 110 || e.keyCode == 107 || e.keyCode == 189 || e.keyCode == 187){
               return false;              
           }
       });
		
		// 예약 인원 숫자 제한
		$("#b_guest").on("keydown", function(e){
			if(e.keyCode == 69 
					|| e.keyCode == 190 
					|| e.keyCode == 109 
					|| e.keyCode == 110 
					|| e.keyCode == 107 
					|| e.keyCode == 189 
					|| e.keyCode == 187){
	            return false;              
	        } 
		});
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/pictureModal.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/messageModal.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/detailDate.js"></script>
</c:if>

<hr/>
<%@ include file="../common/footer.jsp" %>