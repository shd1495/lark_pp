package com.zkzkdh451.mapper;

import java.util.List;

import com.zkzkdh451.domain.BoardVO;

public interface BoardMapper {

	public void insert(BoardVO vo);

	public List<BoardVO> getList();

}
