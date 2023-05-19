package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zkzkdh451.domain.BoardVO;
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
	public List<BoardVO> getList() {
		return mapper.getList();
	}

}
