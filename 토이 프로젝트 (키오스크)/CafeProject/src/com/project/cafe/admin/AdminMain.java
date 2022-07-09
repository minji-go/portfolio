package com.project.cafe.admin;

import java.util.Calendar;
import java.util.Scanner;
import com.project.cafe.Main;
import com.project.cafe.Output;
import com.project.cafe.order.CartOrder;

/**
 * 관리자 모드 진입시 화면을 구현한 클래스입니다.
 * @author 고민지
 *
 */
public class AdminMain {

	/**
	 * 관리자 모드의 전체 흐름을 통제하는 메소드입니다.
	 */
	public void main() {
		
		String input = null; 
		boolean error = false;
		boolean loop = true;
		
		while(loop) {
			
			printMenu();
			
			Scanner scan = new Scanner(System.in);
			System.out.println();
			
			if(error) {
				System.out.println(input);
				error = false;
			} else {
				System.out.println();
			}
			
			System.out.print("Select ▶ ");

			input = scan.nextLine();
		
			
		
			if(input.equals("1")) {
				
				SetMenu m = new SetMenu();
				m.main();
				
			} else if (input.equals("2")) {
				
				SoldoutMenu o = new SoldoutMenu();
				o.main();
				
			} else if (input.equals("3")) { 
				
				SalesStats s = new SalesStats();
				s.main();
				
			} else if (input.equals("4")) { 
				
				String beforePW = Main.adminPW;
				
				ResetPW r = new ResetPW();
				r.work();
				
				if(!beforePW.equals(Main.adminPW)) {
					loop = false;
				}
			
			} else if (input.equals("0")) {
			
				loop = false; //메인화면으로
			} else {
				input = "⚠️ " + input + "은(는) 잘못된 접근입니다.";
				error = true;
			}
				
		}
	}
	
	
	/**
	 * 관리자 모드의 메인 화면을 출력하는 메소드입니다.
	 */
	private static void printMenu() {
		
		Output.toolStart();
		
		Calendar now = Calendar.getInstance();
		System.out.print("\t\t\t");
		System.out.printf("     %tF %s:%s %tA\n", 
							now, now.get(Calendar.HOUR_OF_DAY),now.get(Calendar.MINUTE), now);
		System.out.println();
		System.out.println();
		
		System.out.println("     ______         __                __           \r\n"
				+ "    /      \\       /  |              /  |          \r\n"
				+ "   /$$$$$$  |  ____$$ | _____  ____  $$/  _______  \r\n"
				+ "   $$ |__$$ | /    $$ |/     \\/    \\ /  |/       \\ \r\n"
				+ "   $$    $$ |/$$$$$$$ |$$$$$$ $$$$  |$$ |$$$$$$$  |\r\n"
				+ "   $$$$$$$$ |$$ |  $$ |$$ | $$ | $$ |$$ |$$ |  $$ |\r\n"
				+ "   $$ |  $$ |$$ \\__$$ |$$ | $$ | $$ |$$ |$$ |  $$ |\r\n"
				+ "   $$ |  $$ |$$    $$ |$$ | $$ | $$ |$$ |$$ |  $$ |\r\n"
				+ "   $$/   $$/  $$$$$$$/ $$/  $$/  $$/ $$/ $$/   $$/");
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println("\t\t1. 메뉴 관리 (Menu)");
		System.out.println();
		System.out.println("\t\t2. 품절 관리 (Soldout)");
		System.out.println();
		System.out.println("\t\t3. 판매 통계 (Statistic)");
		System.out.println();
		System.out.println("\t\t4. 암호 변경 (🔒 Password)");
		System.out.println();
		System.out.println("\t\t0. 메인 화면");
		System.out.println();
		Output.toolEnd();
		System.out.println();
	}

}
