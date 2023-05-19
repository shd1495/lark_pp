package com.zkzkdh451.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/dashboard")
	public void dashboard() {
	}
	
}
