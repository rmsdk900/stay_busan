package net.koreate.staybusan.room.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.staybusan.room.dao.RoomDateDAO;
import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.ClosedDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;
import net.koreate.staybusan.room.vo.RoomVO;
import net.koreate.staybusan.room.vo.RoomsDTO;
import net.koreate.staybusan.room.vo.TotalBookedDateDTO;

@Service
public class RoomDateServiceImpl implements RoomDateService{
	
	@Inject
	RoomDateDAO dao;
	
//	@Override
//	public List<RoomClosedVO> getBanDates(int r_no) throws Exception {
//		return dao.getBanDates(r_no);
//	}

	@Override
	public AvailableDateDTO getAvailableDate(int r_no) throws Exception {
		return dao.getAvailableDate(r_no);
	}
	// 밑은 공사중 
	@Transactional
	@Override
	public List<String> getTestDate(int r_no) throws Exception {		
		
		// 호스트가 설정한 금지 날짜 리스트
		List<String> banList = new ArrayList<>();
		List<ClosedDTO> closedDTOList= dao.getHostCloseDates(r_no);
//		System.out.println(closedDTOList);
		for(ClosedDTO dto : closedDTOList) {
			makeDateList(banList, dto.getClosed_from(), dto.getClosed_to());
		}
//		System.out.println(banList);
		
		
		// 예약 및 숙박 인원이 다 찬 날짜 리스트
		List<String> disabledList = new ArrayList<>();
		// 일단 예약된 날짜 리스트
		List<String> dummyDisabledList = new ArrayList<>();
		TotalBookedDateDTO totalBookedDateDTO = dao.getTotalBookedDates(r_no);
//		System.out.println(totalBookedDateDTO);
		makeDateList(dummyDisabledList, totalBookedDateDTO.getMin_date_from(), totalBookedDateDTO.getMax_date_to());
//		System.out.println(dummyDisabledList);
		for (String date : dummyDisabledList) {
//			System.out.println(date);
			RoomVO isFull = dao.isFullDate(r_no, date);
//			System.out.println(isFull);
			if(isFull != null) {
				disabledList.add(date);
			}
		}
//		System.out.println(disabledList);
		
		// 최종 리스트
		return makeFinalBanList(banList, disabledList);
	}
	
	private List<String> makeFinalBanList(List<String> banList, List<String> disabledList) {
		List<String> list = new ArrayList<>();
		
		for (String s : banList) {
			if(list.contains(s)==false) {
				list.add(s);
			}
		}
		
		for (String s : disabledList) {
			if(list.contains(s)==false) {
				list.add(s);
			}
		}
		
		return list;
	}

	// 달력 리스트 만드는 아주 유용한 놈.
	private void makeDateList(List<String> list, Date date_from, Date date_to) {
		
		final String DATE_PATTERN = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		
		Date currentDate = date_from;
		while(currentDate.compareTo(date_to)<=0){
			list.add(sdf.format(currentDate));
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		
	}
	
	
	
	
}
