package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BuyVO {
	private int b_no;
	private int r_no;
	private int u_no;
	private Date b_date_from;
	private Date b_date_to;
	private int b_guest;
	private int b_total_price;
	private int b_status;
	
	private String date_from_dummy;
	private String date_to_dummy;
	
	
	
}
