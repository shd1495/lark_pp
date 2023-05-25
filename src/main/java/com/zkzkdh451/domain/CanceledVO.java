package com.zkzkdh451.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CanceledVO {

	private int cno;
	private String userid;
	private String userName;
	private String userEmail;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date canDate;
}
