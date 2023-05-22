package com.zkzkdh451.service;

import java.util.List;

import com.zkzkdh451.domain.BoardAttachVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;

public interface BoardService {

	//글 쓰기
	public void write(BoardVO vo);
	
	//글 목록
	public List<BoardVO> getList(Criteria cri);
	
	//글 갯수
	public int getTotal(Criteria cri); 

	//글 조회
	public BoardVO get(Long bno);
	
	//글 수정
	public boolean modify(BoardVO vo);

	public boolean remove(BoardVO vo);
	
	public List<BoardAttachVO> getAttachList(BoardVO vo);

}
