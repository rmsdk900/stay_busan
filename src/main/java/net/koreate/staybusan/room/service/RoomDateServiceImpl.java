package net.koreate.staybusan.room.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.staybusan.room.dao.RoomDateDAO;
import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.ClosedDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;
import net.koreate.staybusan.room.vo.RoomsDTO;

@Service
public class RoomDateServiceImpl implements RoomDateService{
	
	@Inject
	RoomDateDAO dao;
	
	@Override
	public List<RoomClosedVO> getBanDates(int r_no) throws Exception {
		return dao.getBanDates(r_no);
	}

	@Override
	public AvailableDateDTO getAvailableDate(int r_no) throws Exception {
		return dao.getAvailableDate(r_no);
	}
	// 밑은 공사중 
	@Transactional
	@Override
	public List<String> getTestDate(int r_no) throws Exception {
		// 호스트가 설정한 전체 날짜 리스트
		List<String> firstList = new ArrayList<>();
		
		RoomsDTO firstDTO = dao.getHostDates(r_no);
		System.out.println(firstDTO);
		
		
		
		// 호스트가 설정한 금지 날짜 리스트
		List<String> banList = new ArrayList<>();
		List<ClosedDTO> closedDTOList= dao.getHostCloseDates(r_no);
		System.out.println(closedDTOList);
		
		
		// 예약 및 숙박 인원이 다 찬 날짜 리스트
		List<String> disabledList = new ArrayList<>();
		
		// 최종 리스트
		List<String> availableList = new ArrayList<>();
		
		
		return availableList;
	}
	
	
	
	
}
