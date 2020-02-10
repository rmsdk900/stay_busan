package net.koreate.staybusan.room.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.staybusan.room.service.RoomDetailService;

@Controller
@RequestMapping("/room/*")
public class RoomDetailController {
	@Inject
	RoomDetailService rds;
	
	@GetMapping("detail")
	public String roomDetail(int r_no, Model model)throws Exception{
		System.out.println("가져올 방 번호 : "+r_no);
		
		Map<String, Object> roomInfo = rds.readRoom(r_no);
		
		model.addAttribute("roomInfo", roomInfo);
		
		return "room/detail";
	}
}
