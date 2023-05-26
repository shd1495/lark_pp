package com.zkzkdh451.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.service.UsersService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/users")
@AllArgsConstructor
public class UsersRestController {
	
	private UsersService service;
	
	@GetMapping(value = "/idChk")
	@ResponseBody
	public ResponseEntity<String> idChk(@RequestParam("userid") String id,@RequestParam("nickname") String nickname){
		
		String result = String.valueOf(service.idChk(id, nickname));
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@GetMapping("/chkPw")
	public String chkPw(@RequestParam("userid") String userid,
			@RequestParam("checkPassword") String checkPassword) {
		
		UsersVO vo = service.read(userid);
		String userpw1 = checkPassword;
		String userpw2 = vo.getUserpw();
		
		return String.valueOf(service.checkPassword(userpw1, userpw2));
	}
}
