package com.zkzkdh451.service;

import java.util.List;

import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;

public interface BoardService {

	public void write(BoardVO vo);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri); 

	public BoardVO get(Long bno);

}
