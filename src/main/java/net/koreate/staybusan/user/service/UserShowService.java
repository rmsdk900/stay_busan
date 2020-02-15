package net.koreate.staybusan.user.service;

import java.util.Map;

public interface UserShowService {

	// 내 모든 정보를 가져오면 여기 넣기
	Map<String, Object> getMyInfo(int u_no)throws Exception;

}
