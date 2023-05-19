package com.zkzkdh451.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.zkzkdh451.domain.UsersVO;

import lombok.Getter;

@Getter
public class CustomUser extends User{ 
	
	private UsersVO member;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		
		super(username, password, authorities);
		
	}

	public CustomUser (UsersVO vo) {
		
		this(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		this.member = vo;
	}
	
}
