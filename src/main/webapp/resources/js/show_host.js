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

// content
var content='';
// content 정보 가져오기
$(".room_comments_list").on("input", ".answer_content", function(){
	content = $(this).val();
});

$(".room_comments_list").on("click",".collapsed",function(){
	$(".room_comments_list").find(".answer_content").val("");
});

// 대댓글 달기
$(".room_comments_list").on('click', ".btnReply", function(){
	var u_no = $(this).attr("data-uno");
	var r_no = $(this).attr("data-rno");
	var u_name = $(this).attr("data-name");
	var c_origin = $(this).attr("data-origin");
	var c_dep = $(this).attr("data-dep");
	var c_seq = $(this).attr("data-seq");
	var c_content = content;	
	
//	console.log(u_no);
//	console.log(r_no);
//	console.log(u_name);
//	console.log(c_origin);
//	console.log(c_dep);
//	console.log(c_seq);
//	console.log(c_content);
	
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
		$("#collapse"+c_origin).collapse('hide');
		getCommentList(1, r_no);
	});
	
});


// 후기 목록 띄우기
$(".btnReview").on("click",function(){
	var r_no = $(this).attr("data-r_no");
	var commentListPage = 1;
	getCommentList(commentListPage, r_no);
//	console.log(r_no);

});

function getCommentList(page, r_no){
	
	$.getJSON(contextPath+"/comments/"+r_no+"/"+page, function(data){
		// data == Map<String, Object>
		// data.commentList = list<CommentVO>
		// data.pageMaker = PageMaker
		// data.star_avg = 평균 평점
//		console.log(Object.keys(data).length);
		
		console.log(data.commentList);
		if(Object.keys(data).length > 0 ){
			var str = "";
			$(data.commentList).each(function(){
				
				str += "<div class='panel panel-default'>";
				str += "	<div class='panel-heading' role='tab' id='heading"+this.c_no+"'>";
				if(this.c_dep != 0){
					str += "<div><b>내가 쓴 대댓글</b></div>";
				}
				str += "		<h4 class='panel-title'>";
				str += this.u_name;
				str += "		</h4>";	
				str += "		<div class='room_comment_profile' >";
				str += getGuestImg(this.u_no);
				str += "		</div>";
				if(this.c_dep == 0){
					str += "	<div>";
					str += "★ "+this.c_star;
					str += "	</div>";
				}
				str += "		<div>";
				str += getDate(this.c_regdate);
				str += "		</div>";
				str += "		<div>";
				str += "			<span>";
				str += this.c_content;
				str += "			</span>";
				str += "		</div>";
				str += "		<a ";
				str += " data-toggle='collapse' data-parent='#accordion' href='#collapse"+this.c_no+"' ";
				str += " aria-expanded='true' aria-controls='collapse"+this.c_no+"' ";
				str += " >";
				str += "댓글"
				str += "		</a>";
				str += "	</div>";
				str += "	<div id='collapse"+this.c_no+"' class='panel-collapse collapse' ";
				str += " role='tabpanel' aria-labelledby='heading"+this.c_no+"' ";
				str += " >";
				str += "		<div class='panel-body'>";
				
				str += "			<div class='answer-to'>";
				str += "				<span>";
				str += this.u_name;
				str += "				</span>";
				str += "				<span>&nbsp;에게</span>";
				str += "			</div>";
				
				str += "			<div class='answer-content'>";
				str += "				<textarea name='c_content' class='answer_content'></textarea>";
				str += "			</div>";
				
				str += "			<div>";
				str += "				<input type='button' value='등록' class='btnReply' ";
				str += "				data-uno='"+login+"' data-origin='"+this.c_origin+"' ";
				str += "				data-dep='"+this.c_dep+"' data-seq='"+this.c_seq+"' ";
				str += "				data-name='"+this.u_name+"' data-rno='"+this.r_no+"' />";
				str += "			</div>";
				
				str += "		</div>";
				str += "	</div>";
				str += "</div>";
				
				
				
			});
			$(".room_comments_list").html(str);
			makePage(data.pageMaker);
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
function makePage(pm){
	var str="";
	str += "<ul>";
	if(pm.prev){
		str += "<li><a href='"+(pm.startPage-1)+"'>이전</a></li>";
	}
	for(var i=pm.startPage;i<=pm.endPage;i++){
		var strClass = pm.cri.page == i? 'class=active' :'';
		str += "<li "+strClass+" ><a href='"+i+"'>"+i+"</a></li>";
	}
	if(pm.next){
		str += "<li><a href='"+(pm.endPage+1)+"'>다음</a></li>";
	}
	str += "</ul>";
	$(".room_comments_pagination").html(str);
}
// 페이지 클릭 시
$(".room_comments_pagination").on("click", "li a", function(e){
	e.preventDefault();
	var commentPage = $(this).attr("href");
	getCommentList(commentPage);
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
// 자기소개 편집 창 열기
$(".show_my_introduce_mod_open").on("click", function(){
	$(".show_my_introduce_mod").show('slow');
	$(".show_my_introduce").hide('slow');
	$(".show_my_introduce_mod_open").hide('slow');
});

// 자기 소개 취소버튼
$(".show_my_introduce_mod_cancel").on("click",function(){
	$(".show_my_introduce_mod").hide('slow');
	$(".show_my_introduce").show('slow');
	$(".show_my_introduce_mod_open").show('slow');
});

// 자기소개 편집 요청
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
