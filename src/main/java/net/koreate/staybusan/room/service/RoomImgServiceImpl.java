package net.koreate.staybusan.room.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.staybusan.room.dao.RoomImgDAO;

@Service
public class RoomImgServiceImpl implements RoomImgService{
	
	@Inject
	RoomImgDAO dao;

	@Override
	public void regImg(List<String> list, int u_no, int r_no) throws Exception{
		for(String fullName : list) {
			dao.insertFileName(fullName, u_no, r_no);
		}
		
	}

	@Override
	public List<String> getImgs(int r_no) throws Exception {
		return dao.getImgs(r_no);
	}

	@Override
	public List<String> getHostImg(int r_no) throws Exception {
		return dao.getHostImg(r_no);
	}

	@Override
	public List<String> getGuestImg(int u_no) throws Exception {
		return dao.getGuestImg(u_no);
	}
	
	
	
	
	
	
	
	
	
	
	
}
