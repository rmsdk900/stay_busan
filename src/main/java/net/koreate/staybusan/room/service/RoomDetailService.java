package net.koreate.staybusan.room.service;

import java.util.Map;

import net.koreate.staybusan.room.vo.BuyVO;

public interface RoomDetailService {
	
	// 방 번호로 방 메인 정보 불러오기 
	Map<String, Object> readRoom(int r_no)throws Exception;
	
	// 방 예약하기 
	boolean bookingRoom(BuyVO vo)throws Exception;

}
