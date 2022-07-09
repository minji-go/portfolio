package com.project.cafe.dataClass;

/**
 * 카페의 메뉴를 저장하는 클래스입니다
 * @author 고민지
 */
public class Menu {
	
	
	private String seq;
	private String name;
	private int price;
	private String cseq;
	
	/**
	 * 데이터 파일에 있는 메뉴를 저장하는 생성자입니다.
	 * @param seq 메뉴번호(PK)
	 * @param name 메뉴명
	 * @param price 가격
	 * @param cseq 카테고리번호(FK)
	 */
	public Menu(String seq, String name, int price, String cseq) {
		this.seq = seq;
		this.name = name;
		this.price = price;
		this.cseq = cseq;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCseq() {
		return cseq;
	}

	public void setCseq(String cseq) {
		this.cseq = cseq;
	}

	@Override
	public String toString() {
		return String.format("Menu [seq=%s, name=%s, price=%s, cseq=%s]", seq, name, price, cseq);
	}
	
	
	

	
}
