package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface RoomImgDAO {
	// 첨부파일 등록
	@Insert("INSERT INTO room_img(r_no, u_no, r_i_fullName) VALUES(#{r_no}, #{u_no}, #{fullName})")
	void insertFileName(@Param("fullName") String fullName, @Param("u_no") int u_no, @Param("r_no") int r_no) throws Exception;
	
	// 첨부파일 목록 가져오기 
	@Select("SELECT r_i_fullName FROM room_img WHERE r_no=#{r_no} ORDER BY r_i_no ASC")
	List<String> getImgs(int r_no) throws Exception;

}
