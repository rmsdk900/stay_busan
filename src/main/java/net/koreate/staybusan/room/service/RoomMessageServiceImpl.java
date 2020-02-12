package net.koreate.staybusan.room.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.staybusan.room.dao.RoomMessageDAO;
import net.koreate.staybusan.room.vo.MessageVO;

@Service
public class RoomMessageServiceImpl implements RoomMessageService{
	
	@Inject
	RoomMessageDAO dao;
	
	@Override
	public void sendMessage(MessageVO vo) throws Exception {
		
		dao.sendMessage(vo);
		
	}
	
	
	
}
