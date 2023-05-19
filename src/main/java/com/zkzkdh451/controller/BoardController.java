package com.zkzkdh451.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/list")
	public void boardList (Model model) {
		model.addAttribute("list", service.getList());
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public void writePage () {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/write")
	public String write(BoardVO vo) {
		
		service.write(vo); 
		
		return "redirect:/board/list";
	}
}
