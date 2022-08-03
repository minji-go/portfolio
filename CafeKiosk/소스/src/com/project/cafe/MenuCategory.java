package com.project.cafe;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Scanner;

import com.project.cafe.dataClass.Menu;
import com.project.cafe.dataClass.Order;
import com.project.cafe.order.CartOrder;

/**
 * 공통으로 쓰이는 카테고리, 메뉴들 출력하고 입력받는 클래스입니다.
 * 
 * @author 고수경
 *
 */
public class MenuCategory {

	public static String chosenCategory;
	public static String chosenMenu;
	public static ArrayList<Menu> menus;
	public static String menuOne, menuTwo, menuThree, menuFour, menuFive;
	
	static {
		menus = new ArrayList<Menu>();
	}
	
	/**
	 * 커피 카테고리의 음료들을 출력하고, 메뉴번호를 입력받는 메소드입니다.
	 */
	public static void printCoffee() {

		Scanner scan = new Scanner(System.in);
		basicCoffee();

		System.out.print("Select▶");
		chosenMenu = scan.nextLine();

	}
	/**
	 * 커피 카테고리의 음료들을 출력하는 메소드입니다. 
	 */
	public static void basicCoffee() {

		menus.clear();

		int cnt = 0;
		String name = null;
		printStart();

		System.out.println("\t _____          __   __             \r\n" + "\t/  __ \\        / _| / _|            \r\n"
				+ "\t| /  \\/  ___  | |_ | |_   ___   ___ \r\n" + "\t| |     / _ \\ |  _||  _| / _ \\ / _ \\\r\n"
				+ "\t| \\__/\\| (_) || |  | |  |  __/|  __/\r\n" + "\t \\____/ \\___/ |_|  |_|   \\___| \\___|\n");
		System.out.println("-----------------------------------------------------\n");

		for (Menu m : Data.mlist) {

			if (m.getCseq().equals("1")) {
				cnt++;
				name = m.getName();
				menus.add(m);

				if (cnt % 2 == 0) {

					System.out.printf("\t%d.%s\n\n", cnt, name);
					System.out.println();
				} else {
					if (name.length() < 15) {
						System.out.printf("    %d.%s\t", cnt, name);
					} else {
						System.out.printf("    %d.%s", cnt, name);
					}
				}

			}
		}
		System.out.println();
		Output.toolEnd();
	}

	/**
	 * 음료 카테고리의 음료들을 출력하고, 메뉴번호를 입력받는 메소드입니다.
	 */
	public static void printBeverage() {
		Scanner scan = new Scanner(System.in);
		basicBeverage();

		System.out.print("Select▶");
		chosenMenu = scan.nextLine();
	}
	/**
	 * 음료 카테고리의 음료들을 출력하는 메소드입니다.
	 */
	
	public static void basicBeverage() {

		menus.clear();

		int cnt = 0;
		String name = null;
		printStart();
		System.out.println(" ______                                              \r\n"
				+ " | ___ \\                                             \r\n"
				+ " | |_/ /  ___ __   __  ___  _ __   __ _   __ _   ___ \r\n"
				+ " | ___ \\ / _ \\\\ \\ / / / _ \\| '__| / _` | / _` | / _ \\\r\n"
				+ " | |_/ /|  __/ \\ V / |  __/| |   | (_| || (_| ||  __/\r\n"
				+ " \\____/  \\___|  \\_/   \\___||_|    \\__,_| \\__, | \\___|\r\n"
				+ "                                         __/ |      \r\n"
				+ "                                        |___/   \n");

		System.out.println("-----------------------------------------------------\n");
		for (Menu m : Data.mlist) {

			if (m.getCseq().equals("2")) {
				cnt++;
				name = m.getName();
				menus.add(m);

				if (cnt % 2 == 0) {

					System.out.printf("\t%d.%s\n\n", cnt, name);
					System.out.println();
				} else {
					if (name.length() < 10) {
						System.out.printf("          %d.%s\t", cnt, name);
					} else {
						System.out.printf("          %d.%s", cnt, name);
					}
				}

			}

		}

		Output.toolEnd();
	}
	
