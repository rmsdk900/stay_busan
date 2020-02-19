package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.staybusan.room.vo.AmenityVO;
import net.koreate.staybusan.room.vo.BuyVO;
import net.koreate.staybusan.room.vo.ModifyRoomPrimaryDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;
import net.koreate.staybusan.room.vo.RoomImgVO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.user.vo.UserVO;

public interface RoomDetailDAO {
	
	// 방 번호로 해당 방 정보 불러오기!
	@Select("SELECT * FROM rooms WHERE r_no=#{r_no}")
	RoomVO readRoomVO(int r_no) throws Exception;
	
	// 사진 리스트 불러오기 
	@Select("SELECT * FROM room_img WHERE r_no=#{r_no}")
	List<RoomImgVO> getImgList(int r_no) throws Exception;
	
	// 전체 예약 가능 기간 중 불가 기간 날짜 불러오기
	@Select("SELECT * FROM room_closed WHERE r_no=#{r_no}")
	List<RoomClosedVO> getClosedDay(int r_no) throws Exception;
	
	// 편의 시설 정보들 불러오기
	@Select("SELECT * FROM amenity WHERE r_no=#{r_no}")
	AmenityVO getAmenities(int r_no) throws Exception;
	
	// 호스트 정보 불러오기
	@Select("SELECT * FROM user WHERE u_type!=0 AND u_no=(SELECT u_no FROM rooms WHERE r_no=#{r_no})")
	UserVO getRoomOwner(int r_no)throws Exception;
	
	// 예약하기
	@Insert("INSERT INTO buy (r_no, u_no, b_date_from, b_date_to, b_guest, b_total_price, b_status) "
			+ " VALUES(#{r_no}, #{u_no}, #{b_date_from}, #{b_date_to}, #{b_guest}, #{b_total_price}, 1)")
	boolean bookingRoom(BuyVO vo)throws Exception;
	
	// 방 기본 정보 수정
	@Update("UPDATE rooms SET r_name=#{r_name}, r_guests=#{r_guests}, r_bedroom=#{r_bedroom}, r_bed=#{r_bed}, r_bath=#{r_bath}, r_desc=#{r_desc}, r_price=#{r_price} WHERE r_no=#{r_no}")
	void modifyRoomPrimary(ModifyRoomPrimaryDTO dto)throws Exception;
	
	// 숙박 될 때까지 거래 금액 예치하기.
	
	
}
