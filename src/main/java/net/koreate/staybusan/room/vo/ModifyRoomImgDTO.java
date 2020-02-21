package net.koreate.staybusan.room.vo;

import java.util.List;

import lombok.Data;

@Data
public class ModifyRoomImgDTO {
	private int r_no;
	private int u_no;
	
	// 파일들
	private List<String> files;
}
