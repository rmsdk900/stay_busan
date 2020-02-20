/**
 * 
 */
$("#modPictureBtn").on("click", function(){
	console.log("사진 변경");
	$.getJSON(contextPath+"/getImgs/"+r_no, function(data){
		// 첨부파일 목록 = data
		console.log(data);
		
		for(var i=0;i<data.length;i++){
			// 이미지들 뿌리기
			var fileInfo = getFileInfo(data[i]);
			
			var div = "<div class='mod_imgs' >";
			div += "<a href='"+fileInfo.imgSrc+"' target='_blank'>"
			div += "<img src='"+fileInfo.imgSrc+"' alt='"+(i+1)+"번째 사진' />";
			div += "</a>";
			div += "<button type='button' class='btn btn-warning btn-circle' >";
			div += "<i class='fa fa-times'>X</i>";
			div += "</button><br/>";
			div += "</div>";
			$(".pictures_preview").append(div);
		}
	});
});

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 20971520;

function checkExtension(fileName, fileSize){
	if(fileSize >= maxSize){
		alert('파일 사이즈 초과');
		return false;
	}
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}


$(".pictures_add").on("dragenter dragover", function(e){
	e.preventDefault();
});

$(".pictures_add").on("drop", function(e){
	e.preventDefault();
	console.log("upload");
	
	files = event.originalEvent.dataTransfer.files;
	
	var formData = new FormData();
	
	for (var i=0;i<files.length;i++){
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		formData.append("uploadFile", files[i]);
		// 파일 형성? 
	}
});
$("#updateImgBtn").on("click", function(){
	$.ajax({
		url: "임시",
		processData: false,
		contentType: false,
		data: formData,
		type: 'POST',
		dataType: 'json',
		success: function(data){
			console.log(data);
			// 업로드 결과 처리 메소드 만들자.
			// 새로 고침?
			location.reload();
			
		}
	});
});
