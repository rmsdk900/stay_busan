package net.koreate.staybusan.room.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.staybusan.room.service.RoomReservationService;
import net.koreate.staybusan.room.vo.BuyVO;

@RestController
@RequestMapping("/book/*")
public class RoomReservationController {
	
	@Inject
	RoomReservationService rrs;
	
	// 날짜 입력했을 때 숙박 가능 인원 뿌려주기
	@PostMapping("/checkPeople")
	public ResponseEntity<Integer> checkPeople(
			@RequestBody BuyVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			Integer bookedPeople = rrs.checkPeople(vo);
			System.out.println(bookedPeople);
			entity = new ResponseEntity<>(bookedPeople, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 인원 입력했을 때 불가하게 하기
	@PostMapping("/people")
	public ResponseEntity<List<String>> howMany(
			@RequestBody BuyVO vo)throws Exception{
		ResponseEntity<List<String>> entity = null;
		
		System.out.println(vo);
		List<String> message = rrs.howMany(vo);
		
		
		
		
		return entity;
	}
	
	
	
}
