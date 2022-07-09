package com.project.cafe.order;

import java.util.ArrayList;
import java.util.Scanner;
import com.project.cafe.Data;
import com.project.cafe.FindData;
import com.project.cafe.Main;
import com.project.cafe.MenuCategory;
import com.project.cafe.Output;
import com.project.cafe.dataClass.Cart;
import com.project.cafe.dataClass.CustomMenu;

/**
 * 사용자 기능 중 빠른 주문 기능을 구현한 클래스입니다.
 * @author 김승연
 *
 */
public class FastOrder extends Payment {

	public static ArrayList<CustomMenu> currentCmlist;
	public static Cart currentCm;
	
	public FastOrder() {
		currentCmlist = new ArrayList<CustomMenu>();
		currentCm = new Cart(null, "0", "2", "0", "0", "0", "0");
	}
		
	
	/**
	 * public 메인 메소드입니다. 빠른 주문을 위해 휴대폰 번호로 로그인 기능을 구현한 메소드입니다.
	 */
	public static void work() {
		
		boolean loop = true;
		
		while (loop) {
			
			Scanner scan = new Scanner(System.in);
			
			
			if (Main.currentLogin == null) {
				
				printLetter();
				System.out.println("\r\n\r\n\r\n\r\n\r\n\r\n");
				Output.toolEnd();
				System.out.print("\r\n휴대폰 번호를 입력해 주세요. (010-XXXX-XXXX) : ");
				String input = scan.nextLine();
				
				if (Main.customerLogin(input)) {					
					
					loadCustomMenu();
					loop = false;
					
				} else {
					
					System.out.println("잘못된 휴대폰 번호 형식입니다. 다시 확인해 주세요. ([Enter]: 계속)");
					scan.nextLine();
				}
				
			} else {
				
				loadCustomMenu();
				loop = false;
			}
			
			
		}
	}
	
	/**
	 * cmlist(커스텀메뉴 arraylist)에서 currenetLogin에 저장된 고객의 커스텀 메뉴를 검색, 불러오는 메소드입니다.
	 */
	private static void loadCustomMenu() {
	// test용 고객 -> 4번 (010-5245-5223)

		boolean loop = true;
		
		while(loop) {
			printLetter();
			
			int index = 1;
			for (int i=0 ; i<Data.cmlist.size() ; i++) {
				
				if (i == 0) {
					System.out.printf("\r\n         [%s] 님의 커스텀 메뉴 LIST", Main.currentLogin.getTel());
					System.out.println("\r\n");
				}
				
				if (Data.cmlist.get(i).getClientSeq().equals(Main.currentLogin.getSeq())) {
					
					int price = getCmPrice(Data.cmlist.get(i));
					System.out.printf("     [%d] %s (%d원)\r\n\t▶ %s/%s/%s/%s/%s\r\n\r\n"
											, index 
											, FindData.findMenu(Data.cmlist.get(i).getMenuSeq()).getName()
											, price
											, FindData.findIce(Data.cmlist.get(i).getIceSeq()).getName()
											, FindData.findSyrup(Data.cmlist.get(i).getSyrupSeq()).getName()
											, FindData.findShot(Data.cmlist.get(i).getShotSeq()).getName()
											, FindData.findWhipping(Data.cmlist.get(i).getWhippingSeq()).getName()
											, FindData.findTopping(Data.cmlist.get(i).getToppingSeq()).getName());
					
					currentCmlist.add(Data.cmlist.get(i));
					index++;
					
				}
				
				if (i == Data.cmlist.size() - 1) {
					if (currentCmlist.size() == 0) {
						System.out.println("\r\n\r\n\r\n\r\n\r\n\t\t등록된 커스텀 메뉴가 없습니다.\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");
					
					} else {
					
						for (int j=currentCmlist.size() ; j<5 ; j++) {
							System.out.println();
							System.out.println();
							System.out.println();
						}
					}
					System.out.println("   [0]: 상위 메뉴로 돌아가기 | [#]: 다른 번호로 로그인하기");
				}
			}
			
			Output.toolEnd();
			
			

			Scanner scan = new Scanner(System.in);
			
			if (currentCmlist.size() != 0) {
				System.out.print("주문하실 음료를 선택해 주세요. : ");
			} else {
				System.out.print("[0] 혹은 [#] 선택을 입력해 주세요. : ");
			}
			String input = scan.nextLine();
			
			try {
				
				if (input.equals("#")) {
				
					Main.currentLogin = null;
					work();
					loop = false;
				
					
				} else if (Integer.parseInt(input) > 0 && Integer.parseInt(input) <= currentCmlist.size()) {
					
					addToCartCmMenu(Integer.parseInt(input));
					loop = false;
					
				} else if (input.equals("0")) {
					
					loop = false;
					
				} else {
					
					System.out.println("올바른 번호를 입력해 주세요. ([Enter]: 계속)");
					scan.nextLine();
				}
				
			} catch (Exception e) {
				System.out.println("올바른 번호를 입력해 주세요. ([Enter]: 계속)");
				scan.nextLine();
			}

		}
	
}
	
