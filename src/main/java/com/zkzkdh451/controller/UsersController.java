package com.zkzkdh451.controller;


import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.UsersVO;
import com.zkzkdh451.service.UsersService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/users/*")
@AllArgsConstructor
public class UsersController {
	
	private BCryptPasswordEncoder passwordEncoder;
	private UsersService service;

	@PreAuthorize("isAnonymous()")
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(UsersVO vo, AuthVO auth) {
		
		List<AuthVO> authList = new ArrayList<>();
		authList.add(auth);
		
		String userpw = passwordEncoder.encode(vo.getUserpw());
		
		vo.setUserpw(userpw);
		
		vo.setAuthList(authList);
		
		service.register(vo);
		
		return "redirect:/users/login";
	}
	
	@PreAuthorize("isAnonymous()")
	@GetMapping("/login")
	public void login () {
		
	}
	
	@PostMapping("/login")
	public String login(UsersVO vo) {
		
		vo.getUserid();
		vo.getAuthList();
		
		return "/dashboard";
	}
	
	/*
	 * @GetMapping("/idChk")
	 * 
	 * @ResponseBody public String idChk(@RequestParam("userid") String userid) {
	 * 
	 * int result = service.idChk(userid);
	 * 
	 * return String.valueOf(result); }
	 */
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

	    if(authentication != null){
	        new SecurityContextLogoutHandler().logout(request,response,authentication);
	    }
	    
		return "redirect:/";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/userInfo")
	public void userInfo (Principal principal, ModelMap modelMap){
        String loginId = principal.getName();
        UsersVO user = service.read(loginId);
        modelMap.addAttribute("user", user);
	}
}
