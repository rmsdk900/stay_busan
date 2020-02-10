/**
 * 
 */

var commentListPage = 1;

getCommentList(commentListPage);

function getCommentList(page){
	
	$.getJSON(contextPath+"/comments/"+r_no+"/"+page, function(data){
		// data == Map<String, Object>
		// data.commentList = list<CommentVO>
		// data.pageMaker = PageMaker
		// data.star_avg = 평균 평점
		
		var str = "";
		$(data.commentList).each(function(){
			str += "<div>";
			str += "	<div>";
			str += "[프로필 사진]";
			str += "	</div>";
			str += "	<div>";
			str += this.u_name;
			str += "	</div>";
			str += "	<div>";
			str += getDate(this.c_regdate);
			str += "	</div>";
			str += "	<div>";
			str += this.c_content;
			str += "	</div>";
			str += "</div>";
			str += "<hr/>";
		});
		$(".room_comments_list").html(str);
		makePage(data.pageMaker);
		setCommentTotal(data.pageMaker);
		setStarAvg(data.star_avg);
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
	return $(".room_comments_total").html(pm.totalCount+" 후기");
}

function setStarAvg(avg){
	var str="";
	str += "★ ";
	str += avg;
	return $(".room_comments_star_avg").html(str);
}