package com.zkzkdh451.service;

import java.util.List;

import com.zkzkdh451.domain.BoardReplyPageDTO;
import com.zkzkdh451.domain.BoardReplyVO;
import com.zkzkdh451.domain.Criteria;

public interface BoardReplyService {

	public int register(BoardReplyVO vo);
	
	public BoardReplyVO get(Long rno);
	
	public int modify(BoardReplyVO vo);
	
	public int remove(Long rno);
	
	public BoardReplyPageDTO getList(int start, int amount, Long bno);
}
