package com.zkzkdh451.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.mapper.UsersMapper;
import com.zkzkdh451.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = @Autowired)
	private UsersMapper Mapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		log.warn("Load User By UserName : " + userName);
		
		UsersVO vo = Mapper.read(userName);
		
		return vo == null ? null : new CustomUser(vo);
	}

}
