package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;

public interface RoomDateDAO {
	
	
	@Select("SELECT * FROM room_closed WHERE r_no=#{r_no}")
	List<RoomClosedVO> getBanDates(int r_no)throws Exception;
	
	@Select("SELECT r_no, r_date_from, r_date_to FROM rooms WHERE r_no=#{r_no}")
	AvailableDateDTO getAvailableDate(int r_no)throws Exception;

}
