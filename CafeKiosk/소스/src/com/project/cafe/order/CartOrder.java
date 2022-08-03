package com.project.cafe.order;

import java.util.ArrayList;
import java.util.Scanner;
import com.project.cafe.FindData;
import com.project.cafe.Output;
import com.project.cafe.dataClass.Cart;
import com.project.cafe.dataClass.Menu;

/**
 * 장바구니에 담긴 메뉴를 조회, 삭제, 결제할 수 있는 클래스입니다.
 * @author 고민지
 *
 */
public class CartOrder {

	public static ArrayList<Cart> cart;
	private static int cartMaxSize;
	
	/**
	 * @cartMaxSize 카트에 담을 수 있는 최대 메뉴 개수
	 */
	static {
		cart = new ArrayList<Cart>();
		cartMaxSize = 12;
	}
	
	/**
	 * 장바구니에 직접 고른 메뉴를 담는 메소드입니다.
	 * @param menu Cart 객체에 저장된 메뉴
	 * @return 장바구니 담기 성공 여부
	 */
	public static boolean addToCart(Cart menu) {
		if(cart.size() < cartMaxSize) {
			cart.add(menu);
			cart.sort((c1, c2) -> 
						FindData.findMenu(c1.getMenuSeq()).getName()
						.compareTo(FindData.findMenu(c2.getMenuSeq()).getName()));
			return true;
		} else {
			return false;
		}
	}
	

	
	/**
	 * 장바구니 관련 업무의 전체 흐름을 관리하는 메소드입니다.
	 */
	public void main () {
		
		boolean loop = true;
		boolean info = false;
		String input = " ";
		
		while(loop) {
			
			if(cart.size() == 0) {
				printEmptyCart();
				return;
			} 
		
			input = controlCart(input, info);
			
			if(input.equals("0")) { //나가기
				loop = false;
			} else if(input.equals("")) {
				Payment p = new Payment();
				p.main();
				loop = false;
			} 
			
			info = true;
		}
	
 	}

	/**
	 * 장바구니에 담긴 메뉴를 출력하는 메소드 입니다.
	 * @param input 에러 또는 삭제 완료 메시지
	 * @param info 에러 또는 삭제 완료 메시지 출력여부
	 * @return 입력값
	 */
	private String controlCart(String input, boolean info) {
		
		ArrayList<String> pages = loadCartPage();
		int index = 1;
	 
		while(true) {
			
			System.out.print(pages.get(index-1));
			System.out.printf("\t\t\t[%d/%d]\n", index, pages.size());
			System.out.println();
			
			if(info == true) {
				System.out.println(input);
				info = false;
			} else {
				System.out.println();
			}
			System.out.println();
			
			System.out.println("(삭제: 번호 / 결제: Enter / 페이지: < > / 나가기: 0)");
			System.out.println();
			
			Scanner scan = new Scanner(System.in);
			System.out.print("Select ▶ ");
			input = scan.nextLine();
			
			if(input.equals("<")) {
				if(index > 1) {
					index -= 1;						
				} else {
					info = true;
					input = "⚠️ 첫 페이지입니다.";
				}
				
			} else if (input.equals(">")) {
				if(index < pages.size()) {						
					index += 1;
				} else {
					info = true;
					input = "⚠️ 마지막 페이지입니다.";
				}
				
			} else if (input.equals("0")){
				return input;
				
			} else if (checkNum(input)) {
				Cart temp = cart.remove(Integer.parseInt(input)-1);
				input = "⚠️ " + FindData.findMenu(temp.getMenuSeq()).getName() + "을(를) 삭제하였습니다.";
				return input;
				
			} else if (input.equals("")) {
				return input;
				
			} else {
				info = true;
				input = "⚠️ " + input + "은 올바른 입력이 아닙니다.";
			}
	
			
		}
	}

	private boolean checkNum(String input) {
		
		try {
			int seq = Integer.parseInt(input);
			
			if(1 <= seq && seq <= cart.size()) { return true; } 
			return false;
			
		} catch (Exception e) {
			return false;			
		}
		
	}
	
