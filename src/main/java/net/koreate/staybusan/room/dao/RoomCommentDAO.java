package net.koreate.staybusan.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import net.koreate.mvc.common.util.Criteria;
import net.koreate.staybusan.room.vo.CommentVO;

public interface RoomCommentDAO {

	// 먼저 총 후기 갯수부터 불러온다.
	@Select("SELECT count(*) FROM comment WHERE r_no=#{r_no}")
	int totalCommentCnt(int r_no) throws Exception;
	
	
	// 불러온다. 후기들
	@Select("SELECT * FROM comment "
			+ " WHERE r_no=#{r_no} "
			+ " ORDER BY c_origin DESC, c_seq ASC"
			+ " LIMIT #{cri.pageStart}, #{cri.perPageNum}")
	List<CommentVO> commentList(@Param("r_no") int r_no,@Param("cri") Criteria cri) throws Exception;

	// 평균 평점 구하기
	@Select("SELECT avg(c_star) FROM comment WHERE r_no=#{r_no}")
	float getStarAvg(int r_no)throws Exception;
	
	
}
