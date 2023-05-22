package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zkzkdh451.domain.BoardAttachVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.mapper.BoardAttachMapper;
import com.zkzkdh451.mapper.BoardMapper;
import com.zkzkdh451.mapper.BoardReplyMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private BoardReplyMapper replyMapper;
	

	@Override
	public void write(BoardVO vo) {
		mapper.insert(vo);
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		vo.getAttachList().forEach(attach ->{
			attach.setBno(vo.getBno());
			attach.setTableId(vo.getTABLE_ID());
			attachMapper.insert(attach);
		});
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
	public boolean modify(BoardVO vo) {
		
		attachMapper.deleteAll(vo);
		
		boolean modifyResult = mapper.update(vo);
		
		if(modifyResult && vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			
			vo.getAttachList().forEach(attach ->{
				attach.setBno(vo.getBno());
				attach.setTableId(vo.getTABLE_ID());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	
	@Override
	public boolean remove(BoardVO vo) {

		replyMapper.deleteAll(vo.getBno());//댓글 삭제
		attachMapper.deleteAll(vo);//첨부파일 리스트 삭제
		
		return mapper.delete(vo.getBno());//해당 글 삭제
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(BoardVO vo) {
		return attachMapper.findByBno(vo);
	}
	

}