	/**
	 * loadCustomMenu()에서 사용자에게 입력받은 커스텀메뉴를 CartOrder.addToCart와 연결, 장바구니에 추가하는 메소드입니다.
	 * @param input 커스텀메뉴번호(currentCmlist)
	 */
	private static void addToCartCmMenu(int input) {
	// 사용자에게 currentCmlist 번호 입력받은 후 (currnetCmlist.get(사용자input-1) 정보를 getter로 빼내
	// currentCm 카트 객체에 대입, CartOrder.addToCart와 연결
	//cart(장바구니번호, 메뉴번호, 얼음량옵션번호, 시럽옵션번호, 샷추가옵션번호, 휘핑크림옵션번호, 토핑추가옵션번호)
	
		Scanner scan = new Scanner(System.in);
		
		currentCm.setSeq(NormalOrder.findMaxSeq_cart());
		currentCm.setMenuSeq(currentCmlist.get(input-1).getMenuSeq());
		currentCm.setIceSeq(currentCmlist.get(input-1).getIceSeq());
		currentCm.setSyrupSeq(currentCmlist.get(input-1).getSyrupSeq());
		currentCm.setShotSeq(currentCmlist.get(input-1).getShotSeq());
		currentCm.setWhippingSeq(currentCmlist.get(input-1).getWhippingSeq());
		currentCm.setToppingSeq(currentCmlist.get(input-1).getToppingSeq());
	
		if (CartOrder.addToCart(currentCm)) {
			System.out.printf("[%s](이)가 장바구니에 저장되었습니다. ([Enter]: 초기화면)\r\n", FindData.findMenu(currentCm.getMenuSeq()).getName());
			scan.nextLine();
			
		} else {
			System.out.printf("장바구니가 가득 찼습니다. ([Enter]: 초기화면)");
			scan.nextLine();
		};
		
	}






	/**
	 * 커스텀메뉴 목록 출력을 위해 커스텀된 메뉴의 옵션에 따른 가격을 계산하는 메소드입니다. 
	 * @param customMenu 커스텀메뉴
	 * @return 메뉴가격
	 */
	private static int getCmPrice(CustomMenu customMenu) {

		int price = 0;
		price = FindData.findMenu(customMenu.getMenuSeq()).getPrice()
				+ FindData.findIce(customMenu.getIceSeq()).getPrice()
				+ FindData.findSyrup(customMenu.getSyrupSeq()).getPrice()
				+ FindData.findShot(customMenu.getShotSeq()).getPrice()
				+ FindData.findWhipping(customMenu.getWhippingSeq()).getPrice()
				+ FindData.findTopping(customMenu.getToppingSeq()).getPrice();
		
		return price;
	}


	
	/**
	 * 빠른 주문 카테고리의 화면 구현에 공통으로 사용되는 문자들을 출력하는 메소드입니다.
	 */
	private static void printLetter() {
		
		MenuCategory.printStart();
		System.out.println();
		System.out.println("     ___             _     ___         _           \r\n"
				+ "    | __> ___  ___ _| |_  | . | _ _  _| | ___  _ _ \r\n"
				+ "    | _> <_> |<_-<  | |   | | || '_>/ . |/ ._>| '_>\r\n"
				+ "    |_|  <___|/__/  |_|   `___'|_|  \\___|\\___.|_|  \r\n");
		
		String loginId = "";
		
		if (Main.currentLogin == null) {
			loginId = "로그인 정보가 없습니다.";
			
		} else {
			
			loginId = Main.currentLogin.getTel();
		}
		
		
		System.out.printf("\r\n\t      [LOGIN] %s", loginId);
		System.out.println("\r\n   •·············································•");
		
		
		if (Main.currentLogin == null) {
			
			System.out.println("\r\n\r\n\r\n\r\n\r\n\t\t커스텀 메뉴를 조회하시려면\r\n\t\t  로그인을 시도해 주세요.\r\n\r\n\r\n\r\n");
		}
	}
	
}
