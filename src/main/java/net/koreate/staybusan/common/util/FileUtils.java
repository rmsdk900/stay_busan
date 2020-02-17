package net.koreate.staybusan.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
	
	ServletContext context;
	
	String uploadPath;
	
	private static FileUtils utils;
	
	private FileUtils() {}
	
	private FileUtils(ServletContext context) {
		this.context = context;
		createUploadPath();
	}
	
	public static FileUtils getInstance(ServletContext context) {
		if(utils == null) {
			utils = new FileUtils(context);
		}
		return utils;
	}
	
	private void createUploadPath() {
		uploadPath = context.getRealPath(File.separator+"upload");
		System.out.println("uploadPath : "+uploadPath);
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			System.out.println("uplodad 폴더 생성");
			file.mkdirs();
		}
		
	}
	
	
	
	
	// 전체 파일 올리기(controller랑 연결)
	public List<String> uploadFile(MultipartFile[] files, int u_no, int r_no) throws Exception{
		List<String> fileList = new ArrayList<>();
		
		for(MultipartFile file : files) {
			try {
				String fileName = uploadFile(file, u_no, r_no);
				System.out.println("fileList에 넣은 파일 이름 : "+fileName);
				fileList.add(fileName);
			} catch (Exception e) {
				e.printStackTrace();
				throw new IOException("업로드 할 수 없는 파일이 포함되어 있습니다.");
			}
		}
		
		return fileList;
	}
	
	// 파일 경로 설정
	public String getFolder(int u_no, int r_no) {
		String str = u_no+File.separator+r_no;
		System.out.println(u_no+"번째 회원의 "+r_no+"번 방 폴더 : "+str);
		
		return str;
	}
	
	
	// 각각의 파일 올리기
	public String uploadFile(MultipartFile file, int u_no, int r_no) throws Exception{
		String uploadFolder = getFolder(u_no, r_no);
		System.out.println("upload 안의  Folder : "+uploadFolder);
		String originalName = file.getOriginalFilename();
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString().replace("-", "")+"_"+originalName;
		System.out.println("저장될 파일 이름 : "+savedName);
		
		File uploadFolderFile = new File(uploadPath, uploadFolder);
		if(!uploadFolderFile.exists()) {
			uploadFolderFile.mkdirs();
			System.out.println("/유저 번호/방 번호 폴더 생성");
		}
		File upload = new File(uploadPath+File.separator+uploadFolder, savedName);
		
		System.out.println("upload file absolute path : "+upload.getAbsolutePath());
		
		byte[] fileData = file.getBytes();
		
		FileCopyUtils.copy(fileData, upload);
		
		System.out.println("파일 생성 완료");
		
		return makeFileUploadName(uploadFolder, savedName);
	}
	
	
	//파일 이름 만들기
	private String makeFileUploadName(String uploadFolder, String savedName) throws IOException{
		
		//확장자
		String ex = savedName.substring(savedName.lastIndexOf(".")+1);
		// 전체 파일 경로 
		String entirePath = uploadPath+File.separator+uploadFolder+File.separator+savedName;
		
		System.out.println("makeFileUploadName() 파일 전체 경로 : "+entirePath);
		
		if(MediaUtils.getMediaType(ex)!= null) {
			System.out.println("이미지 파일");
		}else {
			System.out.println("이미지 파일 아님");
			throw new IOException();
		}
		
		return entirePath.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	
	// ----------------공사 중-----------------------------------
	
	public byte[] displayFile(String fileName) throws IOException{
//		System.out.println("보여줄 fileName : "+fileName);
		
		InputStream in = null;
		String path = uploadPath+(fileName).replace('/', File.separatorChar);
		byte[] bytes = null;
		try {
			in = new FileInputStream(path);
			bytes = IOUtils.toByteArray(in);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("File이 없음 : "+e.getMessage());
		} finally {
			in.close();
		}
		return bytes;
	}
	
	public HttpHeaders getHeader(String fileName) throws Exception{
		HttpHeaders header = null;
		
		header = new HttpHeaders();
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		if(mType != null) {
//			System.out.println("IMAGE");
			header.setContentType(mType);
		}else {
			System.out.println("IMAGE 파일 아님");
			fileName = fileName.substring(fileName.indexOf("_")+1);
			header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			header.add("content-disposition", "attachment;fileName=\""+new String(fileName.getBytes("utf-8"), "ISO-8859-1")+"\"");
		}
		
		return header;
	}
	
	

	public String deleteAllFiles(List<String> files) {
		for(String file : files) {
			String ex = file.substring(file.lastIndexOf(".")+1);
			if(MediaUtils.getMediaType(ex)!= null) {
				// 원본도 삭제
				String name = file.replace("s_", "");
				new File(uploadPath+(name).replace('/', File.separatorChar)).delete();
			}
			new File(uploadPath+(file).replace('/', File.separatorChar)).delete();
		}
		return "SELECTED FILES IS DELETED";
	}

	public String deleteFile(String fileName) {
		String ex = fileName.substring(fileName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(ex)!= null) {
			// 원본도 삭제
			String name = fileName.replace("s_", "");
			new File(uploadPath+(name).replace('/', File.separatorChar)).delete();
		}
		new File(uploadPath+(fileName).replace('/', File.separatorChar)).delete();
		return "DELETED";
	}
	
	public void removeList(List<String> list, String path)throws Exception {
		if(!list.isEmpty()) {
			System.out.println("list 확인");
			String realPath = path.replace('/', File.separatorChar);
			System.out.println(realPath);
			
			List<String> removeList = new ArrayList<>();
			File file = new File(uploadPath, realPath);
			
			List<File> files = Arrays.asList(file.listFiles());
			
			for(File f : files) {
				System.out.println(f.getName());
				String removeFilePath = path+f.getName();
				String thumbNail = path+"s_"+f.getName();
				if(!list.contains(removeFilePath) && !list.contains(thumbNail)) {
					removeList.add(removeFilePath);
				}
			}
			for(String s : removeList) {
				System.out.println("removeFile : "+s);
			}
			if(!removeList.isEmpty()) {
				System.out.println(deleteAllFiles(removeList));
			}
		}
	}
	
	
}
