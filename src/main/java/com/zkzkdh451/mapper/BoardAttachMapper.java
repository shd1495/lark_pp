package com.zkzkdh451.mapper;

import java.util.List;

import com.zkzkdh451.domain.BoardAttachVO;
import com.zkzkdh451.domain.BoardVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);

	public void deleteAll(BoardVO vo);
	
	public List<BoardAttachVO> findByBno(BoardVO vo);
	
	public List<BoardAttachVO> getOldFiles();
}
