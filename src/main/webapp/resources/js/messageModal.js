/**
 * 
 */

$('#messageModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('whatever') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
  modal.find('.modal-body #recipient-name').val(recipient)
});

$('#messageModal #btnSendMsg').on("click", function(){
	var m_receiver = $("#m_receiver").val();
	var m_sender = $("#m_sender").val();
	var r_no = $("#message_r_no").val();
	var m_content = $("#message-text").val();
	
	if(m_content == null || m_content == ''){
		alert("내용을 입력해주세요!");
		$("#message-text").focus();
		return;
	}
	
	$.ajax({
		type: "post",
		url: contextPath+"/messages/send",
		headers: {
			"Content-Type": "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		data: JSON.stringify({
			r_no: r_no,
			m_receiver: m_receiver,
			m_sender: m_sender,
			m_content: m_content
		}),
		dataType: "text",
		success: function(data){
			alert(data);
			$('#messageModal').modal('hide');
		}
	});
	
	
});