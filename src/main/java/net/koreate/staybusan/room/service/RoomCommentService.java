package net.koreate.staybusan.room.service;

import java.util.Map;

public interface RoomCommentService {

	
	Map<String, Object> getCommentList(int r_no, int page)throws Exception;

}
