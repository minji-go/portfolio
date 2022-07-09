package com.project.cafe.admin;

import java.util.Scanner;

import com.project.cafe.Data;
import com.project.cafe.DataPath;
import com.project.cafe.Main;
import com.project.cafe.MenuCategory;
import com.project.cafe.dataClass.Menu;
/**
 * 관리자가 품절된 음료를 품절 상태로 변환하고 판매하는 상품을 판매 상태로 변환하는 클래스입니다. 
 * @author 고수경
 *
 */
public class SoldoutMenu {
	
	/*
	
		품절 관리
		1. 메뉴 카테고리에서 선택해서 품절 상태 바꾼다
		2. 품절로 바꾼 상품은, 주문할 때 아이스아메리카노(품절) 다음과 같이 출력되게 하거나 아예 품절된 상품이 출력되지 않도록 한다. 
		3. 사용자가 주문할 때, string 함수 중 contains 로 '(품절)' 포함된 메뉴 선택시 장바구니에 들어가지 않고 품절된 상품이라고 경고문 출력하게 하기..
		4. 품절/판매 중 변하게 하는 방법-> txt 파일에서 해당 메뉴의 이름을 찾아 메뉴 이름 변경시킨다. ex) 아이스 아메리카노 -> 아이스 아메리카노(품절)
																			 	ex) 아이스 아메리카노(품절) -> 아이스 아메리카노
	
	
	
	*/
	public void main(){
		printCategory();

	}
	
	
	/**
	 * 카테고리 종류 출력하고 카테고리 번호 입력 받는 메소드입니다.
	 */
	private static void printCategory(){
		Scanner scan = new Scanner(System.in);
		boolean error = false;
		boolean loop = true;
		

		while (loop) {
			MenuCategory.printStart();
			System.out.println("\n\t\t[*** 품절 관리 화면 ***]    ");

			MenuCategory.startCategory();

			if (error) {
				System.out.println(MenuCategory.chosenCategory);
				error = false;
			}

			System.out.print("Select▶");
			MenuCategory.chosenCategory = scan.nextLine();
			boolean flag = true;
			switch (MenuCategory.chosenCategory) {
		
			case "1":
				while(flag) {
					MenuCategory.basicCoffee();
					flag = selectSoldout(scan, flag);
				}
				break;
			case "2":
				while(flag) {
					MenuCategory.basicBeverage();
					flag = selectSoldout(scan, flag);
				}
				break;
			case "3":
				while(flag) {
					MenuCategory.basicTea();
					flag = selectSoldout(scan, flag);
				}
				break;
			case "4":
				while(flag) {
					MenuCategory.basicAde();
					flag = selectSoldout(scan, flag);
				}
				break;
			case "5":
				while(flag) {
					MenuCategory.basicSmoothe();
					flag = selectSoldout(scan, flag);
				}
				break;
			case "0":
				loop=false;
			default:
				MenuCategory.chosenCategory = "⚠️ " + MenuCategory.chosenCategory + "은(는) 잘못된 접근입니다.";
				error = true;
			}

		}

	}


	public static boolean selectSoldout(Scanner scan, boolean flag) {
		System.out.println("\n1: '품절'상태로 변환 작업  2: '판매 중'상태로 변환 작업  0: 상위 메뉴\n");
		System.out.print("Select▶");
		String num = scan.nextLine();
		if(num.equals("1")) {
			System.out.print("품절로 바꿀 상품 선택▶ ");
			num = scan.nextLine();
			
			String menuResult = findMenu(MenuCategory.chosenCategory, num);
			for (Menu m : Data.mlist) {
				if (menuResult.equals(m.getSeq())) {
					m.setName(m.getName() + "(품절)");
					Data.save(DataPath.메뉴);
					
				}
			}
		}else if(num.equals("2")) {
			System.out.print("'판매 중'으로 바꿀 상품 선택▶ ");
			num = scan.nextLine();
			
			String menuResult = findMenu(MenuCategory.chosenCategory, num);
			for (Menu m : Data.mlist) {
				if (menuResult.equals(m.getSeq())) {
					int index = m.getName().lastIndexOf("(");
					String mname = m.getName().substring(0, index);
					m.setName(mname);
					Data.save(DataPath.메뉴);
					
				}
			}
		}else if(num.equals("0")) {
			flag = false;
		}
		else {
			System.out.println("⚠️ " + num + "은(는) 잘못된 접근입니다.");
			flag = true;
		}
		return flag;
	}
	

	
	private static String findMenu(String category, String menu) {
		

		int temp = 0;
		
		for (int i=0 ; i<Data.mlist.size() ; i++) {
			if (Data.mlist.get(i).getCseq().equals(category)) {
				temp = i;
				break;
			}
		}
		
		System.out.println(temp);
		String menuResult = String.valueOf(temp + Integer.parseInt(menu)); 
		
		return menuResult;
	}
	

	
	


}
