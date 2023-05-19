package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public void write(BoardVO vo) {
		mapper.insert(vo);
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getList(cri);
	}

	@Override
	public BoardVO get(Long bno) {
		
		mapper.updateHit(bno);
		
		return mapper.get(bno);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public boolean modify(BoardVO board) {
		
		boolean modifyResult = mapper.update(board);
		
		return modifyResult;
	}
	
	@Override
	public boolean remove(BoardVO board) {
		
		return mapper.delete(board.getBno());//해당 글 삭제
	}

}
