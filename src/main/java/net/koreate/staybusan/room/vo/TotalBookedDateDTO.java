package net.koreate.staybusan.room.vo;


import java.util.Date;

import lombok.Data;

@Data
public class TotalBookedDateDTO {
	private Date min_date_from;
	private Date max_date_to;
}
