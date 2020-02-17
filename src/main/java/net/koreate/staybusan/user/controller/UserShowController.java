package net.koreate.staybusan.user.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.staybusan.user.service.UserShowService;

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
	
	
	

}
