<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
      </div>
      <div class="modal-body">
        <form action="" method="post">
          <div class="form-group">
            <label for="recipient-name" class="control-label">Recipient:</label>
            <input type="text" class="form-control" id="recipient-name" readonly>
          </div>
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text" name="m_content"></textarea>
          </div>
          <input type="hidden" name="r_no" id="message_r_no" value="${roomInfo.roomVO.r_no}" />
          <input type="hidden" name="m_receiver" id="m_receiver" value="${roomInfo.hostVO.u_no}" />
          <!-- 여긴 일단 임시로 들어온 사람이 호스트 번호랑 같게 강제로 잡아두자 -->
          <input type="hidden" name="m_sender" id="m_sender" value="${roomInfo.hostVO.u_no}" />
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btnSendMsg">Send message</button>
      </div>
    </div>
  </div>
</div>
