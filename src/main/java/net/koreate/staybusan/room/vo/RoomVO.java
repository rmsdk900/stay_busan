package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RoomVO {
	
	private int r_no;
	private int u_no;
	private String r_name;
	private String r_desc;
	private Date r_date_from;
	private Date r_date_to;
	private int r_price;
	private String r_addr_main;
	private String r_addr_detail;
	private int r_guests;
	private int r_bath;
	private int r_bedroom;
	private int r_bed;
	private Date r_checkin;
	private Date r_checkout;
	private String r_gu;
}
