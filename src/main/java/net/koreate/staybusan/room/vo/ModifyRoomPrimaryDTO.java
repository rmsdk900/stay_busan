package net.koreate.staybusan.room.vo;

import lombok.Data;

@Data
public class ModifyRoomPrimaryDTO {
	private int r_no;
	private String r_name;
	private int r_guests;
	private int r_bedroom;
	private int r_bed;
	private int r_bath;
	private String r_desc;
	private int r_price;
}
