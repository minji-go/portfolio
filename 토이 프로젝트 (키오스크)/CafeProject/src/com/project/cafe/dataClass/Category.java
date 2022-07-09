package com.project.cafe.dataClass;

/**
 * 카페메뉴의 카테고리를 저장하는 클래스입니다
 * @author kohmi
 *
 */
public class Category {

	private String seq;
	private String name;
	
	/**
	 * 데이터 파일에 있는 메뉴의 카테고리를 저장하는 생성자입니다.
	 * @param seq 카테고리번호(PK)
	 * @param name 카테고리명
	 */
	public Category(String seq, String name) {
		super();
		this.seq = seq;
		this.name = name;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return String.format("Category [seq=%s, name=%s]", seq, name);
	}
	
	
	
}