	/**
	 * 장바구니에 담긴 메뉴의 출력화면을 반환하는 메소드입니다.
	 * @return 장바구니에 담긴 메뉴의 출력화면
	 */
	private ArrayList<String> loadCartPage() {
		
		ArrayList<String> page = new ArrayList<String>();
		
		StringBuilder sb = new StringBuilder();
		
		int totalPrice = 0;
		for(Cart c : cart) { totalPrice += c.getTotalPrice(); }
		
		for(int i=0; i<cart.size(); i++) {
			
			if(i == 0 || i % 4 == 0) {
				sb.append("┌───────────────────────────────────────────────────┐\n");
				sb.append("\t\t\t장바구니\n");
				sb.append("\n");
			}
				
			
			Cart m = cart.get(i);
			
			Menu menu = FindData.findMenu(m.getMenuSeq());
			
			sb.append(String.format(" %d.", i+1));
			
			String cName = FindData.findCategoryName(menu.getCseq());
			switch(cName) {
				case "커피"	: sb.append("[☕] "); break;
				case "음료"	: sb.append("[🥤] "); break;
				case "티"	: sb.append("[🍵] "); break;
				case "에이드"	: sb.append("[🍹] "); break;
				case "스무디" : sb.append("[🍧] "); ;break;
			}
			sb.append(String.format("%s\n", menu.getName()));
			sb.append(String.format("\t- %s/%s/%s/%s/%s\t\t\n"
									+ "\t\t\t\t\t … %,d원\n"
									, FindData.findIce(m.getIceSeq()).getName()
									, FindData.findSyrup(m.getSyrupSeq()).getName()
									, FindData.findShot(m.getShotSeq()).getName()
									, FindData.findWhipping(m.getWhippingSeq()).getName()
									, FindData.findTopping(m.getToppingSeq()).getName()
									, m.getTotalPrice()));

			if(i % 4 == 3 || i == cart.size()-1) {
			
				if(i % 4 != 3) {
					for(int k=4*(cart.size()/4+1); k>cart.size(); k--) { 
						sb.append("\n\n\n\n\n"); 
					}
				}
				
				sb.append("\n");
				sb.append(String.format("\t\t\t\t    총가격: %,d원\n", totalPrice)); 
				sb.append("\n└───────────────────────────────────────────────────┘\n");				
				
				page.add(sb.toString());
				sb = new StringBuilder();
				
			} else {
				sb.append(" ───────────────────────────────────────────────────\n");
				sb.append("\n");
			}
			
		}
	
		return page;
		
	}
	
	/**
	 * 장바구니에 담긴 메뉴가 없을 때의 화면을 출력하는 메소드 입니다.
	 */
	private void printEmptyCart() {

		Output.toolStart();
		System.out.println("\r\n"
				+ "                                 \r\n"
				+ "                                 \r\n"
				+ "\t\t                 _               \r\n"
				+ "\t\t   ___ __ _ _ __| |_             \r\n"
				+ "\t\t  / __/ _` | '__| __|            \r\n"
				+ "\t\t | (_| (_| | |  | |_             \r\n"
				+ "\t\t  \\___\\__,_|_|   \\__|            \r\n"
				+ "\t\t     _                             \r\n"
				+ "\t\t    (_)___                         \r\n"
				+ "\t\t    | / __|                        \r\n"
				+ "\t\t    | \\__ \\                        \r\n"
				+ "\t\t    |_|___/    _         \r\n"
				+ "\t   ___ _ __ ___  _ __ | |_ _   _ \r\n"
				+ "\t  / _ \\ '_ ` _ \\| '_ \\| __| | | |\r\n"
				+ "\t |  __/ | | | | | |_) | |_| |_| |\r\n"
				+ "\t  \\___|_| |_| |_| .__/ \\__|\\__, |\r\n"
				+ "\t                |_|        |___/ \r\n"
				+ "");
		for(int i=0; i<3; i++) {System.out.println();} 
		System.out.println();
		System.out.println("\t   ⚠️ 장바구니 목록이 존재하지 않습니다.");
		for(int i=0; i<3; i++) System.out.println();
		Output.toolEnd();
		Output.pause();
	}


//	private void dummyCart() {
//		
//		Random r = new Random();
//		int j = (int)r.nextInt(12) + 1;
//		
//		for(int i=1; i<=j; i++) { 
//			
//			if(Data.mlist.size() > 0 && Data.icelist.size() > 0 &&
//					Data.srlist.size() > 0 && Data.shotlist.size() > 0 &&
//					Data.wlist.size() > 0 && Data.tlist.size() > 0 ) {
//				
//				String seq = String.valueOf(i); 
//				String menuSeq 	= Data.mlist.get((int)r.nextInt(Data.mlist.size())).getSeq();
//				String iceSeq	= Data.icelist.get((int)r.nextInt(Data.icelist.size())).getSeq();
//				String syrupSeq = Data.srlist.get((int)r.nextInt(Data.srlist.size())).getSeq();
//				String shotSeq 	= Data.shotlist.get((int)r.nextInt(Data.shotlist.size())).getSeq();
//				String whippingSeq 	= Data.wlist.get((int)r.nextInt(Data.wlist.size())).getSeq();
//				String toppingSeq	= Data.tlist.get((int)r.nextInt(Data.tlist.size())).getSeq();
//				
//				Cart c = new Cart(seq, menuSeq, iceSeq, syrupSeq, shotSeq, whippingSeq, toppingSeq);
//				addToCart(c);
//				
//			}
//		}		
//		
//	}
}

