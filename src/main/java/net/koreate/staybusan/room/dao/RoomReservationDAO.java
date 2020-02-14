package net.koreate.staybusan.room.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import net.koreate.staybusan.room.vo.RoomVO;

public interface RoomReservationDAO {

	@Select("SELECT * FROM rooms WHERE r_no=#{r_no} AND r_guests <1 " + 
			"(SELECT sum(b_guest)+#{b_guest} as sum_guests FROM buy WHERE r_no=#{r_no} AND b_status=1 AND b_date_from<=#{date} AND b_date_to>=#{date})")
	RoomVO canBook(@Param("r_no") int r_no,@Param("b_guest") int b_guest,@Param("date") String date)throws Exception;

	@Select("SELECT sum(b_guest) FROM buy WHERE r_no=#{r_no} AND b_status=1 AND b_date_from<=#{date} AND b_date_to>=#{date} ")
	Integer checkPeople(@Param("r_no") int r_no,@Param("date") String date)throws Exception;	
}
