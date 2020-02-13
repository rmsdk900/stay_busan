package net.koreate.staybusan.room.service;

import java.util.List;

import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;

public interface RoomDateService {

	// 금지 날짜 가져오기
	List<RoomClosedVO> getBanDates(int r_no) throws Exception;
	// 되는 날짜 가져오기
	AvailableDateDTO getAvailableDate(int r_no) throws Exception;

}
