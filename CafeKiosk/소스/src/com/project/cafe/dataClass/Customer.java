package com.project.cafe.dataClass;

/**
 * 고객의 번호를 저장하는 클래스입니다.
 * @author 고민지
 *
 */
public class Customer {

	private String seq;
	private String tel;

	/**
	 * 데이터 파일에 있는 고객번호를 저장하는 생성자입니다.
	 * @param seq 고객번호(PK)
	 * @param tel 전화번호
	 */
	public Customer(String seq, String tel) {
		this.seq = seq;
		this.tel = tel;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	@Override
	public String toString() {
		return String.format("Customer [seq=%s, tel=%s]", seq, tel);
	}
	
	
	
}
