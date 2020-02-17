/**
 * 
 */

$(function(){
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
$(".room_comments_list").on('input', ".answer_content", function(){
//	console.log($(this).val().length);
	if($(this).val().length>0){
//		content = $(this).val();
		content = $(this);
	}
	
	console.log(content);
});

// 대댓글 달기
$(".room_comments_list").on('click', ".btnReply", function(){
	var u_no = $(this).attr("data-uno");
	var u_name = $(this).attr("data-name");
	var c_origin = $(this).attr("data-origin");
	var c_dep = $(this).attr("data-dep");
	var c_seq = $(this).attr("data-seq");
	
//	var c_content = $(this).closest(".answer_content").val();
	
//	var contentt = $(this).closest("textarea");
	
	
	console.log(u_no);
	console.log(u_name);
	console.log(c_origin);
	console.log(c_dep);
	console.log(c_seq);
	
//	console.log(contentt);
//	console.log(content);
//	console.log(c_content);
	
//	$('#answer'+c_origin).collapse('hide');
	
});

$(".btnReview").on("click",function(){
	var r_no = $(this).attr("data-r_no");
	var commentListPage = 1;
	getCommentList(commentListPage);
//	console.log(r_no);
	function getCommentList(page){
		
		$.getJSON(contextPath+"/comments/"+r_no+"/"+page, function(data){
			// data == Map<String, Object>
			// data.commentList = list<CommentVO>
			// data.pageMaker = PageMaker
			// data.star_avg = 평균 평점
//			console.log(Object.keys(data).length);
			if(Object.keys(data).length > 0 ){
				var str = "";
				$(data.commentList).each(function(){
					str += "<div>";
					str += "	<div>";
					str += this.u_name;
					str += "	</div>";
					str += "	<div class='room_comment_profile' >";
					str += getGuestImg(this.u_no);
					str += "	</div>";
					str += "	<div>";
					str += getDate(this.c_regdate);
					str += "	</div>";
					str += "	<div>";
					str += this.c_content;
					str += "	</div>";
					str += "</div>";
					str += "<div>";
					str += "	<div>";
					str += "		<input type='button' value='댓글 달기' class='btn btn-primary' ";
					str += "		data-toggle='collapse' data-target='#answer"+this.c_no+"' ";
					str += "		aria-expanded='false' aria-controls='answer"+this.c_no+"' ";
					str += "		/>";
					str += "	</div>";
					
					
					str += "	<div class='collapse' id='answer"+this.c_no+"'>";
					str += "		<br/>";
					str += "		<div class='well'>";
					str += "			<div class='answer_to'>";
					str += "				<span>"
					str += 						this.u_name;		
					str +="					</span>";
					str += "				<span> 에게</span>";
					str += "			</div>";
					
					str += "			<div class='answer_content'>";
					str += "				<textarea name='c_content' class='answer_content' ></textarea>";
					str += "			</div>";
					
					str += "			<div>";
					str += "				<input type='button' value='등록' class='btnReply' data-uno='"+login+"' " +
							"				data-origin='"+this.c_origin+"' data-dep='"+this.c_dep+"' " +
									"				data-seq='"+this.c_seq+"' data-name='"+this.u_name+"' />";
					str += "			</div>";
					
					str += "		</div>";
					str += "	</div>";
					
					
					str += "</div>";
					str += "<hr/>";
					
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
//			console.log(data);
			
			var fileInfo = getFileInfo(data[0]);
			var html = "<img src='"+fileInfo.imgSrc+"' alt='게스트 사진' class='FilledImg' />";
			$(".room_comment_profile").html(html);
			
			
			
		});
	}

	function getDate(time){
		var dateObj = new Date(time);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth()+1;
		
		return year+"년 "+month+"월";
	}

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

	$(".room_comments_pagination").on("click", "li a", function(e){
		e.preventDefault();
		var commentPage = $(this).attr("href");
		getCommentList(commentPage);
	});

	function setCommentTotal(pm){
		
		$(".room_reservation_total").html("(후기 "+pm.totalCount+"개)")
		
		return $(".room_comments_total").html(pm.totalCount+" 후기");
	}

	function setStarAvg(avg){
		var str="";
		str += "★ ";
		str += avg.toFixed(2);
		$(".room_reservation_star").html(str);
		return $(".room_comments_star_avg").html(str);
	}
});