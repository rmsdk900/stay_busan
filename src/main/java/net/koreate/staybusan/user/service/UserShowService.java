package net.koreate.staybusan.user.service;

import java.util.Map;

import net.koreate.staybusan.user.vo.ModIntroDTO;
import net.koreate.staybusan.user.vo.UserVO;

public interface UserShowService {

	// 내 모든 정보를 가져오면 여기 넣기
	Map<String, Object> getMyInfo(int u_no)throws Exception;
	
	// 유저 자기소개 바꾸기
	UserVO modIntro(ModIntroDTO dto) throws Exception;

}
