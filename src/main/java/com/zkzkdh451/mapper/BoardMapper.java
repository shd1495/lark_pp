package com.zkzkdh451.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;

public interface BoardMapper {

	public void insert(BoardVO vo);

	public List<BoardVO> getList(Criteria cri);

	public BoardVO get(Long bno);

	public int getTotalCount(Criteria cri);

	public void updateHit(@Param("bno") Long bno);
	
	public boolean update(BoardVO board);

	public boolean delete(Long bno);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

}
