package net.koreate.staybusan.room.service;

import java.util.Map;

public interface RoomDetailService {
	
	// 방 번호로 방 메인 정보 불러오기 
	Map<String, Object> readRoom(int r_no)throws Exception;

}
