package net.koreate.staybusan.room.service;

import java.util.List;

import net.koreate.staybusan.room.vo.BuyVO;

public interface RoomReservationService {

	// 클라이언트가 적은 인원이 들어가도 가능한지.
	List<String> howMany(BuyVO vo)throws Exception;
	
	// 현재 숙박하고 있는 숫자 뽑아내자
	Integer checkPeople(BuyVO vo) throws Exception;

}