	/**
	 * 티 카테고리의 음료들을 출력하고, 메뉴번호를 입력받는 메소드입니다.
	 */

	public static void printTea() {

		Scanner scan = new Scanner(System.in);
		basicTea();

		System.out.print("Select▶");
		chosenMenu = scan.nextLine();
	}
	
	/**
	 * 티 카테고리의 음료들을 출력하는 메소드입니다.
	 */

	public static void basicTea() {

		menus.clear();

		int cnt = 0;
		String name = null;
		printStart();
		System.out.println("" + "\t\t _____              \r\n" + "\t\t|_   _|             \r\n"
				+ "\t\t  | |    ___   __ _ \r\n" + "\t\t  | |   / _ \\ / _` |\r\n" + "\t\t  | |  |  __/| (_| |\r\n"
				+ "\t\t  \\_/   \\___| \\__,_|\r\n");

		System.out.println("-----------------------------------------------------\n");
		for (Menu m : Data.mlist) {

			if (m.getCseq().equals("3")) {
				cnt++;
				name = m.getName();
				menus.add(m);

				if (cnt % 2 == 0) {

					System.out.printf("\t%d.%s\n\n", cnt, name);
					System.out.println();
				} else {
					if (name.length() < 11) {
						System.out.printf("       %d.%s  \t", cnt, name);
					} else {

						System.out.printf("       %d.%s  ", cnt, name);

					}
				}

			}

		}
		System.out.println();
		Output.toolEnd();
	}
	
	/**
	 * 에이드 카테고리의 음료들을 출력하고, 메뉴번호를 입력받는 메소드입니다.
	 */

	public static void printAde() {
		Scanner scan = new Scanner(System.in);
		basicAde();

		System.out.print("Select▶");
		chosenMenu = scan.nextLine();
	}
	
	/**
	 * 에이드 카테고리의 음료들을 출력하는 메소드입니다. 
	 */
	public static void basicAde() {

		menus.clear();

		int cnt = 0;
		String name = null;
		printStart();
		System.out.println("" + "\t\t  ___       _       \r\n" + "\t\t / _ \\     | |      \r\n"
				+ "\t\t/ /_\\ \\  __| |  ___ \r\n" + "\t\t|  _  | / _` | / _ \\\r\n" + "\t\t| | | || (_| ||  __/\r\n"
				+ "\t\t\\_| |_/ \\__,_| \\___|\r\n" + "");

		System.out.println("-----------------------------------------------------\n");
		for (Menu m : Data.mlist) {

			if (m.getCseq().equals("4")) {
				cnt++;
				name = m.getName();
				menus.add(m);

				if (cnt % 2 == 0) {

					System.out.printf("\t%d.%s\n", cnt, name);
					System.out.println();
				} else {
					if (name.length() < 9) {
						System.out.printf("           %d.%s\t", cnt, name);
					} else {
						System.out.printf("           %d.%s", cnt, name);
					}
				}

			}

		}

		System.out.println("\n\n\n\n\n\n\n\n\n");
		Output.toolEnd();
	}
	
	/**
	 * 스무디 카테고리의 음료들을 출력하고, 메뉴번호를 입력받는 메소드입니다.
	 */
	public static void printSmoothe() {

		Scanner scan = new Scanner(System.in);
		basicSmoothe();

		System.out.print("Select▶");
		chosenMenu = scan.nextLine();

	}
	/**
	 * 스무디 카테고리의 음료들을 출력하는 메소드입니다.
	 */

