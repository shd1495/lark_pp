package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zkzkdh451.domain.BoardReplyPageDTO;
import com.zkzkdh451.domain.BoardReplyVO;
import com.zkzkdh451.mapper.BoardMapper;
import com.zkzkdh451.mapper.BoardReplyMapper;

import lombok.Setter;

@Service
public class BoardReplyServiceImpl implements BoardReplyService {

	@Setter(onMethod_ = @Autowired)
	private BoardReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(BoardReplyVO vo) {
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	
	@Override
	public BoardReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}

	@Override
	public int modify(BoardReplyVO vo) {
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		
		BoardReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public BoardReplyPageDTO getList(int start, int amount, Long bno) {
		BoardReplyPageDTO dto 
		= new BoardReplyPageDTO(
				mapper.getCountByBno(bno), 
				mapper.getListWithPaging(start, amount, bno)); 
		return dto;
	}

}
