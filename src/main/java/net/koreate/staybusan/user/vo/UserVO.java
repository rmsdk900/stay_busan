package net.koreate.staybusan.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	private int u_no;
	private String u_id;
	private String u_pw;
	private String u_name;
	private String u_introduce;
	private int u_type;
	private String u_phone;
	private Date u_regdate;
	private String u_withdrawal;
	private String u_profile;
	private int u_balance;
	
}
