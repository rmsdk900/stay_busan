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
		
		minDate = new Date(data.availableDate.r_date_from) > new Date() ? new Date(data.availableDate.r_date_from) : new Date();
		maxDate = new Date(data.availableDate.r_date_to);
		
		banDates = data.closedDate;

		$("#startDate").datepicker({
		    dateFormat : "yy-mm-dd",
		    minDate : minDate,
		    maxDate : maxDate,
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
		    maxDate : maxDate,
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
		         
		         // 여기서 전체 인원과 숙박 가능 인원을 띄워주자. 
		         $.ajax({
		        	type: "post",
		        	url: contextPath+"/book/checkPeople",
		        	headers:{
		        		"Content-Type": "application/json",
		        		"X-HTTP-Method-Override": "POST"
		        	},
		        	data: JSON.stringify({
		        		r_no: r_no,
		        		b_date_from: minDate,
						b_date_to: maxDate
		        	}),
		        	dataType: "json",
		        	success: function(data){
//						console.log(data);
		        		var html = data;	
		        		
		        		$(".room_reservation_how_many_people").html(html);
						
					},
					error: function(res){
						console.log(res.responseText);
					}
		         });
		         
		         $(".endDate").focus();
		         
		      }
		 });
		 
		// 불가 기간 추가
		 function disableAllTheseDays(date){
		    var m = plusZero(date.getMonth()+1), d = date.getDate(), y = date.getFullYear();
		    for(i=0; i<banDates.length; i++){
		       if($.inArray(y+ "-" + m + "-" + d, banDates) != -1){
		          return [false];
		       }
		    }
		    return [true];
		 }
		//10월 아래는 0을 붙여주자.
		 function plusZero(month){
			 return month < 10 ? "0"+month : month;
		 }
		
	});
	
});

// 숙박 일자 표시
function showNights(start, end){
	var nights = 0;
	
	var startDay = start.getDate();
	var endDay = end.getDate();
	
	nights = endDay - startDay;
	
	$(".room_reservation_days").html("/ <span>"+nights+"</span> 박");
	$("#b_guest").focus();

	
}




$(".room_reservation_choose_date").on("click", function(){
	$("#startDate").datepicker('show');
});
