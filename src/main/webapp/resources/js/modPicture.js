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
			div += "<a type='button' class='btn btn-warning btn-circle delBtn' href='"+fileInfo.fullName+"'>";
			div += "<i class='fa fa-times'>X</i>";
			div += "</a><br/>";
			div += "</div>";
			$(".pictures_preview").append(div);
		}
	});
});

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 20971520;

// 파일 삭제용 리스트
var delArr = new Array();

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
	
	files = e.originalEvent.dataTransfer.files;
	
	var formData = new FormData();
	
	for (var i=0;i<files.length;i++){
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		formData.append("file", files[i]);
		// 파일 형성? 
	}
	// 파일 upload 폴더에 올리는 것부터!
	$.ajax({
		type: "POST",
		data: formData,
		url : contextPath+"/uploadFile/"+u_no+"/"+r_no,
		dataType : "json",
		processData : false,
		contentType : false,
		success : function(data){
			console.log(data.length);
			for(var i =0; i< data.length; i++){
				var fileInfo = getFileInfo(data[i]);
				
				var div = "<div class='mod_imgs' >";
				div += "<a href='"+fileInfo.imgSrc+"' target='_blank'>"
				div += "<img src='"+fileInfo.imgSrc+"' alt='"+(i+1)+"번째 사진' />";
				div += "</a>";
				div += "<a type='button' class='btn btn-warning btn-circle delBtn' href='"+fileInfo.fullName+"'>";
				div += "<i class='fa fa-times'>X</i>";
				div += "</a><br/>";
				div += "</div>";
				$(".pictures_preview").append(div);
			}
		},
		error : function(res){
			alert(res.responseText);
		}
	});
});




$(".pictures_preview").on("click", ".delBtn", function(e){
	e.preventDefault();
	var fileLink = $(this).attr("href");
	delArr.push(fileLink);
	$(this).closest("div").remove();
});

$("#updateImgBtn").on("click", function(){
	var str = "";
	
	var fileList = $(".pictures_preview .delBtn");
	
	$(fileList).each(function(index){
		str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"' />";
	});
	$("#modifyForm").append(str);
	
	$.post(contextPath+"/deleteAllFiles", {files:delArr}, function(data){
		console.log(data);
	});
	
	$("#modifyForm").submit();
});
