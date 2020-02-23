/**
 * 
 */

var commentListPage = 1;

getCommentList(commentListPage, r_no);

function getCommentList(page, r_no){
	
	$.getJSON(contextPath+"/comments/"+r_no+"/"+page, function(data){
		// data == Map<String, Object>
		// data.commentList = list<CommentVO>
		// data.pageMaker = PageMaker
		// data.star_avg = 평균 평점
//		console.log(Object.keys(data).length);
		
		console.log(data);
		if(Object.keys(data).length > 0 ){
			var str = "";
			$(data.commentList).each(function(){
				// 댓글 칸
				str += "<div class='room_comment_wrap"+this.c_no+"'>";
				if (this.c_dep != 0){
					str += "	<div><b>내가 쓴 대댓글</b></div>";
				}
				str += "	<h4 class='room_comment_owner'>"+this.u_name+"</h4>";
				str += "	<div class='room_comment_profile' >";
				str += getGuestImg(this.u_no);
				str += "	</div>";
				if(this.c_dep == 0){
					str += "	<div>";
					str += "★ "+this.c_star;
					str += "	</div>";
				}
				str += "	<div>";
				str += getDate(this.c_regdate);
				str += "	</div>";
				str += "	<div>";
				str += "		<span id='room_comment_comment"+this.c_no+"'>";
				str += this.c_content;
				str += "		</span>";
				str += "	</div>";
				str += "	<div>";
				str += "		<button type='button' class='btnOpenReply' data-c_no='"+this.c_no+"'";
				str += " 		data-c_owner='"+this.u_name+"' ";
				str += " 		data-c_origin='"+this.c_origin+"' ";
				str += " 		data-c_dep='"+this.c_dep+"' ";
				str += " 		data-c_seq='"+this.c_seq+"' ";
				str += " 		data-r_no='"+this.r_no+"' ";
				str += "		>";
				str += "대댓글 쓰기";
				str += "		</button>";
				str += "		<button class='btnOpenReport'";
				str += "		data-c_no='"+this.c_no+"'";
				// 여기도 나중에 로그인한 사람 걸로 바꿔줘야 함.
				str += "		data-reporter='"+login+"'";
				str += "		data-bad_person='"+this.u_no+"'";
				str += "		>";
				str += "		댓글 신고</button>";
				
				// 이것도 로그인 부분의 유저 번호를 바꿔야 함. 
				if(this.u_no == login){
					str += "		<button";
					str += "		class='btnModComment'";
					str += "		data-c_no='"+this.c_no+"'";
					str += "		data-room='"+this.r_no+"'";
					str += ">";
					str += "수정";
					str += "		</button>";
					str += "		<button";
					str += "		class='btnDelComment'";
					str += "		data-c_no='"+this.c_no+"'";
					str += "		data-room='"+this.r_no+"'";
					str += ">";
					str += "삭제";
					str += "		</button>";
					
				}
				str += "	</div>";
				str += "	<div class='room_comment_reply_cover'>";
				str += "		<div id='room_comment_reply_wrap"+this.c_no+"'>";
				str += "		</div>";
				str += "	</div>";
				str += "	<div class='room_comment_mod_cover'>";
				str += "		<div id='room_comment_mod_wrap"+this.c_no+"'>";
				str += "		</div>";
				str += "	</div>";
				str += "</div>";
				
			});
			$(".room_comments_list").html(str);
			makePage(data.pageMaker, r_no);
			setCommentTotal(data.pageMaker);
			setStarAvg(data.star_avg);
		}else {
			var str = "<div>등록된 후기가 없습니다.</div>";
			$(".room_comments_list").html(str);
			$(".room_comments_star_avg").html("★ 0.0");
			$(".room_comments_total").html("0 후기")
		}
		
	}).fail(function(jqxhr, textStatus, error){
		var err = textStatus+", "+error;
		console.log("Request Failed: "+err);
	});
}
// 대댓글 작성 창 열기
$(".room_comments_list").on("click", ".btnOpenReply", function(){
	var c_no = $(this).attr("data-c_no");
	var c_owner = $(this).attr("data-c_owner");
	 
	// 보내는데 필요함. 변경해야 됨
	// 보내는 사람 번호 (임시)
	var login_no = 1;
	// 보내는 사람 이름 (임시) 
	var login_name = "Admin(send)";
	
	var c_origin = $(this).attr("data-c_origin");
	var c_dep = $(this).attr("data-c_dep");
	var c_seq = $(this).attr("data-c_seq");
	var r_no = $(this).attr("data-r_no");
	
	
	console.log(c_no);
	
	console.log(c_owner);
	// 대댓글 창 생성
	var html = "";
	
	html += "	<div class='answer_to'>";
	html += "		<span>"+c_owner+"</span><span>&nbsp;에게</span>";
	html += "	</div>";
	html += "	<div class='answer_content'>";
	html += "		<textarea id='c_content"+c_no+"' ></textarea>";
	html += "	</div>";
	html += "	<div>";
	html += "		<button type='button' class='btnReplySubmit'";
	// 이부분 나중에 로그인 한사람의 이름으로 변경해야 함!
	html += "		data-sender='"+login_no+"'";
	html += "		data-sender_name='"+login_name+"'";
	// 정상적인거
	html += "		data-room='"+r_no+"'";
	html += "		data-origin='"+c_origin+"'";
	html += "		data-dep='"+c_dep+"'";
	html += "		data-seq='"+c_seq+"'";
	// 원래 글의 번호
	html += "		data-no='"+c_no+"'";
	html += "		>대댓글 보내기";
	html += "		</button>";
	html += "		<button type='button' class='btnReplyClose' data-no='"+c_no+"'>닫기</button>";
	html += "	</div>";
	
	$("#room_comment_reply_wrap"+c_no).append(html);
	
});
// 대댓글 창 닫기
$(".room_comments_list").on("click", ".btnReplyClose", function(){
	var c_no = $(this).attr("data-no");
	$("#room_comment_reply_wrap"+c_no).html("");
});
// 대댓글 달기
$(".room_comments_list").on("click", ".btnReplySubmit", function(){
	
	var u_no = $(this).attr("data-sender");
	var r_no = $(this).attr("data-room");
	var u_name = $(this).attr("data-sender_name");
	var c_origin = $(this).attr("data-origin");
	var c_dep = $(this).attr("data-dep");
	var c_seq = $(this).attr("data-seq");
	
	// 댓글 보내려는 글의 번호 
	var no = $(this).attr("data-no");
	
	var c_content = $("#c_content"+no).val();	
	
	console.log(u_no);
	console.log(r_no);
	console.log(u_name);
	console.log(c_origin);
	console.log(c_dep);
	console.log(c_seq);
	console.log(c_content);
	
	$.post(contextPath+"/comments/reply", {
		u_no: u_no,
		r_no: r_no,
		u_name: u_name,
		c_origin: c_origin,
		c_dep: c_dep,
		c_seq: c_seq,
		c_content: c_content
	}, function(data){
		alert(data);
		getCommentList(1, r_no);
	});
	
});

