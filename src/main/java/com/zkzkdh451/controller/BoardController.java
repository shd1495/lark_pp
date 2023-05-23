package com.zkzkdh451.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zkzkdh451.domain.BoardAttachVO;
import com.zkzkdh451.domain.BoardVO;
import com.zkzkdh451.domain.Criteria;
import com.zkzkdh451.domain.PageDTO;
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
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public void writePage () {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/write")
	public String write(BoardVO vo, RedirectAttributes rttr) {
		
		service.write(vo); 
		
		log.info(vo.getBno());
		
		rttr.addFlashAttribute("result", vo.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.userid")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}	

		return "redirect:/board/list"+cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #board.userid")
	@PostMapping("/remove")
	public String remove(BoardVO board, @ModelAttribute("cri") Criteria cri, 
								RedirectAttributes rttr) {
		
		List<BoardAttachVO> attachList = service.getAttachList(board);
		
		if(service.remove(board)) { 
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success"); 
		};
		
		return "redirect:/board/list"+cri.getListLink();
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(attach -> {
			
			
			try {
				Path file = Paths.get("d:/upload/"+attach.getUploadPath()+"/"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumNail = Paths.get("d:/upload/"+attach.getUploadPath()+"/thum_"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumNail);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
	
	@GetMapping("/getAttachList")
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		BoardVO vo = new BoardVO();
		vo.setBno(bno);
		return new ResponseEntity<>(service.getAttachList(vo), HttpStatus.OK);
	}
}
