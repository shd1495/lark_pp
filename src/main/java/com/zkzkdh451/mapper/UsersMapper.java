package com.zkzkdh451.mapper;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.UsersVO;

public interface UsersMapper {

	public void register(UsersVO vo);
	
	public UsersVO read(String userid);

	public int idChk(String id);

	public void insertAuth(AuthVO auth);
}
