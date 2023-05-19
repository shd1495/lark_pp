package com.zkzkdh451.service;


import com.zkzkdh451.domain.UsersVO;

public interface UsersService {

	public void register(UsersVO vo);
	
	public int idChk(String id);
	
	public UsersVO read(String id);
}
