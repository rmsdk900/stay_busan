package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
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

	@Update("UPDATE amenity SET a_wifi=#{a_wifi}, a_heating=#{a_heating}, a_TV=#{a_TV}, "
			+ " a_kitchen=#{a_kitchen}, a_hairdryer=#{a_hairdryer}, a_iron=#{a_iron}, "
			+ " a_hanger=#{a_hanger}, a_towel=#{a_towel}, a_elevator=#{a_elevator}, "
			+ " a_parking=#{a_parking}, a_washer=#{a_washer}, a_cookware=#{a_cookware}, "
			+ " a_refri=#{a_refri}, a_burner=#{a_burner}, a_dish=#{a_dish}, "
			+ " a_micro=#{a_micro}, a_aircon=#{a_aircon} WHERE r_no=#{r_no}")
	void modifyRoomAmenities(AmenityVO vo)throws Exception;
	// 모든 이미지 삭제
	@Delete("DELETE FROM room_img WHERE r_no=#{r_no}")
	void deleteAllImgs(int r_no)throws Exception;
	
	// 가장 최근의 구매 번호 가져오기
	@Select("SELECT LAST_INSERT_ID()")
	Integer getLastB_no()throws Exception;
	// 예치하기
	@Insert("INSERT INTO money (b_no, m_u_g_no, m_u_h_no, m_price) VALUES(#{b_no}, #{u_no}, #{host}, #{b_total_price})")
	void deposit(@Param("b_no") Integer b_no,@Param("u_no") int u_no,@Param("host") Integer host, @Param("b_total_price") int b_total_price)throws Exception;
	
	
	// 2020 02 22
	
	// 게스트한테서 돈이 빠져나가야 함. 
	@Update("UPDATE user SET u_balance=u_balance-#{b_total_price} WHERE u_no=#{u_no}")
	void pay(int u_no, int b_total_price)throws Exception;
	
	// 방 임시 삭제
	@Update("UPDATE rooms SET r_deleted=1 WHERE r_no=#{r_no}")
	void hideRoom(int r_no) throws Exception;
	
	
	
	
	
	
	
}
