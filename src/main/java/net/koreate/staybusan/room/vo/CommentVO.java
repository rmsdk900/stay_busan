package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	private int c_no;
	private int r_no;
	private int u_no;
	private String u_name;
	private String c_content;
	private float c_star;
	private Date c_regdate;
	private int c_origin;
	private int c_dep;
	private int c_seq;
}
