package com.project.care.main.diagnosis.inquire;

import lombok.Data;

@Data
public class QuesAnsDTO {
	private String qaseq;	 //답변번호
	private String content;	 //답변내용
	private String regdate;	 //작성일
	private String hqseq;	 //병원문의게시판 번호
	private String id;		 //아이디
	private String attachFile;
	
	private String nickname; //닉네임
	
}
