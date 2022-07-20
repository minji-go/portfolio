package com.project.care.dto;

import lombok.Data;

@Data
public class CompanyDTO {

	private String id;		//아이디
	private String name;	//사용자이름
	private String tel;		//전화번호
	private String address;	//주소
	private String xcoor;	//x좌표
	private String ycoor;	//y좌표
	private String business;//사업자번호
	private String password;//비밀번호
	private String email;	//이메일
}
