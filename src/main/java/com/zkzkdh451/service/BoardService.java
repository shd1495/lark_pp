package com.zkzkdh451.service;

import java.util.List;

import com.zkzkdh451.domain.BoardVO;

public interface BoardService {

	public void write(BoardVO vo);

	public List<BoardVO> getList();

}
