package com.zkzkdh451.mapper;

import java.util.List;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersVO;

public interface UsersMapper {

	public void register(UsersVO vo);
	
	public UsersVO read(String userid);

	public int idChk(String id);
	
	public int nickChk(String nickname);

	public void insertAuth(AuthVO auth);
	
	public List<UsersVO> getList(UsersCriteria cri);
	
	public int getTotalCount(UsersCriteria cri);
	
	public boolean update(AuthVO vo);
}
