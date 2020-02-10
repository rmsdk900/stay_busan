package net.koreate.staybusan.room.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.mvc.common.util.Criteria;
import net.koreate.mvc.common.util.PageMaker;
import net.koreate.staybusan.room.dao.RoomCommentDAO;
import net.koreate.staybusan.room.vo.CommentVO;

@Service
public class RoomCommentServiceImpl implements RoomCommentService{
	
	@Inject
	RoomCommentDAO dao;

	@Override
	public Map<String, Object> getCommentList(int r_no, int page) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		cri.setPerPageNum(15);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.totalCommentCnt(r_no));
		
		List<CommentVO> list = dao.commentList(r_no, cri);
		
		float star_avg = dao.getStarAvg(r_no);
		
		map.put("commentList", list);
		map.put("pageMaker", pageMaker);
		map.put("star_avg", star_avg);
		
		return map;
	}
	
}
