package net.koreate.staybusan.room.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.staybusan.room.service.RoomCommentService;
import net.koreate.staybusan.room.vo.CommentVO;

@RestController
@RequestMapping("/comments")
public class RoomCommentController {
	
	@Inject
	RoomCommentService cs;
	
	// 후기들 가져오기
	@GetMapping("/{r_no}/{page}")
	public ResponseEntity<Map<String, Object>> getCommentList(
			@PathVariable("r_no") int r_no,
			@PathVariable("page") int page)throws Exception{
		ResponseEntity<Map<String, Object>> entity = null;
		
		System.out.println("방 번호 확인 : "+r_no);
		
		try {
			Map<String, Object> map = cs.getCommentList(r_no, page);
			System.out.println(map);
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	// 후기에 대한 댓글 적기
	@PostMapping("/reply")
	public ResponseEntity<String> addReply(CommentVO vo)throws Exception{
		ResponseEntity<String> entity = null;
		
		System.out.println("대댓글 확인 : "+vo);
		
		try {
			String message = cs.addReply(vo);
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", "text/plain;charset=utf-8");
			entity = new ResponseEntity<>(message, header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
