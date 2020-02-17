package net.koreate.staybusan.room.service;

import java.util.List;

public interface RoomImgService {

	
	
	// 파일 이름들 db에 등록
	void regImg(List<String> list, int u_no, int r_no) throws Exception;

	// 파일 목록 불러오기
	List<String> getImgs(int r_no) throws Exception;

	// 호스트 사진 불러오기
	List<String> getHostImg(int r_no)throws Exception;

	// 게스트 사진 불러오기
	List<String> getGuestImg(int u_no) throws Exception;

	

}
