package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import net.koreate.staybusan.room.vo.AmenityVO;
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
	@Select("SELECT * FROM user WHERE (u_type=1 OR u_type=3) AND u_no=(SELECT u_no FROM rooms WHERE r_no=#{r_no})")
	UserVO getRoomOwner(int r_no)throws Exception;
}