	public static void basicSmoothe() {

		menus.clear();

		int cnt = 0;
		String name = null;
		printStart();
		System.out.println("" + "  _____                           _    _           \r\n"
				+ " /  ___|                         | |  | |          \r\n"
				+ " \\ `--.  _ __ ___    ___    ___  | |_ | |__    ___ \r\n"
				+ "  `--. \\| '_ ` _ \\  / _ \\  / _ \\ | __|| '_ \\  / _ \\\r\n"
				+ " /\\__/ /| | | | | || (_) || (_) || |_ | | | ||  __/\r\n"
				+ " \\____/ |_| |_| |_| \\___/  \\___/  \\__||_| |_| \\___|\r\n"
				+ "                                                  \r\n" + "");

		System.out.println("-----------------------------------------------------\n");
		for (Menu m : Data.mlist) {

			if (m.getCseq().equals("5")) {
				cnt++;
				name = m.getName();
				menus.add(m);

				if (cnt % 2 == 0) {

					System.out.printf("\t%d.%s\n\n", cnt, name);
					System.out.println();
				} else {
					if (name.length() < 9) {
						System.out.printf("         %d.%s\t", cnt, name);
					} else {
						System.out.printf("         %d.%s", cnt, name);
					}
				}

			}

		}

		System.out.println("\n\n\n\n\n\n\n");
		Output.toolEnd();
	}

	/**
	 * Best 메뉴 5개와 카테고리 종류 출력하고 선택할 번호 입력받는 메소드입니다.
	 */
	public static void printBestMenuCategory() {

		Scanner scan = new Scanner(System.in);
		printStart();

		Calendar weekago = Calendar.getInstance();
		weekago.add(Calendar.DATE, -7);
		weekago.set(Calendar.HOUR, 0);
		weekago.set(Calendar.MINUTE, 0);
		int temp = 0;
		Data.olist.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));
		
		for(int i = 0; i<Data.olist.size();i++) {
		//for (Order o : Data.olist) {
			if ((Data.olist.get(i).getOrderDate().compareTo(weekago) > 0) || (Data.olist.get(i).getOrderDate().compareTo(weekago) == 0)) {

				temp++;
				if (temp > 0) {
					System.out.println("\t\t*******[BEST MENU]********\n");
					printBestMenu();
					break;

				} else {
					System.out.println("\n\t\t*******[추천 MENU]********\n");
					printRecommend();
					break;
				}
			}
		}
		
		
		//아래와 같이 for문을 도니까 java.util.ConcurrentModificationException 오류가 떴다. 향상 for문을 일반 for문으로 바꾸니 해결됨.
