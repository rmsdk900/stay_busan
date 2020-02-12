/**
 * 
 */
// 최소 날짜
var minDate;

// 최대 날짜
var maxDate;

var endMinDate;

// 불가 날짜 보관 배열
var banDates = new Array();

// 불가 날짜 계산용 날짜
var banStartDate;
var banEndDate;

$("#startDate").datepicker({
    dateFormat : "yy-mm-dd",
    minDate : 0,
    todayHighlight : true,
    changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
    changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
      monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
      dayNames: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
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
      onSelect : function(dateText, inst){
         maxDate = new Date(dateText);
         $(".endDate").focus();
//         startDatepicker();
      }
 });
 
 // ====================공사중=========================
 // 데이트픽커(함수)
// function startDatepicker(){
//    $(".banStartDate").datepicker({
//       dateFormat : "yy-mm-dd",
//       minDate : minDate,
//       maxDate : maxDate,
//       todayHighlight : true,
//       changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
//       changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
//       monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         dayNames: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
//       onSelect : function(dateText, inst) {
//          endMinDate = new Date(dateText);
//          banStartDate = new Date(dateText);
//          endDatepicker();
//          $(".endDate").focus();
//       }
//    });
// }
//
// function endDatepicker(){
//    $(".banEndDate").datepicker({
//       dateFormat : "yy-mm-dd",
//       minDate : endMinDate,
//       maxDate : maxDate,
//       changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
//       changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
//       monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         dayNames: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
//         onSelect : function(dateText, inst){
//            banEndDate = new Date(dateText);
//            console.log(banEndDate);
//            banDateCalc(banStartDate, banEndDate);
//            $(".endDate").focus();
//         }
//    });
// };
// 
// 
// // 추가 데이트픽커
// function addStartDatepicker(){
//    $(".addBanStartDate").datepicker({
//       dateFormat : "yy-mm-dd",
//       minDate : minDate,
//       maxDate : maxDate,
//       todayHighlight : true,
//       changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
//       changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
//       monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         dayNames: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
//         beforeShowDay : disableAllTheseDays,
//       onSelect : function(dateText, inst) {
//          endMinDate = new Date(dateText);
//          banStartDate = new Date(dateText);
//          addEndDatepicker();
//          $(".endDate").focus();
//       }
//    });
// }
//
// function addEndDatepicker(){
//    $(".addBanEndDate").datepicker({
//       dateFormat : "yy-mm-dd",
//       minDate : endMinDate,
//       maxDate : maxDate,
//       changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
//       changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
//       monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//         dayNames: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
//         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
//         beforeShowDay : disableAllTheseDays,
//         onSelect : function(dateText, inst){
//            banEndDate = new Date(dateText);
//            console.log(banEndDate);
//            banDateCalc(banStartDate, banEndDate);
//            $(".endDate").focus();
//         }
//    });
// };
// 
// // 불가 기간 추가
// function disableAllTheseDays(date){
//    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
//    for(i=0; i<banDates.length; i++){
//       if($.inArray(y+ "-" + (m+1) + "-" + d, banDates) != -1){
//          return [false];
//       }
//    }
//    return [true];
// }
// 
// // 추가 버튼 클릭
// $("#banDateAdd").click(function(){
//    var html = "";
//    html += "<div>";
//    html += "<input type='text' class='addBanStartDate' readonly>-<input type'text' class='addBanEndDate' readonly/><input type='button' class='banCancel' value='x'/>"
//    html += "</div>";
//    $("#banDate").append(html);
//    addStartDatepicker();
// });
// 
// // x버튼 클릭
// $("#banDate").on("click",".banCancel",function(){
//    var target = $(this);
//    target.parent().remove();
// });
// 
// // 불가 기간 계산
// function banDateCalc(banStartDate, banEndDate){
//    
//    var calcDateNum = parseInt((banEndDate-banStartDate)/1000/3600/24);
//    
//    console.log(calcDateNum);
//    console.log(banStartDate.getDate());
//    
//    var yy = banStartDate.getFullYear();
//    var mm = banStartDate.getMonth();
//    var dd = banStartDate.getDate();
//    
//    console.log(yy+mm+dd);
//    
//    banDates.push(yy+"-"+(mm+1)+"-"+dd);
//    for(var i=0; i<calcDateNum; i++){
//       
//       
//       if(mm == 0 || mm == 2 || mm == 4 || mm == 6 || mm == 7 || mm == 9 || mm == 11){
//          if(dd>30){
//             dd = 1;
//             mm = mm+1;
//          }else{
//             dd = dd+1;
//          }
//       }else if(mm == 3 || mm == 5 || mm == 8 || mm == 10){
//          if(dd>29){
//             dd = 1;
//             mm = mm+1;
//          }else{
//             dd = dd+1;
//          }
//       }else{
//          if(yy%4 == 0){
//             if(dd>28){
//                dd = 1;
//                mm = mm+1;
//             }else{
//                dd = dd+1;
//             }
//          }else{
//             if(dd>27){
//                dd = 1;
//                mm = mm+1;
//             }else{
//                dd = dd+1;
//             }
//          }
//       }
//       
//       if(mm == 12){
//          yy = yy+1;
//          mm = 0;
//          dd = 1;
//       }
//       
//       console.log("yy : "+yy);
//       console.log("mm : "+mm);
//       console.log("dd : "+dd);
//       
//       var calcDate = (yy+"-"+(mm+1)+"-"+dd);
//       console.log(calcDate);
//       banDates.push(calcDate);
//    }
//    console.log(banDates);
// }

 
