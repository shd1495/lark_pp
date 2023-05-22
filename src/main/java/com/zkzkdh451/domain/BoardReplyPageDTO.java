package com.zkzkdh451.domain;

import java.util.List;

import lombok.Data;

@Data
public class BoardReplyPageDTO {

	private int replyCnt;//해당글의 댓글수
	private List<BoardReplyVO> list;//해당글의 댓글 목록
	
	public BoardReplyPageDTO(int replyCnt, List<BoardReplyVO> list) {
		super();
		this.replyCnt = replyCnt;
		this.list = list;
	}

	
}
