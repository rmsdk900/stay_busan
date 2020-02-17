package net.koreate.staybusan.room.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.staybusan.room.service.RoomCommentService;

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
	
	
}
