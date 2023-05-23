package com.zkzkdh451.service;


import java.util.List;

import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersVO;

public interface UsersService {

	public void register(UsersVO vo);
	
	public int idChk(String id);
	
	public UsersVO read(String id);
	
	public List<UsersVO> getList(UsersCriteria cri);
	
	public int getTotal(UsersCriteria cri); 
}
