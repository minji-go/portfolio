package com.project.cafe.admin;

import java.util.Calendar;
import java.util.Scanner;
import com.project.cafe.Data;
import com.project.cafe.FindData;
import com.project.cafe.MenuCategory;
import com.project.cafe.Output;
import com.project.cafe.dataClass.Menu;

/**
 * 관리자 모드의 판매 통계 기능을 구현한 클래스입니다. 일주일 단위로 기간을 선택받고 카테고리별 판매 개수를 출력합니다.
 * @author 김승연
 *
 */
public class SalesStats {
	
	public static String inputDate;
	public static String inputCate;
	public static Calendar[] dateList = new Calendar[8];
	public static Calendar startDate;
	public static Calendar endDate;
	

	/**
	 * public 메인 메소드입니다.
	 */
	public static void main() {
		
		chooseStatsDate();


	}

	/**
	 * 지금으로부터 가장 가까운 지나간 일요일을 찾고, 일주일 단위(월요일~일요일)로 4주의 기간을 나누어 출력 후 사용자에게 선택받는 메소드입니다. 
	 */
	private static void chooseStatsDate() {

		boolean loop = true;
		
		while (loop) {
			
			MenuCategory.printStart();
			System.out.println();
			
			printLetter();
			
			System.out.println();
			Calendar now = Calendar.getInstance();
			System.out.printf("\r\n\t    오늘은 %d년 %d월 %d일 %s요일입니다.\r\n\r\n"
								, now.get(Calendar.YEAR)
								, now.get(Calendar.MONTH) + 1
								, now.get(Calendar.DAY_OF_MONTH)
								, getDayOfWeek(now.get(Calendar.DAY_OF_WEEK)));
			System.out.println("\t\t[#] 상위 메뉴로 이동");
			System.out.println();
			
			System.out.println("  •·············································•");
			
			
			//Calendar now를 현재와 가장 가까운 과거의 일요일로 설정하기 (오늘 제외 = do while문)
			do {
				now.add(Calendar.DATE, -1);
			} while (now.get(Calendar.DAY_OF_WEEK) != 1);
			
			System.out.println();
			System.out.println("\t\t<판매 통계 조회 기간 선택>\r\n");
			
			for (int i=7 ; i>=0 ; i--) {
				dateList[i] = Calendar.getInstance();
				
				if (i == 7) {
					dateList[i].set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DATE));
				
				} else if (i % 2 == 0) {
					dateList[i].set(dateList[i+1].get(Calendar.YEAR), dateList[i+1].get(Calendar.MONTH), dateList[i+1].get(Calendar.DATE));
					dateList[i].add(Calendar.DATE, -6);
					
				} else {
					dateList[i].set(dateList[i+1].get(Calendar.YEAR), dateList[i+1].get(Calendar.MONTH), dateList[i+1].get(Calendar.DATE));
					dateList[i].add(Calendar.DATE, -1);
				}
			}
			
	
			int index = 1;
			for (int i=0 ; i<7 ; i+=2) {
				
				System.out.printf("      [%d] %tF(%tA) ~ %tF(%tA)\r\n\r\n"
										, index, dateList[i], dateList[i], dateList[i+1], dateList[i+1]);
				index++;
			}
			
			System.out.println();
			Output.toolEnd();

			Scanner scan = new Scanner(System.in);
			System.out.print("\r\n통계 결과를 조회할 기간을 선택해 주세요. : ");
			inputDate = scan.nextLine();
			
			startDate = Calendar.getInstance();
			endDate = Calendar.getInstance(); 

