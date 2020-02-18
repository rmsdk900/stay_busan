package net.koreate.staybusan.room.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		
		if(list != null && list.size() > 0) {
			map.put("commentList", list);
			map.put("pageMaker", pageMaker);
			Float star_avg = dao.getStarAvg(r_no);
			if(star_avg != null) {
				map.put("star_avg", star_avg);
				
			}
		}
		
		return map;
	}

	@Transactional
	@Override
	public String addReply(CommentVO vo) throws Exception {
		String message=null;
		
		// 기존 글 seq 값 수정
		dao.updateOriginalSeq(vo);
		
		// 넣을 값들로 수정
		vo.setC_dep(vo.getC_dep()+1);
		vo.setC_seq(vo.getC_seq()+1);
		
		System.out.println("등록될 대댓글 정보 : "+vo);
		
		if(dao.addReply(vo)) {
			message = "대댓글 등록 성공!";
		}else {
			message = "대댓글 등록 실패...";
		}
		
		return message;
	}
	
	
	
}
