package com.project.cafe.dataClass;
/**
 * 커스텀메뉴를 저장하는 클래스입니다.
 * @author 고수경
 *
 */
public class CustomMenu {
	private String seq;	
	private String clientSeq; 
	private String menuSeq; 
	private String iceSeq;
	private String syrupSeq;
	private String shotSeq;
	private String whippingSeq;
	private String toppingSeq;
	
	/**
	 * CustomMenu 객체가 만들어지면 CustomMenu 멤버 변수들을 초기화하는 생성자입니다.
	 * @param seq 커스텀메뉴 번호
	 * @param clientSeq 고객 번호
	 * @param menuSeq 메뉴 번호
	 * @param iceSeq 얼음량 번호
	 * @param syrupSeq 시럽 번호
	 * @param shotSeq 샷추가 번호
	 * @param whippingSeq 휘핑 번호
	 * @param toppingSeq 토핑 번호
	 */
	public CustomMenu(String seq, String clientSeq, String menuSeq, String iceSeq, String syrupSeq, String shotSeq,
			String whippingSeq, String toppingSeq) {
		super();
		this.seq = seq;
		this.clientSeq = clientSeq;
		this.menuSeq = menuSeq;
		this.iceSeq = iceSeq;
		this.syrupSeq = syrupSeq;
		this.shotSeq = shotSeq;
		this.whippingSeq = whippingSeq;
		this.toppingSeq = toppingSeq;
	}


	public String getSeq() {
		return seq;
	}


	public void setSeq(String seq) {
		this.seq = seq;
	}


	public String getClientSeq() {
		return clientSeq;
	}


	public void setClientSeq(String clientSeq) {
		this.clientSeq = clientSeq;
	}


	public String getMenuSeq() {
		return menuSeq;
	}


	public void setMenuSeq(String menuSeq) {
		this.menuSeq = menuSeq;
	}


	public String getIceSeq() {
		return iceSeq;
	}


	public void setIceSeq(String iceSeq) {
		this.iceSeq = iceSeq;
	}


	public String getSyrupSeq() {
		return syrupSeq;
	}


	public void setSyrupSeq(String syrupSeq) {
		this.syrupSeq = syrupSeq;
	}


	public String getShotSeq() {
		return shotSeq;
	}


	public void setShotSeq(String shotSeq) {
		this.shotSeq = shotSeq;
	}


	public String getWhippingSeq() {
		return whippingSeq;
	}


	public void setWhippingSeq(String whippingSeq) {
		this.whippingSeq = whippingSeq;
	}


	public String getToppingSeq() {
		return toppingSeq;
	}


	public void setToppingSeq(String toppingSeq) {
		this.toppingSeq = toppingSeq;
	}


	@Override
	public String toString() {
		return "CustomMenu [seq=" + seq + ", clientSeq=" + clientSeq + ", menuSeq=" + menuSeq + ", iceSeq=" + iceSeq
				+ ", syrupSeq=" + syrupSeq + ", shotSeq=" + shotSeq + ", whippingSeq=" + whippingSeq + ", toppingSeq="
				+ toppingSeq + "]";
	}
	
	
	
	
	
	
	
}


