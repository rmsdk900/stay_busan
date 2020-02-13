package net.koreate.staybusan.room.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.staybusan.room.service.RoomDateService;
import net.koreate.staybusan.room.vo.AvailableDateDTO;
import net.koreate.staybusan.room.vo.RoomClosedVO;

@RestController
public class RoomDateController {
	
	@Inject
	RoomDateService rbds;
	
//	@GetMapping("/getBanDates/{r_no}")
//	public ResponseEntity<List<RoomClosedVO>> getBanDates(@PathVariable("r_no") int r_no)throws Exception{
//		ResponseEntity<List<RoomClosedVO>> entity = null;
//		
////		System.out.println("금지 날짜 받아올 방 번호 확인 : "+r_no);
//		
//		try {
//			List<RoomClosedVO> list = rbds.getBanDates(r_no);
////		System.out.println(list);
//			entity = new ResponseEntity<>(list, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//		
//	}
	
//	@GetMapping("/getAvailableDate/{r_no}")
//	public ResponseEntity<AvailableDateDTO> getAvailableDate(
//			@PathVariable("r_no") int r_no)throws Exception{
//		ResponseEntity<AvailableDateDTO> entity = null;
//		
//		try {
//			AvailableDateDTO dto = rbds.getAvailableDate(r_no);
////		System.out.println(dto);
//			entity = new ResponseEntity<>(dto, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//	}
	
	@GetMapping("/getAvailableDate/{r_no}")
	public ResponseEntity<Map<String, Object>> getAvailableDate(
			@PathVariable("r_no") int r_no)throws Exception{
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			AvailableDateDTO dto = rbds.getAvailableDate(r_no);
			List<RoomClosedVO> list = rbds.getBanDates(r_no);
			map.put("availableDate", dto);
			map.put("closedDate", list);
			
//		System.out.println(dto);
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
