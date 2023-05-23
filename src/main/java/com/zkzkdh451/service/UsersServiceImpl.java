package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.mapper.UsersMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UsersServiceImpl implements UsersService {
	
	@Setter(onMethod_ = @Autowired)
	private UsersMapper mapper;

	@Override
	public void register(UsersVO vo) {
		mapper.register(vo);
		
		for (AuthVO auth : vo.getAuthList()) {
			
			mapper.insertAuth(auth);
		}
	}

	@Override
	public int idChk(String id) { 
		
		return mapper.idChk(id);
	}

	@Override
	public UsersVO read(String id) {
		return mapper.read(id);
	}
	
	@Override
	public List<UsersVO> getList(UsersCriteria cri) {
		return mapper.getList(cri);
	}
	
	@Override
	public int getTotal(UsersCriteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public boolean modify(AuthVO vo) {
		boolean modifyResult = mapper.update(vo);
		return modifyResult;
	}

}
