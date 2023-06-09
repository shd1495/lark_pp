package com.zkzkdh451.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.mapper.UsersMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UsersMapperTests {

	@Setter(onMethod_ = @Autowired)
	private UsersMapper mapper;
	
	@Test
	public void testInsert () {
		String userid = "reinhar";
		
		mapper.idChk(userid);
	}
	
}
