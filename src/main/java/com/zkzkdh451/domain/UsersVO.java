package com.zkzkdh451.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UsersVO {

	private String userid;
	private String userpw;
	private String userName;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
	
	private boolean enabled;
	
	private List<AuthVO> authList;
}
