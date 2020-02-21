package net.koreate.staybusan.user.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.staybusan.user.service.UserShowService;
import net.koreate.staybusan.user.vo.ModIntroDTO;
import net.koreate.staybusan.user.vo.UserVO;

@Controller
@RequestMapping("/user/*")
public class UserShowController {
	
	@Inject
	UserShowService uss;
	
	@GetMapping("show")
	public void showMyPage(int u_no, Model model) throws Exception{
		System.out.println("프로필 불러올 유저 번호 : "+u_no);
		
		Map<String, Object> myAllInfo = uss.getMyInfo(u_no);
		
		model.addAttribute("myAllInfo", myAllInfo);
	}
	
	@PostMapping("mod")
	@ResponseBody
	public ResponseEntity<String> modIntro(ModIntroDTO dto) throws Exception{
//		System.out.println(dto);
		
		ResponseEntity<String> entity = null;
		
		UserVO vo;
		try {
			vo = uss.modIntro(dto);
			System.out.println("변경 후 : "+vo);
			
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", "text/plain;charset=UTF-8");
			
			entity = new ResponseEntity<>(vo.getU_introduce(), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	

}
