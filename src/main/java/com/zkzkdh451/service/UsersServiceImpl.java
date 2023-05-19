package com.zkzkdh451.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zkzkdh451.domain.AuthVO;
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

}
