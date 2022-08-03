package com.project.cafe.dataClass;

/**
 * 고객별 적립 내역을 저장하는 클래스입니다.
 * @author 김승연
 *
 */
public class Stamp {

	//적립번호,고객번호,적립개수
	//1,1,23
	
	private String seq;
	private String cumstomerSeq;
	private String stamp;
	
	/**
	 * 
	 * 고객별 적립 내역을 초기화하는 생성자입니다.
	 * @param seq 적립 번호
	 * @param cumstomerSeq 고객 번호
	 * @param stamp 적립 개수
	 */
	public Stamp(String seq, String cumstomerSeq, String stamp) {
		super();
		this.seq = seq;
		this.cumstomerSeq = cumstomerSeq;
		this.stamp = stamp;
	}


	public String getSeq() {
		return seq;
	}


	public void setSeq(String seq) {
		this.seq = seq;
	}


	public String getCumstomerSeq() {
		return cumstomerSeq;
	}


	public void setCumstomerSeq(String cumstomerSeq) {
		this.cumstomerSeq = cumstomerSeq;
	}


	public String getStamp() {
		return stamp;
	}


	public void setStamp(String stamp) {
		this.stamp = stamp;
	}


	@Override
	public String toString() {
		return String.format("stamp [seq=%s, cumstomerSeq=%s, stamp=%s]", seq, cumstomerSeq, stamp);
	}
	
	
}
