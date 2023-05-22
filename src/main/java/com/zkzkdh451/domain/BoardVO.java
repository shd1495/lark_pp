package com.zkzkdh451.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private final String TABLE_ID = "board";
	
	private Long bno;
	private String title;
	private String content;
	private String userid;
	
	private Date regDate;
	private Date updateDate;
	
	private int replyCnt;
	private int hit;
	
	private List<BoardAttachVO> attachList;
}
