package net.koreate.staybusan.room.service;

import java.util.List;
import java.util.Map;

import net.koreate.staybusan.room.vo.BanCommentVO;
import net.koreate.staybusan.room.vo.CommentVO;

public interface RoomCommentService {

	// 코멘트 리스트 불러오기
	Map<String, Object> getCommentList(int r_no, int page)throws Exception;
	
	// reply 추가
	String addReply(CommentVO vo)throws Exception;
	
	// Comment 삭제
	String delComment(int c_no)throws Exception;
	// Comment 수정
	CommentVO modComment(int c_no, String c_content)throws Exception;
	
	// Comment 신고
	List<BanCommentVO> banComment(BanCommentVO vo) throws Exception;

}
