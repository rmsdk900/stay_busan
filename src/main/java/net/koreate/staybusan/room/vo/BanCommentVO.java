package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BanCommentVO {
	private int c_no;
	private int b_c_reporter;
	private String b_c_reason;
	private int b_c_bad_person;
	private String c_content;
	private Date b_c_date;
}
