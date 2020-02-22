/**
 * 
 */
$(function(){
	// 자기 소개 수정 창 감추기
	$(".show_my_introduce_mod").hide();
	
	//호스트 이미지 가져오기
	$.getJSON(contextPath+"/getMyImg/"+u_no, function(data){
		console.log(data);
		var fileInfo = getFileInfo(data[0]);
		var html = "<img src='"+fileInfo.imgSrc+"' alt='프로필 사진' class='FilledImg roundingProfileImg' />";
		$(".show_my_img").html(html);
	});
	 
});


//자기소개 편집 창 열기
$(".show_my_introduce_mod_open").on("click", function(){
	$(".show_my_introduce_mod").show('slow');
	$(".show_my_introduce").hide('slow');
	$(".show_my_introduce_mod_open").hide('slow');
});

//자기 소개 취소버튼
$(".show_my_introduce_mod_cancel").on("click",function(){
	$(".show_my_introduce_mod").hide('slow');
	$(".show_my_introduce").show('slow');
	$(".show_my_introduce_mod_open").show('slow');
});

//자기소개 편집 요청
$(".show_my_introduce_mod_submit").on("click",function(){
	var u_introduce = $(".show_my_introduce_mod textarea").val();
	
	$.post(contextPath+"/user/mod", {
		u_no: u_no,
		u_introduce: u_introduce
	}, function(data){
		console.log(data);
		location.reload();
	});
});
