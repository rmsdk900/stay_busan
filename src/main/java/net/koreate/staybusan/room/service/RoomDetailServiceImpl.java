package net.koreate.staybusan.room.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.staybusan.room.dao.RoomDetailDAO;
import net.koreate.staybusan.room.vo.AmenityVO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.user.vo.UserVO;



@Service
public class RoomDetailServiceImpl implements RoomDetailService{
	
	@Inject
	RoomDetailDAO rdd;
	
	
	@Override
	public Map<String, Object> readRoom(int r_no) throws Exception {
		Map<String, Object> roomInfo = null;
		
		RoomVO roomVO = rdd.readRoomVO(r_no);
		AmenityVO amenityVO = rdd.getAmenities(r_no);
		UserVO hostVO = rdd.getRoomOwner(r_no);
		
		if(roomVO != null && amenityVO != null &&  hostVO != null) {
			roomInfo = new HashMap<>();
			roomInfo.put("roomVO", roomVO);
			roomInfo.put("amenityVO", amenityVO);
			roomInfo.put("hostVO", hostVO);
		}
		
		return roomInfo;
	}

	

	
	
}