package com.zkzkdh451.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class UsersPageDTO {

	private int startPage;//시작 번호
	private int endPage;//끝 번호
	private boolean prev, next;// 이전, 다음 여부
	private int pageCount;//페이지에 보여줄 갯수
	
	private int total;//전체글 수
	private int realEnd;
	private UsersCriteria cri;//현재 페이지 번호, 현 페이지에 보여줄 갯수
	
	public UsersPageDTO (UsersCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.pageCount = 5;
		//endPage 구하는 공식
		this.endPage = (int)(Math.ceil(cri.getPageNum() / (pageCount*1.))) * pageCount;
		//startPage 구하는 공식
		this.startPage = this.endPage - (pageCount-1);
		
		this.realEnd = (int)(Math.ceil((total * 1.) / cri.getAmount()));
		
		if(this.realEnd < this.endPage) {
			this.endPage = this.realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
}
