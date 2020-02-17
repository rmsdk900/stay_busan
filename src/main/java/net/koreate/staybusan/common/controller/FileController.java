package net.koreate.staybusan.common.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.staybusan.common.util.FileUtils;
import net.koreate.staybusan.room.service.RoomImgService;

@RestController
public class FileController {
	@Inject
	ServletContext context;
	
	@Inject 
	RoomImgService ris;
	
	@PostMapping("/uploadFile/{u_no}/{r_no}")
	public ResponseEntity<Object> uploadFile(
			@RequestParam("file") MultipartFile[] files,
			@PathVariable("u_no") int u_no,
			@PathVariable("r_no") int r_no){
		ResponseEntity<Object> entity = null;
		List<String> list;
		
		try {
			list = FileUtils.getInstance(context).uploadFile(files, u_no, r_no);
			// 임시로 여기서 db에 넣겠음.
			System.out.println("등록한 fileList 확인");
			System.out.println(list);
			
			ris.regImg(list, u_no, r_no);
			
			entity = new ResponseEntity<>(list, HttpStatus.CREATED);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping("getImgs/{r_no}")
	public List<String> getImgs(@PathVariable("r_no") int r_no)throws Exception{
		System.out.println("이미지 불러오는 방 번호 : "+r_no);
		return ris.getImgs(r_no);
	}
	
	
	
	@GetMapping("getHostImg/{r_no}")
	public List<String> getHostImg(@PathVariable("r_no") int r_no)throws Exception{
		System.out.println("호스트 사진 불러오는 방 번호 : "+r_no);
		
		List<String> hostImg = ris.getHostImg(r_no);
		
		System.out.println("호스트 사진 : "+hostImg);
		
		return hostImg;
	}
	
	
	
	@GetMapping("getMyImg/{u_no}")
	public List<String> getGuestImg(@PathVariable("u_no") int u_no)throws Exception{
//		System.out.println("사진 불러올 게스트 번호 : "+u_no);
		
		return ris.getGuestImg(u_no);
	}
	
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(
			String fileName) throws Exception{
		
		FileUtils utils = FileUtils.getInstance(context);
		
		return new ResponseEntity<byte[]>(utils.displayFile(fileName),utils.getHeader(fileName),HttpStatus.OK);
	}
}
