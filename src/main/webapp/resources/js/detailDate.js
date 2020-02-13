/**
 * 
 */
// 최소 날짜
var minDate;

// 최대 날짜
var maxDate;

// 불가 날짜 보관 배열
var banDates = new Array();

// 추가로 안되는 날짜 불러오기
$(function(){
	$.getJSON(contextPath+"/getAvailableDate/"+r_no, function(data){
		// data.closedDate : 금지 날짜
		// data.availableDate : 되는 날짜.
		console.log(data);
		
		minDate = new Date(data.availableDate.r_date_from);
		maxDate = new Date(data.availableDate.r_date_to);
		
		
		$(data.closedDate).each(function(){
			var banStartDate = new Date(this.closed_from);
			var banEndDate = new Date(this.closed_to);
			banDateCalc(banStartDate, banEndDate);
			console.log(banDates);
		});
		
		
		$("#startDate").datepicker({
		    dateFormat : "yy-mm-dd",
		    minDate : minDate,
		    todayHighlight : true,
		    changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		    changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		      monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		      dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		      dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		      beforeShowDay : disableAllTheseDays,
		    onSelect : function(dateText, inst) {
		       minDate = new Date(dateText);
		       $("#endDate").datepicker("option","minDate",minDate);
		       $(".endDate").focus();
		    }
		 });
		
		 $("#endDate").datepicker({
		    dateFormat : "yy-mm-dd",
		    changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		    changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		      monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		      dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		      dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		      beforeShowDay : disableAllTheseDays,
		      onSelect : function(dateText, inst){
		    	 
		         maxDate = new Date(dateText);
		         
		         console.log(minDate);
		         console.log(maxDate);
		         
		         showNights(minDate, maxDate);
		         
		         $(".endDate").focus();
		         
		      }
		 });
		 
		// 불가 기간 추가
		 function disableAllTheseDays(date){
		    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
		    for(i=0; i<banDates.length; i++){
		       if($.inArray(y+ "-" + (m+1) + "-" + d, banDates) != -1){
		          return [false];
		       }
		    }
		    return [true];
		 }
		
	})
	
});

// 숙박 일자 표시
function showNights(start, end){
	var nights = 0;
	
	var startDay = start.getDate();
	var endDay = end.getDate();
	
	nights = endDay - startDay;
	
	$(".room_reservation_days").html("/ "+nights+" 박");
	$(".room_reservation_choose_date").hide();
	calcTotalPrice(nights);
	$(".room_reservation_price").show();
	$(".room_reservation_submit").show();
	
	
}
// 최종 가격 계산
function calcTotalPrice(nights){
	var per_price = $(".room_reservation_per_price").html();
	console.log("이 방 하루 당 가격 : "+per_price);
	var total_price = per_price * nights;
	console.log("이 방 최종 가격 : "+total_price);
	$(".room_reservation_price_real").html("￦"+total_price);
}


//불가 기간 계산
function banDateCalc(banStartDate, banEndDate){
 
 var calcDateNum = Math.ceil((banEndDate-banStartDate)/1000/3600/24);
 
// console.log("금지 일 수 : "+calcDateNum);
// console.log(banStartDate.getDate());
 
 var yy = banStartDate.getFullYear();
 var mm = banStartDate.getMonth();
 var dd = banStartDate.getDate();
 
 
 
 banDates.push(yy+"-"+(mm+1)+"-"+dd);
 for(var i=0; i<calcDateNum; i++){
    
    
    if(mm == 0 || mm == 2 || mm == 4 || mm == 6 || mm == 7 || mm == 9 || mm == 11){
       if(dd>30){
          dd = 1;
          mm = mm+1;
       }else{
          dd = dd+1;
       }
    }else if(mm == 3 || mm == 5 || mm == 8 || mm == 10){
       if(dd>29){
          dd = 1;
          mm = mm+1;
       }else{
          dd = dd+1;
       }
    }else{
       if(yy%4 == 0){
          if(dd>28){
             dd = 1;
             mm = mm+1;
          }else{
             dd = dd+1;
          }
       }else{
          if(dd>27){
             dd = 1;
             mm = mm+1;
          }else{
             dd = dd+1;
          }
       }
    }
    
    if(mm == 12){
       yy = yy+1;
       mm = 0;
       dd = 1;
    }
    
//    console.log("yy : "+yy);
//    console.log("mm : "+mm);
//    console.log("dd : "+dd);
    
    var calcDate = (yy+"-"+(mm+1)+"-"+dd);
//    console.log(calcDate);
    banDates.push(calcDate);
 }
 
}

$(".room_reservation_choose_date").on("click", function(){
	$("#startDate").datepicker('show');
});


 
 
 
 
 
 