// 댓글 수정 창 열기
$(".room_comments_list").on("click", ".btnModComment", function(){
	var c_no = $(this).attr("data-c_no");
	var r_no = $(this).attr("data-room");
	var c_comment = $("#room_comment_comment"+c_no).html();
	
	var html = "";
	html += "<div>";
	html += "<h3>댓글 수정</h3>";
	html += "</div>";
	html += "<div class='mod_comment'>";
	html += "	<textarea id='mod_content"+c_no+"' >"+c_comment+"</textarea>";
	html += "</div>";
	html += "<div>";
	html += "	<button type='button' class='btnModCommentSubmit'";
	html += "	data-c_no='"+c_no+"'";
	html += "	data-room='"+r_no+"'";
	html += ">";
	html += "	수정하기</button>";
	html += "	<button type='button' class='btnModCommentClose' data-c_no='"+c_no+"'>";
	html += "	닫기</button>";
	html += "</div>";
	
	$("#room_comment_mod_wrap"+c_no).html(html);
});

// 댓글 수정창 닫기
$(".room_comments_list").on("click", ".btnModCommentClose", function(){
	var c_no = $(this).attr("data-c_no");
	
	$("#room_comment_mod_wrap"+c_no).html("");
});
// 댓글 수정 요청
$(".room_comments_list").on("click", ".btnModCommentSubmit", function(){
	var c_no = $(this).attr("data-c_no");
	var r_no = $(this).attr("data-room");
	var mod_content = $("#mod_content"+c_no).val();
	
	console.log(mod_content);
	
	$.post(contextPath+"/comments/mod", {
		c_no : c_no,
		c_content : mod_content
	}, function(data){
		console.log(data);
		if(data != null && data != ''){
			getCommentList(1, r_no);
		}
	});
});

