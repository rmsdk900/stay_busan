package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RoomsDTO {
	private int r_no;
	private Date r_date_from;
	private Date r_date_to;
}
