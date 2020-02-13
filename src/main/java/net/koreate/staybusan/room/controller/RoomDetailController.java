package net.koreate.staybusan.room.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.staybusan.room.service.RoomDetailService;
import net.koreate.staybusan.room.vo.BuyVO;

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
	
	@PostMapping("bookingRoom")
	public String bookingRoom( 
			@ModelAttribute BuyVO vo,
			RedirectAttributes rttr) throws Exception{
		String convent_from = vo.getDate_from_dummy();
		String convent_to = vo.getDate_to_dummy();
		
		SimpleDateFormat convert = new SimpleDateFormat("yyyy-MM-dd");
		Date from = convert.parse(convent_from);
		Date to = convert.parse(convent_to);
		
		vo.setB_date_from(from);
		vo.setB_date_to(to);
		
		System.out.println(vo);
		
		if(rds.bookingRoom(vo)) {
			rttr.addFlashAttribute("message", "y");
		}else {
			rttr.addFlashAttribute("message", "n");
		}
		
		return "redirect:/";
	}
}
