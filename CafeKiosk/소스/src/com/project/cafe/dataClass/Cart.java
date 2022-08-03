package com.project.cafe.dataClass;

import com.project.cafe.FindData;

/**
 * 
 * 장바구니에 들어갈 음료 옵션을 저장하는 클래스입니다.
 * @author 김승연
 *
 */
public class Cart {

	private String seq;
	private String menuSeq;
	private String iceSeq;
	private String syrupSeq;
	private String shotSeq;
	private String whippingSeq;
	private String toppingSeq;
	
	
	/**
	 * 
	 * 장바구니 내역을 초기화하는 생성자입니다.
	 * @param seq 장바구니 번호
	 * @param menuSeq 메뉴 번호
	 * @param iceSeq 얼음량 옵션 번호
	 * @param syrupSeq 시럽 옵션 번호
	 * @param shotSeq 샷추가 옵션 번호
	 * @param whippingSeq 휘핑크림 옵션 번호
	 * @param toppingSeq 토핑 추가 옵션 번호
	 */
	public Cart(String seq, String menuSeq, String iceSeq, String syrupSeq, String shotSeq,
			String whippingSeq, String toppingSeq) {
		super();
		this.seq = seq;
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
	
	/**
	 * 선택한 음료 및 옵션의 총 가격을 계산하여 반환하는 메소드입니다.
	 * @author 고민지
	 * @return 메뉴 총가격
	 */
	public int getTotalPrice() {
		
		int price = FindData.findMenu(menuSeq).getPrice();
		price += FindData.findIce(iceSeq).getPrice();
		price += FindData.findSyrup(syrupSeq).getPrice();
		price += FindData.findShot(shotSeq).getPrice();
		price += FindData.findWhipping(whippingSeq).getPrice();
		price += FindData.findTopping(toppingSeq).getPrice();
		
		return price;
	}
	

	@Override
	public String toString() {
		return String.format(
				"Cart [seq=%s, menuSeq=%s, iceSeq=%s, syrupSeq=%s, shotSeq=%s, whippingSeq=%s, toppingSeq=%s]",
				seq, menuSeq, iceSeq, syrupSeq, shotSeq, whippingSeq, toppingSeq);
	}
	


}