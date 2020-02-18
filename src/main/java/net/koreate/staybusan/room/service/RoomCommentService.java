package net.koreate.staybusan.room.service;

import java.util.Map;

import net.koreate.staybusan.room.vo.CommentVO;

public interface RoomCommentService {

	
	Map<String, Object> getCommentList(int r_no, int page)throws Exception;

	String addReply(CommentVO vo)throws Exception;

}