//		for (Order o : Data.olist) {
//		if ((o.getOrderDate().compareTo(weekago) > 0) || (o.getOrderDate().compareTo(weekago) == 0)) {
//
//			temp++;
//			if (temp > 0) {
//				System.out.println("\t\t*******[BEST MENU]********\n");
//				printBestMenu();
//
//			} else {
//				System.out.println("\n\t\t*******[추천 MENU]********\n");
//				printRecommend();
//				break;
//			}
//		}
//	}

		System.out.println("\n-----------------------------------------------------");

		System.out.println("" + "   ___         _                                    \r\n"
				+ "  / __\\  __ _ | |_   ___   __ _   ___   _ __  _   _ \r\n"
				+ " / /    / _` || __| / _ \\ / _` | / _ \\ | '__|| | | |\r\n"
				+ "/ /___ | (_| || |_ |  __/| (_| || (_) || |   | |_| |\r\n"
				+ "\\____/  \\__,_| \\__| \\___| \\__, | \\___/ |_|    \\__, |\r\n"
				+ "                          |___/               |___/ \r\n" + "");

		System.out.println("-----------------------------------------------------");
		System.out.println();
		System.out.println("\t\t\tA.커피" + "\n\n\t\t\tB.음료" + "\n\n\t\t\tC.티" + "\n\n\t\t\tD.에이드" + "\n\n\t\t\tE.스무디"
				+ "\n\n\t\t\t0.메인 화면");
		System.out.println();
		System.out.printf("\t\t\t\t\t  🛒장바구니(%d)\n", CartOrder.cart.size()); // TODO 장바구니 개수 출력하는거 맞는 ArrayList로
																				// 연결시키기.

		Output.toolEnd();
		System.out.println("🛒 장바구니 진입은 * 을 입력해주세요. ");
		System.out.print("Select▶");
		chosenCategory = scan.nextLine();
		boolean loop = true;
		boolean error = true;

		while (loop) {
			if(menuOne!=null) {
				if(chosenCategory.equals("1")) {
					loop = true;
					break;
				}
			}
			if(menuTwo!=null) {
				if(chosenCategory.equals("2")) {
					loop = true;
					break;
				}
			}
			if(menuThree!=null) {
				if(chosenCategory.equals("3")) {
					loop = true;
					break;
				}
			}
			if(menuFour!=null) {
				if(chosenCategory.equals("4")) {
					loop = true;
					break;
				}
			}
			if(menuFive!=null) {
				if(chosenCategory.equals("5")) {
					loop = true;
					break;
				}
			}
			if ((chosenCategory.equals("A")) || (chosenCategory.equals("a"))) {
				printCoffee();
				break;
			} else if ((chosenCategory.equals("B")) || (chosenCategory.equals("b"))) {
				printBeverage();
				break;
			} else if ((chosenCategory.equals("C")) || (chosenCategory.equals("c"))) {
				printTea();
				break;
			} else if ((chosenCategory.equals("D")) || (chosenCategory.equals("d"))) {
				printAde();
				break;
			} else if ((chosenCategory.equals("E")) || (chosenCategory.equals("b"))) {
				printSmoothe();
				break;
			} else if (chosenCategory.equals("*")) {
				CartOrder c = new CartOrder();
				c.main();
				break;
			} else if (chosenCategory.equals("0")) {
				loop = false;
			}
			else {
				System.out.println(chosenCategory + "은(는) 잘못된 접근입니다.");
				break;
			}
			
			
		}
	}
	

	private static void printBestMenu() {
		// TODO 주문내역에 지금으로부터 1주일의 내용이 없다면, 추천 메뉴 5개 뜨게 하기
		Calendar weekago = Calendar.getInstance();
		weekago.add(Calendar.DATE, -7);
		weekago.set(Calendar.HOUR, 0);
		weekago.set(Calendar.MINUTE, 0);
		int i = 0;
		int[] menuSeq = new int[Data.mlist.size()];
		Data.olist.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));

		for (Order o : Data.olist) {

			if ((o.getOrderDate().compareTo(weekago) > 0) || (o.getOrderDate().compareTo(weekago) == 0)) {

				menuSeq[Integer.parseInt(o.getMenuSeq()) - 1] = menuSeq[Integer.parseInt(o.getMenuSeq()) - 1] + 1;
			}

		}

		int max = menuSeq[0];

		i = findMax(menuSeq, max);
		int bestOne = 0;
		if (i == -1) {
			bestOne = 0;
		} else {
			bestOne = i + 1;
		}
		i = findMax(menuSeq, max);
		int bestTwo = 0;
		if (i == -1) {
			bestTwo = 0;
		} else {
			bestTwo = i + 1;
		}
		i = findMax(menuSeq, max);
		int bestThree = 0;
		if (i == -1) {
			bestThree = 0;
		} else {
			bestThree = i + 1;
		}

		i = findMax(menuSeq, max);
		int bestFour = 0;
		if (i == -1) {
			bestFour = 0;
		} else {
			bestFour = i + 1;
		}

		i = findMax(menuSeq, max);
		int bestFive = 0;
		if (i == -1) {
			bestFive = 0;
		} else {
			bestFive = i + 1;
		}

		int count = 1;
		
		
		
		
		if ((bestOne != 0) || (bestTwo != 0) || (bestThree != 0) || (bestFour != 0) || (bestFive != 0)) {
			for(int j = 0; j<Data.mlist.size(); j++) {
			//for (Menu m : Data.mlist) {
				if ((Integer.toString(bestOne).equals(Data.mlist.get(j).getSeq())) || (Integer.toString(bestTwo).equals(Data.mlist.get(j).getSeq()))
						|| (Integer.toString(bestThree).equals(Data.mlist.get(j).getSeq()))
						|| (Integer.toString(bestFour).equals(Data.mlist.get(j).getSeq()))
						|| (Integer.toString(bestFive).equals(Data.mlist.get(j).getSeq()))) {
					

					System.out.printf("\t\t   %d. %s\n", count, Data.mlist.get(j).getName());
					switch(count) {
					case 1: menuOne = Data.mlist.get(j).getSeq(); break;
					case 2: menuTwo = Data.mlist.get(j).getSeq(); break;
					case 3: menuThree = Data.mlist.get(j).getSeq(); break;
					case 4: menuFour = Data.mlist.get(j).getSeq(); break;
					case 5: menuFour = Data.mlist.get(j).getSeq(); break;
					
					}
					count++;
				}
			}

		}
		

	}

	private static int findMax(int[] menuSeq, int max) {
		int i;
		int num = -1;

		for (i = 0; i < menuSeq.length; i++) {

			if (menuSeq[i] == 0) {
				continue;
			}

			if (menuSeq[i] > max) {
				max = menuSeq[i];
				num = i;
			}

		}

		if (num != -1) {
			menuSeq[num] = 0;
		}

		return num;
	}

	private static void printRecommend() {// 추천 메뉴 출력

		int num = 1;
		for (Menu m : Data.mlist) {

			if (m.getName().contains("아이스 아메리카노")) {

				System.out.printf("   %d. %s", num, m.getName());
				menuOne = m.getName();
				num++;
			} else if (m.getName().contains("아이스 블론드 에스프레소 라떼")) {
				System.out.printf("   %d. %s\n", num, m.getName());
				menuTwo = m.getName();
				num++;
			} else if (m.getName().contains("아이스 돌체 블랙 밀크 티")) {
				System.out.printf("\t  %d. %s\n\n", num, m.getName());
				menuThree = m.getName();
				num++;
			} else if (m.getName().contains("아이스 피치 젤리 티")) {
				System.out.printf("   %d. %s", num, m.getName());
				menuFour = m.getName();
				num++;

			} else if (m.getName().contains("제주 그린티 스무디")) {
				System.out.printf("\t  %d. %s\n\n", num, m.getName());
				menuFive = m.getName();
				num++;
			}

		}

	}

	public static void startCategory() {

		System.out.println("\r\n" + " _____         _                                    \r\n"
				+ "/  __ \\       | |                          " + "         \r\n"
				+ "| /  \\/  __ _ | |_   ___   __ _   ___   _ __  _   _ \r\n"
				+ "| |     / _` || __| / _ \\ / _` | / _ \\ | '__|| | | |\r\n"
				+ "| \\__/\\| (_| || |_ |  __/| (_| || (_) || |   | |_| |\r\n"
				+ " \\____/ \\__,_| \\__| \\___| \\__, | \\___/ |_|    \\__, |\r\n"
				+ "                           __/ |               __/ |\r\n"
				+ "                          |___/               |___/ \r\n" + "");
		System.out.println("-----------------------------------------------------");
		System.out.println();
		System.out.println("\t\t\t1.커피" + "\n\n\t\t\t2.음료" + "\n\n\t\t\t3.티" + "\n\n\t\t\t4.에이드" + "\n\n\t\t\t5.스무디"
				+ "\n\n\t\t\t0.뒤로");
		System.out.println();
		System.out.println();

		Output.toolEnd();
	}

	public static void printStart() {
		Output.toolStart();
		Calendar now = Calendar.getInstance();
		System.out.print("\t\t\t\t");
		System.out.printf("%tF %s:%s %tA\n", now, now.get(Calendar.HOUR_OF_DAY), now.get(Calendar.MINUTE), now);

	}

}