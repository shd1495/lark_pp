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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zkzkdh451.domain.AuthVO;
import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.domain.PageDTO;
import com.zkzkdh451.domain.UsersCriteria;
import com.zkzkdh451.domain.UsersPageDTO;
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
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/logout")
	public void logoutGET() {
		
		log.info("custom logout");
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/userInfo")
	public void userInfo (Principal principal, ModelMap modelMap){
        String loginId = principal.getName();
        UsersVO user = service.read(loginId);
        modelMap.addAttribute("user", user);
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/userInfoMod")
	public void userInfoMod (Principal principal, ModelMap modelMap){
        String loginId = principal.getName();
        UsersVO user = service.read(loginId);
        modelMap.addAttribute("user", user);
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/userInfoMod")
	public String userInfoMod (UsersVO vo, RedirectAttributes rttr){
		
		if(service.modify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/users/userInfo";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/userMod")
	public void userMod (String userid, Model model){
        UsersVO user = service.read(userid);
        model.addAttribute("user", user);
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/userMod")
	public String userMod (AuthVO vo, RedirectAttributes rttr) {
		if(service.authModify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}	
		return "redirect:/users/list";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/list")
	public void list(UsersCriteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new UsersPageDTO(cri, total));
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/canList")
	public void canList(UsersCriteria cri, Model model) {
		model.addAttribute("list", service.getCanList(cri));
		
		int total = service.getCanTotal(cri);
		
		model.addAttribute("pageMaker", new UsersPageDTO(cri, total));
	}
	
	@PostMapping("/userInfoDel")
	public String delete(UsersVO vo, RedirectAttributes rttr) {
		if(service.remove(vo)) { 
			rttr.addFlashAttribute("result", "success"); 
		};
		return "redirect:/users/logout";
	}
	
}
