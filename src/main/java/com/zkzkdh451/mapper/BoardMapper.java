package com.zkzkdh451.mapper;

import java.util.List;

import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;

public interface BoardMapper {

	public void insert(BoardVO vo);

	public List<BoardVO> getList(Criteria cri);

	public BoardVO get(Long bno);

	public int getTotalCount(Criteria cri);

}
