package com.project.cafe.admin;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.Calendar;
import java.util.Scanner;
import com.project.cafe.Main;
import com.project.cafe.Output;

/**
 * 
 * 관리자 비밀번호를 확인하고 재설정하는 클래스입니다.
 * @author 김승연
 *
 */
public class ResetPW {

	/**
	 * public 메인 메소드입니다.
	 */
	public static void work() {

		checkPW();
		
	}
	
	/**
	 * 사용자에게 현재 관리자 비밀번호를 확인받는 메소드입니다.
	 */
	private static void checkPW() {
		
		boolean loop = true;
		while (loop) {

			printLetter();
			System.out.println("\r\n");
			System.out.println("   -----------------------------------------------\r\n\r\n");
			System.out.println("\t       현재 비밀번호를 확인합니다.");
			System.out.println("\t     초기 비밀번호는 <#admin>입니다.\r\n");
			System.out.println("\t        [0] 상위 메뉴로 돌아가기");
			System.out.println("\r\n\r\n");
			Output.toolEnd();
			
			Scanner scan = new Scanner(System.in);
			System.out.print("현재(변경 전) Password를 입력해 주세요. : #");
			String input = scan.nextLine();
			
			if (input.equals(Main.adminPW)) {
				
				changePW();
				loop = false;
				
			} else if (input.equals("0")) {
				
				loop = false;
				
			} else {
				
				System.out.print("잘못된 비밀번호입니다. 다시 시도해 주세요. ([Enter]: 계속)");
				scan.nextLine();
			}
		}
	}

	/**
	 * 새로운 관리자 비밀번호를 입력받은 후 비밀번호를 변경하는 메소드입니다.
	 */
	private static void changePW() {

		boolean loop = true;
		boolean subLoop = true;
		
		try {
			
			while (loop) {
				printLetter();
				System.out.println();
				System.out.println("   -----------------------------------------------\r\n\r\n");
				System.out.println("\t       변경할 비밀번호를 입력합니다.");
				System.out.println("\t   비밀번호는 숫자 4자리 설정만 가능하며,");
				System.out.println("\t  이전 비밀번호와 똑같이 설정할 수 없습니다.\r\n");
				System.out.println("\t        [0] 상위 메뉴로 돌아가기");
				System.out.println("\r\n\r\n");
				Output.toolEnd();
				
				Scanner scan = new Scanner(System.in);
				System.out.print("새로운 Password를 입력해 주세요. : #");
				String input = scan.nextLine();
				
				if (input.equals("0")) {
					
					loop = false;
					
				} else if (verifyNewPW(Main.adminPW, input)) {
					while (subLoop) {
						System.out.printf("비밀번호를 변경하시겠습니까? (Y/N): ");
						String answer = scan.nextLine();
						
						if (answer.equals("y") || answer.equals("Y")) {
							
							BufferedWriter writer = new BufferedWriter(new FileWriter("src\\com\\project\\cafe\\data\\관리자.txt"));
							writer.write(input);
							writer.close();
							
							Main.adminPW = input;
							
							
							printLetter();
							System.out.println();
							System.out.println("   -----------------------------------------------\r\n\r\n\r\n");
							System.out.printf("\t         변경된 비밀번호: %s\r\n", Main.adminPW);
							System.out.println();
							System.out.println("\t        [0] 상위 메뉴로 돌아가기");
							System.out.println("\r\n\r\n");
							Output.toolEnd();
							
							System.out.printf("비밀번호가 %s으로 변경되었습니다. ([Enter]: 계속)\r\n", Main.adminPW);
							scan.nextLine();
							loop = false;
							subLoop = false;
							
							
						} else if (answer.equals("n") || answer.equals("N")) {
							
							System.out.print("취소되었습니다. 상위 메뉴로 돌아갑니다. ([Enter]: 계속)");
							scan.nextLine();
							loop = false;
							subLoop = false;
	
						} else {
							
							System.out.print("Y 혹은 N 중 하나의 값을 선택해 주세요. ([Enter]: 계속)");
						}
					}
					
				} else {
					
					System.out.print("조건에 맞지 않는 비밀번호입니다. 다시 시도해 주세요. ([Enter]: 계속)");
					scan.nextLine();
					
				}
			}
			
		} catch (Exception e) {
			System.out.println("ResetPW.changePW");
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 사용자에게 입력받은 새로운 비밀번호의 유효성 검사를 하는 메소드입니다.
	 * @param oldPW 기존비밀번호
	 * @param newPW 새비밀번호
	 * @return true|false값
	 */
	private static boolean verifyNewPW(String oldPW, String newPW) {
		
		try {
			if (Integer.parseInt(newPW) >= 0 && Integer.parseInt(newPW) <= 9999
											&& newPW.length() == 4
											&& !oldPW.equals(newPW)) {	
				return true;
			}
		} catch (Exception e) {
			return false;
		}
		
		return false;
		
	}

	
	/**
	 * 암호 변경 카테고리의 화면 구현에 공통으로 사용되는 문자들을 출력하는 메소드입니다.
	 */
	private static void printLetter() {
		
		System.out.println("┌───────────────────────────────────────────────────┐");
		
		Calendar now = Calendar.getInstance();
		System.out.print("\t\t\t");
		System.out.printf("%tF %s:%s %tA [*.종료]\n", 
							now, now.get(Calendar.HOUR_OF_DAY),now.get(Calendar.MINUTE), now);
		
		System.out.println();
		System.out.println();
		System.out.println("                                  __      \r\n"
				+ "                                 /\\ \\__   \r\n"
				+ "   _ __     __     ____     __   \\ \\ ,_\\  \r\n"
				+ "  /\\`'__\\ /'__`\\  /',__\\  /'__`\\  \\ \\ \\/  \r\n"
				+ "  \\ \\ \\/ /\\  __/ /\\__, `\\/\\  __/   \\ \\ \\_ \r\n"
				+ "   \\ \\_\\ \\ \\____\\\\/\\____/\\ \\____\\   \\ \\__\\\r\n"
				+ "    \\/_/  \\/____/ \\/___/  \\/____/    \\/__/");
		
		System.out.println("                             ____     __      __    \r\n"
				+ "                            /\\  _`\\  /\\ \\  __/\\ \\   \r\n"
				+ "                            \\ \\ \\L\\ \\\\ \\ \\/\\ \\ \\ \\  \r\n"
				+ "                             \\ \\ ,__/ \\ \\ \\ \\ \\ \\ \\ \r\n"
				+ "                              \\ \\ \\/   \\ \\ \\_/ \\_\\ \\\r\n"
				+ "                               \\ \\_\\    \\ `\\___x___/\r\n"
				+ "                                \\/_/     '\\/__//__/ ");
	
		
	} 
}
