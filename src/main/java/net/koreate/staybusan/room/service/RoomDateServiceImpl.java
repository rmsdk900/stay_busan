package net.koreate.staybusan.room.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.staybusan.room.dao.RoomDateDAO;
import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;

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
	
	
	
}
