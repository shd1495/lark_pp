package com.zkzkdh451.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	@Override
	public void register(UsersVO vo) {
		mapper.register(vo);
		
		for (AuthVO auth : vo.getAuthList()) {
			
			mapper.insertAuth(auth);
		}
	}

	@Transactional
	@Override
	public int idChk(String id, String nickname) { 
		int chk1 = mapper.nickChk(nickname);
		int chk2 = mapper.idChk(id);
		int result = 1;
		
		if(chk1 == 0 && chk2 == 0) {
			result = 0;
		} else if(chk1 == 0 && chk2 == 1){
			result = 2;
		} else if(chk1 == 1 && chk2 == 0){
			result = 3;
		}
		
		return result;
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
	public boolean authModify(AuthVO vo) {
		boolean modifyResult = mapper.authUpdate(vo);
		return modifyResult;
	}

	@Override
	public boolean modify(UsersVO vo) {
		boolean modifyResult = mapper.update(vo);
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(UsersVO vo) {
		mapper.deleteAuth(vo);
		mapper.canUser(vo);
		
		return mapper.delete(vo);
	}

}
