package net.koreate.staybusan.room.controller;

import javax.inject.Inject;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.staybusan.room.service.RoomMessageService;
import net.koreate.staybusan.room.vo.MessageVO;

@RestController
@RequestMapping("/messages")
public class RoomMessageController {
	@Inject
	RoomMessageService ms;
	
	@PostMapping("/send")
	public ResponseEntity<String> sendMessage(@RequestBody MessageVO vo) throws Exception{
		ResponseEntity<String> entity = null;
		
		System.out.println("컨트롤러로 넘어온 메시지 확인");
		System.out.println(vo);
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html;charset=UTF-8");
		
		try {
			ms.sendMessage(vo);
			entity = new ResponseEntity<>("메시지 보내기 성공!", header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("메시지 보내기 실패", header, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
