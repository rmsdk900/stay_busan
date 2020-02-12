/**
 * 
 */
$(".room_more_imgs button").on("click", function(){
	console.log("사진 더 보기!")
	// 초기화
	$(".carousel-indicators").html("");
	$(".carousel-inner").html("");
	// 생성
	$.getJSON(contextPath+"/getImgs/"+r_no, function(data){
		// 첨부파일 목록 = data
		console.log(data);
		
		for(var i=0;i<data.length;i++){
			var fileInfo = getFileInfo(data[i]);
			console.log(fileInfo);
			
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
});


