/**
 * 
 */
$(function(){
	$.getJSON(contextPath+"/getMyImg/"+u_no, function(data){
		console.log(data);
	})
});
