package com.project.cafe.dataClass;

public class Option {

	private String seq;
	private String name;
	private int price;
	
	public Option(String seq, String name, int price) {
		this.seq = seq;
		this.name = name;
		this.price = price;
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

	@Override
	public String toString() {
		return String.format("Option [seq=%s, name=%s, price=%s]", seq, name, price);
	}
	
	
	
	
	
}
