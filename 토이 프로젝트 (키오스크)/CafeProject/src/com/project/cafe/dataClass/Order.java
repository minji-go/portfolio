package com.project.cafe.dataClass;

import java.util.Calendar;


/**
 * 주문 내역을 저장하는 클래스입니다.
 * @author 김승연
 *
 */
public class Order {


	//주문번호,메뉴번호,주문날짜,고객번호
	//1,2,2022-04-17,1

	private String seq;
	private String menuSeq;
	private Calendar orderDate;
	private String customerSeq;
	

	/**
	 * 주문 내역을 초기화하는 생성자입니다.
	 * @param seq 주문 번호
	 * @param menuSeq 메뉴 번호
	 * @param orderDate 주문 날짜
	 * @param customerSeq 고객 번호
	 */
	public Order(String seq, String menuSeq, String orderDate, String customerSeq) {
		this.seq = seq;
		this.menuSeq = menuSeq;
		
		Calendar temp = Calendar.getInstance();
		temp.set(Integer.parseInt(orderDate.split("-")[0]),
					Integer.parseInt(orderDate.split("-")[1]) - 1,
					Integer.parseInt(orderDate.split("-")[2]));
		
		this.orderDate = temp;
		this.customerSeq = customerSeq;
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

	public Calendar getOrderDate() {
		return orderDate;
	}
	
	public String getsOrderDate() {
		String temp = "";
		temp += orderDate.get(Calendar.YEAR);
		temp += "-";
		temp += String.format("%02d",(orderDate.get(Calendar.MONTH) + 1));
		temp += "-";
		temp += String.format("%02d",orderDate.get(Calendar.DATE));
		return temp;
	}

	public void setOrderDate(Calendar orderDate) {
		this.orderDate = orderDate;
	}

	public String getCustomerSeq() {
		return customerSeq;
	}

	public void setCustomerSeq(String customerSeq) {
		this.customerSeq = customerSeq;
	}
	
	@Override
	public String toString() {
		return String.format("Order [seq=%s, menuSeq=%s, orderDate=%s, customerSeq=%s]", seq,
				menuSeq, orderDate, customerSeq);
	}

	
}