//댓글 삭제 - 바로 하자
$(".room_comments_list").on("click", ".btnDelComment", function(){
	var c_no = $(this).attr("data-c_no");
	var r_no = $(this).attr("data-room");
	
	$.post(contextPath+"/comments/del/"+c_no, {}, function(data){
		alert(data);
		getCommentList(1, r_no);
	});
});

// 신고모달 창 띄우기
$(".room_comments_list").on("click", ".btnOpenReport", function(){
	
	// 정보 기입
	var c_no = $(this).attr("data-c_no");
	var reporter = $(this).attr("data-reporter");
	var bad_person = $(this).attr("data-bad_person");
	var bad_content = $("#room_comment_comment"+c_no).html();
	// 집어 넣어놓기
	var str = "";
	str += "<input type='hidden' name='c_no' id='ban_no' value='"+c_no+"'/>";
	str += "<input type='hidden' name='b_c_reporter' id='ban_reporter' value='"+reporter+"'/>";
	str += "<input type='hidden' name='b_c_bad_person' id='ban_bad_person' value='"+bad_person+"'/>";
	str += "<input type='hidden' name='c_content' id='ban_content' value='"+bad_content+"'/>";
	$(".hiddenReport").html(str);
	$("#reportModal").show();
});
// 신고모달창 감추기
function closeModal(){
	$(".hiddenReport").html("");
	$(".reportModals").hide();
}
// 신고하기
function reportSubmit(){
	var b_c_reason = $(".report_content").val();
	if(b_c_reason != null && b_c_reason != ''){
		$.post(contextPath+"/comments/report", {
			c_no: $("#ban_no").val(),
			b_c_reporter: $("#ban_reporter").val(),
			b_c_bad_person: $("#ban_bad_person").val(),
			c_content: $("#ban_content").val(),
			b_c_reason: $(".report_content").val()
			
		}, function(data){
			console.log(data);
			alert("신고 완료!");
			location.reload();
		});
	}else {
		alert("신고 내용을 기입해주세요!");
		$(".report_content").focus();
		return;
	}
	
	
}



// --- 건들 부분 없음 ----
// 게스트 이미지 불러오기
function getGuestImg(u_no){
	$.getJSON(contextPath+"/getMyImg/"+u_no, function(data){
//		console.log(data);
		
		var fileInfo = getFileInfo(data[0]);
		var html = "<img src='"+fileInfo.imgSrc+"' alt='게스트 사진' class='FilledImg' />";
		$(".room_comment_profile").html(html);
		
	});
}
// 날짜 표시 형식 변경
function getDate(time){
	var dateObj = new Date(time);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth()+1;
	
	return year+"년 "+month+"월";
}
// 페이징 처리
function makePage(pm, r_no){
	var str="";
	str += "<ul>";
	if(pm.prev){
		str += "<li><a href='"+(pm.startPage-1)+"' data-r_no='"+r_no+"'>이전</a></li>";
	}
	for(var i=pm.startPage;i<=pm.endPage;i++){
		var strClass = pm.cri.page == i? 'class=active' :'';
		str += "<li "+strClass+" ><a href='"+i+"' data-r_no='"+r_no+"'>"+i+"</a></li>";
	}
	if(pm.next){
		str += "<li><a href='"+(pm.endPage+1)+"' data-r_no='"+r_no+"'>다음</a></li>";
	}
	str += "</ul>";
	$(".room_comments_pagination").html(str);
}
// 페이지 클릭 시
$(".room_comments_pagination").on("click", "li a", function(e){
	e.preventDefault();
	var r_no = $(this).attr("data-r_no");
	var commentPage = $(this).attr("href");
	getCommentList(commentPage, r_no);
});
// 후기 갯수 구하기
function setCommentTotal(pm){
	
	$(".room_reservation_total").html("(후기 "+pm.totalCount+"개)")
	
	return $(".room_comments_total").html(pm.totalCount+" 후기");
}
// 평균 별점 구하기
function setStarAvg(avg){
	var str="";
	str += "★ ";
	str += avg.toFixed(2);
	$(".room_reservation_star").html(str);
	return $(".room_comments_star_avg").html(str);
}