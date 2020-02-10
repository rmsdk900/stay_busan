package net.koreate.staybusan.room.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RoomClosedVO {
	private int r_no;
	private Date closed_from;
	private Date closed_to;
}
