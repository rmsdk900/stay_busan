package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.ClosedDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.room.vo.RoomsDTO;
import net.koreate.staybusan.room.vo.TotalBookedDateDTO;

public interface RoomDateDAO {
	
	
	@Select("SELECT * FROM room_closed WHERE r_no=#{r_no}")
	List<RoomClosedVO> getBanDates(int r_no)throws Exception;
	
	@Select("SELECT r_no, r_date_from, r_date_to FROM rooms WHERE r_no=#{r_no}")
	AvailableDateDTO getAvailableDate(int r_no)throws Exception;

	@Select("SELECT r_no, r_date_from, r_date_to FROM rooms WHERE r_no=#{r_no}")
	RoomsDTO getHostDates(int r_no)throws Exception;
	
	@Select("SELECT r_no, closed_from, closed_to FROM room_closed WHERE r_no=#{r_no}")
	List<ClosedDTO> getHostCloseDates(int r_no)throws Exception;
	
	
	@Select("SELECT MIN(b_date_from) as min_date_from, MAX(b_date_to) as max_date_to FROM buy "
			+ " WHERE b_status=1 AND r_no=#{r_no}")
	TotalBookedDateDTO getTotalBookedDates(int r_no) throws Exception;
	
	@Select("SELECT * FROM rooms WHERE r_no=#{r_no} AND r_guests <= "+ 
			" (SELECT sum(b_guest) as sum_guests FROM buy WHERE r_no=#{r_no} AND b_status=1 AND b_date_from<=#{date} AND b_date_to>#{date})")
	RoomVO isFullDate(@Param("r_no") int r_no,@Param("date") String date);

	
	
	
	

}
