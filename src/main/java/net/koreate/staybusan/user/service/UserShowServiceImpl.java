package net.koreate.staybusan.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.staybusan.room.dao.RoomImgDAO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.user.dao.UserShowDAO;
import net.koreate.staybusan.user.vo.ModIntroDTO;
import net.koreate.staybusan.user.vo.UserVO;

@Service
public class UserShowServiceImpl implements UserShowService{
	
	@Inject
	UserShowDAO usd;
	
	@Inject
	RoomImgDAO rid;

	@Override
	public Map<String, Object> getMyInfo(int u_no) throws Exception {
		Map<String, Object> myInfo = new HashMap<>();
		
		// 유저 정보
		UserVO userVO = usd.getUser(u_no);
		// 방 기본 정보
		List<RoomVO> roomList= usd.getHostingRooms(u_no);
		for(RoomVO vo : roomList) {
			int r_no = vo.getR_no();
			System.out.println(r_no+"번 방의 나머지 내용 추가");
			
			// 숙소 이미지
			List<String> imgList = rid.getImgs(r_no);
			if(imgList != null) {
				System.out.println("이미지 리스트 비지 않았다!");
				vo.setImgList(imgList);
			}
		}
		
		if(userVO != null) {
			myInfo.put("userVO", userVO);
		}
		if(roomList != null) {
			myInfo.put("hosting", roomList);
		}
		
		return myInfo;
	}

	@Override
	public UserVO modIntro(ModIntroDTO dto) throws Exception {
		// 수정
		usd.modIntro(dto);
		
		return usd.getUser(dto.getU_no());
	}
	
	
	
}
