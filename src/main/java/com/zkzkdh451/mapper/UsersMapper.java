package com.zkzkdh451.mapper;

import java.util.List;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.CanUsersVO;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersVO;

public interface UsersMapper {

	public void register(UsersVO vo);
	
	public UsersVO read(String userid);

	public int idChk(String id);
	
	public int nickChk(String nickname);

	public void insertAuth(AuthVO auth);
	
	public List<UsersVO> getList(UsersCriteria cri);
	
	public List<CanUsersVO> getCanList(UsersCriteria cri);
	
	public int getTotalCount(UsersCriteria cri);
	
	public int getCanTotalCount(UsersCriteria cri);
	
	public boolean authUpdate(AuthVO vo);
	
	public boolean update(UsersVO vo);
	
	public boolean updatePw(UsersVO vo);
	
	public boolean deleteAuth(UsersVO vo);
	
	public boolean delete(UsersVO vo);
	
	public void canUser(UsersVO vo);
	
}
