package com.zkzkdh451.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsersCriteria {

	private int pageNum;//페이지번호
	private int amount;//한페이장 몇 개의 데이터를 보여줄것인지
	
	public UsersCriteria() {
		this(1, 10);
	}
	
	public UsersCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getStart() {
		return (this.pageNum-1)*this.amount;
	}
	
	
	/**
	 * 웹페이지에서 매번 파라미터를 유지하는 일이 번거롭고 힘들다면 아래 메소드를 사용.
	 */
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount);
		
		return builder.toUriString();
	}
	

	public String getPagingLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("amount", this.amount);
		
		return builder.toUriString();
	}
}

