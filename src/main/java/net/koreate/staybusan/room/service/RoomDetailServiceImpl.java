package net.koreate.staybusan.room.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.staybusan.room.dao.RoomDetailDAO;
import net.koreate.staybusan.room.dao.RoomImgDAO;
import net.koreate.staybusan.room.vo.AmenityVO;
import net.koreate.staybusan.room.vo.BuyVO;
import net.koreate.staybusan.room.vo.ModifyRoomImgDTO;
import net.koreate.staybusan.room.vo.ModifyRoomPrimaryDTO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.user.vo.UserVO;



@Service
public class RoomDetailServiceImpl implements RoomDetailService{
	
	@Inject
	RoomDetailDAO rdd;
	
	@Inject
	RoomImgDAO rid;
	
	
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

	
	@Override
	public boolean bookingRoom(BuyVO vo) throws Exception {
		boolean isBooked = false;
		
		if(rdd.bookingRoom(vo)) {
			isBooked = true;
		}
		
		return isBooked;
	}

	@Transactional
	@Override
	public RoomVO modifyRoomPrimary(ModifyRoomPrimaryDTO dto) throws Exception {
		// 수정
		rdd.modifyRoomPrimary(dto);
		
		
		return rdd.readRoomVO(dto.getR_no());
	}

	@Transactional
	@Override
	public AmenityVO modifyRoomAmenities(AmenityVO vo) throws Exception {
		// 수정
		rdd.modifyRoomAmenities(vo);
		return rdd.getAmenities(vo.getR_no());
	}


	@Override
	public void modRoomImgs(ModifyRoomImgDTO dto) throws Exception {
		
		// 기본 첨부파일들 제거
		rdd.deleteAllImgs(dto.getR_no());
		
		List<String> fileList = dto.getFiles();
		if(fileList == null && fileList.isEmpty()) {
			return;
		}
		// 다시 파일 넣어주기 
		for(String fullName : fileList) {
			rid.insertFileName(fullName, dto.getU_no(), dto.getR_no());
		}
	}
	
	
	

	

	
	
}
