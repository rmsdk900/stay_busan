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
			<div class="room_more_imgs">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#roomPicturesModal">
					사진 보기
				</button>
			</div>
			<%@ include file="./pictureModal.jsp" %>
		</div>
		<hr/>
		<div class="room_wrapper">
			<div class="room_primary">
				<div>
					<h2>${roomInfo.roomVO.r_name}</h2>
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
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#messageModal" data-whatever="${roomInfo.hostVO.u_name}">
						호스트에게 쪽지 보내기
					</button>
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
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/pictureModal.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/messageModal.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/detailDate.js"></script>
</c:if>

<hr/>
<%@ include file="../common/footer.jsp" %>