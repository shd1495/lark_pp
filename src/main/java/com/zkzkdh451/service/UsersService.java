package com.zkzkdh451.service;


import java.util.List;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.CanUsersVO;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.security.domain.CustomUser;

public interface UsersService {

	public void register(UsersVO vo);
	
	public int idChk(String id, String nickname);
	
	public UsersVO read(String id);
	
	public List<UsersVO> getList(UsersCriteria cri);
	
	public List<CanUsersVO> getCanList(UsersCriteria cri);
	
	public int getTotal(UsersCriteria cri); 
	
	public int getCanTotal(UsersCriteria cri); 
	
	public boolean authModify(AuthVO vo);
	
	public boolean modify(UsersVO vo);
	
	public boolean modifyPw(UsersVO vo);
	
	public boolean remove(UsersVO vo);
	
	public boolean checkPassword(String userid, String checkPassword);
}
