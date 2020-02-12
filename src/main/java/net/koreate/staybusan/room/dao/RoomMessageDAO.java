package net.koreate.staybusan.room.dao;

import org.apache.ibatis.annotations.Insert;

import net.koreate.staybusan.room.vo.MessageVO;

public interface RoomMessageDAO {
	
	
	@Insert("INSERT INTO message(m_receiver, m_sender, m_content, r_no) "
			+ " VALUES(#{m_receiver}, #{m_sender}, #{m_content}, #{r_no}) ")
	void sendMessage(MessageVO vo)throws Exception;

}