			if (inputDate.equals("1") || inputDate.equals("2") ||
				inputDate.equals("2") || inputDate.equals("4")) {
				
				
				if (inputDate.equals("1")) {
					startDate.set(dateList[0].get(Calendar.YEAR), dateList[0].get(Calendar.MONTH), dateList[0].get(Calendar.DATE), 0, 0, 0);
					endDate.set(dateList[1].get(Calendar.YEAR), dateList[1].get(Calendar.MONTH), dateList[1].get(Calendar.DATE), 23, 59, 59);
					
				} else if (inputDate.equals("2")) {
					startDate.set(dateList[2].get(Calendar.YEAR), dateList[2].get(Calendar.MONTH), dateList[2].get(Calendar.DATE), 0, 0, 0);
					endDate.set(dateList[3].get(Calendar.YEAR), dateList[3].get(Calendar.MONTH), dateList[3].get(Calendar.DATE), 23, 59, 59);
				
				} else if (inputDate.equals("3")) {
					startDate.set(dateList[4].get(Calendar.YEAR), dateList[4].get(Calendar.MONTH), dateList[4].get(Calendar.DATE), 0, 0, 0);
					endDate.set(dateList[5].get(Calendar.YEAR), dateList[5].get(Calendar.MONTH), dateList[5].get(Calendar.DATE), 23, 59, 59);
					
				} else {
					startDate.set(dateList[6].get(Calendar.YEAR), dateList[6].get(Calendar.MONTH), dateList[6].get(Calendar.DATE), 0, 0, 0);
					endDate.set(dateList[7].get(Calendar.YEAR), dateList[7].get(Calendar.MONTH), dateList[7].get(Calendar.DATE), 23, 59, 59);
				}
				
				chooseStatsCate();
			
			} else if (inputDate.equals("#")) {
				
				loop = false;
				
			} else {
				
				System.out.println("올바른 번호를 선택해 주세요. (1~4)");
				scan.nextLine();
			}
		}
	}

	/**
	 * 숫자값에 따라 요일 이름을 반환하는 메소드입니다.
	 * @param i 숫자
	 * @return 요일
	 */
	private static String getDayOfWeek(int i) {
		
		switch (i) {
			case 1: return "일";
			case 2: return "월";
			case 3: return "화";
			case 4: return "수";
			case 5: return "목";
			case 6: return "금";
			case 7: return "토";
		}
		
		return null;
		
	}

	
	/**
	 * 사용자에게 판매 통계를 조회할 음료 카테고리를 선택받는 메소드입니다. 
	 */
	private static void chooseStatsCate() {

	boolean loop = true;
	
	while (loop) {
		MenuCategory.printStart();
		System.out.println();
		System.out.println();
		printLetter();
		System.out.println();
		System.out.printf("\t     %tF ~ %tF", startDate, endDate);
		System.out.println("\r\n\t    카테고리 별로 판매 통계를 조회합니다.");
		System.out.println();
		System.out.println("   •·············································•");
		System.out.println();
		System.out.println("\t\t    1. 커피" + "\n\n\t\t    2. 음료" + "\n\n\t\t    3. 티" + "\n\n\t\t    4. 에이드" + "\n\n\t\t    5. 스무디");
		System.out.println();
		System.out.println();

		Output.toolEnd();
		
		Scanner scan = new Scanner(System.in);
		System.out.print("\r\n통계 결과를 조회할 카테고리를 선택해 주세요. : ");
		inputCate = scan.nextLine();
		
		if (inputCate.equals("1") || inputCate.equals("2") ||
				inputCate.equals("3") || inputCate.equals("4") || inputCate.equals("5")) {
				
			printStats();
			loop = false;
			
		} else {
				
			System.out.println("올바른 번호를 선택해 주세요. (1~5)");
			scan.nextLine();
		}
	}	
}

	/**
	 * 앞서 입력받은 기간, 카테고리를 바탕으로 판매 통계를 출력하는 메소드입니다.
	 */
	private static void printStats() {
		

		MenuCategory.printStart();
		System.out.println();
		printLetter();
		System.out.println();
		System.out.printf("\t       %tF ~ %tF", startDate, endDate);
		System.out.printf("\r\n\t  [%s] 카테고리의 판매 통계를 조회합니다.\r\n", FindData.findCategoryName(inputCate));
		System.out.println("\t     [ENTER] 조회 기간 선택으로 이동");
		System.out.println();
		System.out.println("   •·············································•");
		System.out.println();
	
		int cnt = 0;
		long total = 0;
		String name = "";
		
		if (inputCate.equals("4") || inputCate.equals("5")) {
			System.out.println("\r\n\r\n\r\n"); 
		} else if (inputCate.equals("2")) {
			System.out.println();
		}
	
		
		for (Menu m : Data.mlist) {

			if (m.getCseq().equals(inputCate)) {
				cnt++;
				name = m.getName();
				
				total = Data.olist.stream().filter(order -> order.getMenuSeq().equals(m.getSeq()))
						   .filter(order -> order.getOrderDate().getTimeInMillis() >= startDate.getTimeInMillis()
							&& order.getOrderDate().getTimeInMillis() <= endDate.getTimeInMillis())
						   .count();
				
				if (cnt % 2 == 0) {
										
					System.out.printf("\t%d. %s [%d개]\r\n", cnt, name, total);					
					System.out.println();
				
				} else {
					if (name.replace(" ", "").length() < 6) {
						System.out.printf("  %d. %s [%d개]   \t", cnt, name, total);
					} else if (name.length() < 14) {
						System.out.printf("  %d. %s [%d개]    ", cnt, name, total);	
					} else {
						System.out.printf("  %d. %s [%d개]", cnt, name, total);
					} 
				}

			}
		}
		

		
		
		if (inputCate.equals("4") || inputCate.equals("5")) {
			System.out.println("\r\n\r\n\r\n\r\n");
		} else if (inputCate.equals("2")) {
			System.out.println("\r\n");
		} else if (inputCate.equals("3")) {
			System.out.println();
		}		
		Output.toolEnd();
		Scanner scan = new Scanner(System.in);
		scan.nextLine();
		
		
		
		
		
	}
	
	/**
	 * 판매 통계 기능 화면 구현에 공통으로 사용되는 문자들을 출력하는 메소드입니다.
	 */
	private static void printLetter() {
		
		System.out.println("   ____        __                 __              \r\n"
				+ "  /\\  _`\\     /\\ \\__             /\\ \\    \r\n"
				+ "  \\ \\,\\L\\_\\   \\ \\ ,_\\     __     \\ \\ ,_\\    ____  \r\n"
				+ "   \\/_\\__ \\    \\ \\ \\/   /'__`\\    \\ \\ \\/   /',__\\ \r\n"
				+ "     /\\ \\L\\ \\   \\ \\ \\_ /\\ \\L\\.\\_   \\ \\ \\_ /\\__, `\\\r\n"
				+ "     \\ `\\____\\   \\ \\__\\\\ \\__/.\\_\\   \\ \\__\\\\/\\____/\r\n"
				+ "      \\/_____/    \\/__/ \\/__/\\/_/    \\/__/ \\/___/ ");
		
	}

	
	/**
	 * 판매 통계 출력을 위해 메뉴별로 해당 기간의 판매 개수를 구하는 메소드입니다.
	 * @param m 메뉴
	 * @return 판매개수
	 */
	private static long countOrder(Menu m) {
	
		return 
		Data.olist.stream().filter(order -> order.getMenuSeq().equals(m.getSeq()))
		   .filter(order -> order.getOrderDate().getTimeInMillis() >= startDate.getTimeInMillis()
		   					&& order.getOrderDate().getTimeInMillis() <= endDate.getTimeInMillis())
		   .count();
		
	}
	
}
