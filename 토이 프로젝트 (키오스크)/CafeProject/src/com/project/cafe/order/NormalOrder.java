package com.project.cafe.order;

import java.util.Scanner;

import com.project.cafe.Data;
import com.project.cafe.FindData;
import com.project.cafe.Main;
import com.project.cafe.MenuCategory;
import com.project.cafe.Output;
import com.project.cafe.dataClass.Cart;
import com.project.cafe.dataClass.CustomMenu;
import com.project.cafe.dataClass.Menu;

/**
 * 사용자 기능 중 일반 주문 기능을 구현한 클래스입니다.
 * 
 * @author 김승연
 *
 */
public class NormalOrder extends Payment {
	public static boolean loop;
	public static Cart currentMenu;
	public static String[] option = { "얼음량", "시럽", "샷추가", "휘핑", "토핑" };
	public static String inputIce, inputSyrup, inputShot, inputWhipping, inputTopping;
	// cart(장바구니번호, 메뉴번호, 얼음량옵션번호, 시럽옵션번호, 샷추가옵션번호, 휘핑크림옵션번호, 토핑추가옵션번호)

	// 생성자로 currentMenu의 기본값 설정, 얼음량 기본값만 2 = 보통
	public NormalOrder() {
		loop = true;
		currentMenu = new Cart(null, "0", "2", "0", "0", "0", "0");
	}

	/**
	 * public 메인 메소드입니다.
	 */
	public static void work() {

		// TODO Best Menu 추가하기
		new NormalOrder();
		while (loop) {

			MenuCategory.printBestMenuCategory();
			if(MenuCategory.menuOne!=null) {
				if(MenuCategory.chosenCategory.equals("1")) {
					bestToMenu();
					findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					addOption();
					saveOption();
					addCart();
					
					loop = false;
					
				}
			}
			if(MenuCategory.menuTwo!=null) {
				if(MenuCategory.chosenCategory.equals("2")) {
					bestToMenu();
					findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					addOption();
					saveOption();
					addCart();
					
					loop = false;
					
				}
			}
			if(MenuCategory.menuThree!=null) {
				if(MenuCategory.chosenCategory.equals("3")) {
					bestToMenu();
					findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					addOption();
					saveOption();
					addCart();
					
					loop = false;
					
				}
			}
			
			if(MenuCategory.menuFour!=null) {
				if(MenuCategory.chosenCategory.equals("4")) {
					bestToMenu();
					findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					addOption();
					saveOption();
					addCart();
					
					loop = false;
					
				}
			}
			if(MenuCategory.menuFive!=null) {
				if(MenuCategory.chosenCategory.equals("5")) {
					bestToMenu();
					findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					addOption();
					saveOption();
					addCart();
					
					loop = false;
					
				}
			}

			if (MenuCategory.chosenCategory.equals("*")) { // 장바구니 선택 시 메뉴선택과정 메소드 실행되지 못하도록
				loop = false;
				// continue;

			} 
			else if (MenuCategory.chosenCategory.toLowerCase().equals("a")
					|| MenuCategory.chosenCategory.toLowerCase().equals("b")
					|| MenuCategory.chosenCategory.toLowerCase().equals("c")
					|| MenuCategory.chosenCategory.toLowerCase().equals("d")
					|| MenuCategory.chosenCategory.toLowerCase().equals("e")) { // ABCDEabcde 선택 시
				CategoryTrans();
				findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
				addOption();
				saveOption();
				addCart();

				loop = false;

			} else if(MenuCategory.chosenCategory.equals("0")) {
				loop = false;
			}
			
			else {

				System.out.println("올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
				Scanner scan = new Scanner(System.in);
				scan.nextLine();

			}
		}

	}

	/**
	 * 베스트 메뉴 및 추천 메뉴에서 선택받은 메뉴 번호를 카테고리 내 번호로 반환하는 메소드입니다.
	 */
	private static void bestToMenu() {

		// MenuCategory.chosenCategory = 사용자 입력값 (베스트메뉴 12345 or 카테고리 abcde)
		// MenuCategory.bestOne ~ bestFive = 베스트메뉴 or 추천메뉴 1위~5위 메뉴번호

		int temp = 0;
		if (MenuCategory.chosenCategory.equals("1")) {
			if (MenuCategory.menuOne != null) {
				MenuCategory.chosenCategory = FindData.findMenu(MenuCategory.menuOne).getCseq();
				for (int i = 0; i < Data.mlist.size(); i++) {
					if (Data.mlist.get(i).getCseq().equals(MenuCategory.chosenCategory)) {
						temp++;
						if (Data.mlist.get(i).getSeq().equals(MenuCategory.menuOne)) {
							MenuCategory.chosenMenu = String.valueOf(temp);
							break;
						}
					}
				}
			}
		} else if (MenuCategory.chosenCategory.equals("2")) {
			if (MenuCategory.menuTwo != null) {
				MenuCategory.chosenCategory = FindData.findMenu(MenuCategory.menuTwo).getCseq();
				System.out.println(MenuCategory.chosenCategory);
				for (int i = 0; i < Data.mlist.size(); i++) {
					if (Data.mlist.get(i).getCseq().equals(MenuCategory.chosenCategory)) {
						temp++;
						if (Data.mlist.get(i).getSeq().equals(MenuCategory.menuTwo)) {
							MenuCategory.chosenMenu = String.valueOf(temp);
							break;
						}
					}
				}
			}
		} else if (MenuCategory.chosenCategory.equals("3")) {
			if (MenuCategory.menuThree != null) {
				MenuCategory.chosenCategory = FindData.findMenu(MenuCategory.menuThree).getCseq();
				for (int i = 0; i < Data.mlist.size(); i++) {
					if (Data.mlist.get(i).getCseq().equals(MenuCategory.chosenCategory)) {
						temp++;
						if (Data.mlist.get(i).getSeq().equals(MenuCategory.menuThree)) {
							MenuCategory.chosenMenu = String.valueOf(temp);
							break;
						}
					}
				}
			}
		} else if (MenuCategory.chosenCategory.equals("4")) {
			if (MenuCategory.menuFour != null) {
				MenuCategory.chosenCategory = FindData.findMenu(MenuCategory.menuFour).getCseq();
				for (int i = 0; i < Data.mlist.size(); i++) {
					if (Data.mlist.get(i).getCseq().equals(MenuCategory.chosenCategory)) {
						temp++;
						if (Data.mlist.get(i).getSeq().equals(MenuCategory.menuFour)) {
							MenuCategory.chosenMenu = String.valueOf(temp);
							break;
						}
					}
				}
			}
		} else if (MenuCategory.chosenCategory.equals("5")) {
			if (MenuCategory.menuFive != null) {
				MenuCategory.chosenCategory = FindData.findMenu(MenuCategory.menuFive).getCseq();
				for (int i = 0; i < Data.mlist.size(); i++) {
					if (Data.mlist.get(i).getCseq().equals(MenuCategory.chosenCategory)) {
						temp++;
						if (Data.mlist.get(i).getSeq().equals(MenuCategory.menuFive)) {
							MenuCategory.chosenMenu = String.valueOf(temp);
							break;
						}
					}
				}
			}
		}

	}

	/**
	 * 앞서 ABCDE로 선택받은 카테고리값을 카테고리 번호로 바꿔주는 메소드입니다.
	 */
	private static void CategoryTrans() {

		switch (MenuCategory.chosenCategory) {
		case "A":
		case "a":
			MenuCategory.chosenCategory = "1";
			break;
		case "B":
		case "b":
			MenuCategory.chosenCategory = "2";
			break;
		case "C":
		case "c":
			MenuCategory.chosenCategory = "3";
			break;
		case "D":
		case "d":
			MenuCategory.chosenCategory = "4";
			break;
		case "E":
		case "e":
			MenuCategory.chosenCategory = "5";
			break;
		}
	}

	private static void findMenu(String menu) {

		int temp = 0;

		for (int i = 0; i < Data.mlist.size(); i++) {
			if (Data.mlist.get(i).getCseq().equals(menu)) {
				temp = i;
				break;
			}
		}

		String menuResult = String.valueOf(temp + Integer.parseInt(menu));
		currentMenu.setMenuSeq(menuResult);

		// XXX 내가 수정한 부분
		boolean loop = true;
		// while(loop) {
		for (Menu m : Data.mlist) {
			if (menuResult.equals(m.getSeq())) {
				if (m.getName().contains("(품절)")) {
					System.out.println("⚠️ " + m.getName() + "은 품절된 음료입니다. 다른 음료를 선택해주세요.");
					Scanner scan = new Scanner(System.in);
					scan.nextLine();
					switch (m.getCseq()) {

					case "1": {
						MenuCategory.printCoffee();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "2": {
						MenuCategory.printBeverage();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "3": {
						MenuCategory.printTea();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "4": {
						MenuCategory.printAde();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "5": {
						MenuCategory.printSmoothe();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;

					}

				} else {
					currentMenu.setMenuSeq(menuResult);

				}

			}

		}

	}

	/**
	 * 사용자가 입력한 카테고리 번호 및 메뉴 번호를 바탕으로 메뉴 데이터 파일에서 음료 번호를 찾고, currentMenu의 MenuSeq에
	 * 추가하는 메소드입니다.
	 * 
	 * @param category
	 * @param menu
	 */

	private static void findMenu(String category, String menu) {

		// Cart currentMenu = 지금 현재 고르는 중인 메뉴의 속성을 임시저장할 카트 객체.
		// 매개변수 = 사용자가 MenuCategory.java에서 입력한 카테고리 번호 및 메뉴 번호 (MenuCategory.java에
		// static 변수 추가함)
		// 커피 1번 = 메뉴.txt 1번
		// 음료 1번 = 메뉴.txt 13번
		// 티 1번 = 메뉴.txt 23번...
		// 사용자가 입력한 번호에 따라 메뉴.txt에서 음료번호를 찾은 후에 currentMenu의 MenuSeq에 넣어주는 메소드

		int temp = 0;

		for (int i = 0; i < Data.mlist.size(); i++) {
			if (Data.mlist.get(i).getCseq().equals(category)) {
				temp = i;
				break;
			}
		}

		String menuResult = String.valueOf(temp + Integer.parseInt(menu));
		currentMenu.setMenuSeq(menuResult);

		// XXX 내가 수정한 부분
		boolean loop = true;
		// while(loop) {
		for (Menu m : Data.mlist) {
			if (menuResult.equals(m.getSeq())) {
				if (m.getName().contains("(품절)")) {
					System.out.println("⚠️ " + m.getName() + "은 품절된 음료입니다. 다른 음료를 선택해주세요.");
					Scanner scan = new Scanner(System.in);
					scan.nextLine();
					switch (m.getCseq()) {

					case "1": {
						MenuCategory.printCoffee();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "2": {
						MenuCategory.printBeverage();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "3": {
						MenuCategory.printTea();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "4": {
						MenuCategory.printAde();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;
					case "5": {
						MenuCategory.printSmoothe();
						findMenu(MenuCategory.chosenCategory, MenuCategory.chosenMenu);
					}
						break;

					}

				} else {
					currentMenu.setMenuSeq(menuResult);

				}

			}

		}

	}

	/**
	 * currentMenu 객체에 각종 옵션을 사용자 선택으로 업데이트해 주는 메소드입니다.
	 */
	private static void addOption() {

		chooseOption("얼음량");
		chooseOption("시럽");
		chooseOption("샷추가");
		chooseOption("휘핑");
		chooseOption("토핑");

	}

	/**
	 * 옵션 이름을 넣으면 각 옵션 선택 화면을 출력, 옵션을 선택받는 메소드입니다.
	 * 
	 * @param optionName 옵션명
	 */
	private static void chooseOption(String optionName) {

		printLetter();

		if (optionName.equals(option[0])) {
			for (int i = 0; i < option.length; i++) {
				System.out.println(printOption(option[i]));
			}
		} else if (optionName.equals(option[1])) {
			System.out.println(printResult(option[0]));
			for (int i = 1; i < option.length; i++) {
				System.out.println(printOption(option[i]));
			}
		} else if (optionName.equals(option[2])) {
			for (int i = 0; i < 2; i++) {
				System.out.println(printResult(option[i]));
			}
			for (int i = 2; i < option.length; i++) {
				System.out.println(printOption(option[i]));
			}
		} else if (optionName.equals(option[3])) {
			for (int i = 0; i < 3; i++) {
				System.out.println(printResult(option[i]));
			}
			for (int i = 3; i < option.length; i++) {
				System.out.println(printOption(option[i]));
			}
		} else if (optionName.equals(option[4])) {
			for (int i = 0; i < 4; i++) {
				System.out.println(printResult(option[i]));
			}
			System.out.println(printOption(option[4]));
		}

		Scanner scan = new Scanner(System.in);

		System.out.println();
		Output.toolEnd();
		System.out.println();

		boolean subLoop = true;

		while (subLoop) {
			System.out.printf("   %s 옵션 번호를 입력하세요.: ", optionName);

			if (optionName.equals(option[0])) {

				inputIce = scan.nextLine();

				if (FindData.findMenu(currentMenu.getMenuSeq()).getName().startsWith("핫")) {
					if (!inputIce.equals("0")) {
						System.out.println("   핫 음료는 '얼음없음' 기본값이 자동 적용됩니다. ([Enter]: 계속)");
						scan.nextLine();
						inputIce = "0";
						subLoop = false;
					} else {
						inputIce = "0";
						subLoop = false;
					}
				} else {

					if (inputIce.equals("0") || inputIce.equals("1") || inputIce.equals("2") || inputIce.equals("3")) {
						currentMenu.setIceSeq(inputIce);
						subLoop = false;
					} else if (inputIce.equals("")) {
						inputIce = "2";
						currentMenu.setIceSeq(inputIce);
						subLoop = false;
					} else {
						System.out.println("   올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
					}
				}

			} else if (optionName.equals(option[1])) {

				inputSyrup = scan.nextLine();

				if (inputSyrup.equals("0") || inputSyrup.equals("1") || inputSyrup.equals("2") || inputSyrup.equals("3")
						|| inputSyrup.equals("3") || inputSyrup.equals("4")) {
					currentMenu.setSyrupSeq(inputSyrup);
					subLoop = false;
				} else if (inputSyrup.equals("")) {
					inputSyrup = "0";
					currentMenu.setSyrupSeq(inputSyrup);
					subLoop = false;
				} else {
					System.out.println("   올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
				}

			} else if (optionName.equals(option[2])) {

				inputShot = scan.nextLine();

				if (inputShot.equals("0") || inputShot.equals("1") || inputShot.equals("2") || inputShot.equals("3")
						|| inputShot.equals("4") || inputShot.equals("5") || inputShot.equals("6")
						|| inputShot.equals("7") || inputShot.equals("8") || inputShot.equals("9")) {
					currentMenu.setShotSeq(inputShot);
					subLoop = false;
				} else if (inputShot.equals("")) {
					inputShot = "0";
					currentMenu.setShotSeq(inputShot);
					subLoop = false;
				} else {
					System.out.println("   올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
				}

			} else if (optionName.equals(option[3])) {
				inputWhipping = scan.nextLine();

				if (inputWhipping.equals("0") || inputWhipping.equals("1") || inputWhipping.equals("2")) {
					currentMenu.setWhippingSeq(inputWhipping);
					subLoop = false;
				} else if (inputWhipping.equals("")) {
					inputWhipping = "0";
					currentMenu.setWhippingSeq(inputWhipping);
					subLoop = false;
				} else {
					System.out.println("   올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
				}

			} else if (optionName.equals(option[4])) {
				inputTopping = scan.nextLine();

				if (inputTopping.equals("0") || inputTopping.equals("1") || inputTopping.equals("2")
						|| inputTopping.equals("3")) {
					currentMenu.setToppingSeq(inputTopping);
					subLoop = false;
				} else if (inputTopping.equals("")) {
					inputTopping = "0";
					currentMenu.setToppingSeq(inputTopping);
					subLoop = false;
				} else {
					System.out.println("   올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
				}
			}

		}
	}

	/**
	 * 옵션 이름을 매개변수로 받은 후 각 옵션별 선택 화면에 출력할 값을 반환하는 메소드입니다.
	 * 
	 * @param option 옵션명
	 * @return 출력값
	 */
	private static String printOption(String option) {
		// 얼음량, 시럽, 샷추가... arraylist에서 옵션명 및 가격 뽑아와서 출력하려 했으나 예쁘게 정렬이 어렵다...!

		if (option.equals("얼음량")) {

			if (FindData.findMenu(currentMenu.getMenuSeq()).getName().startsWith("핫")) {
				return String.format("\t\t 얼음량 (기본값: 없음)\r\n\t     ０ 없음, １ 적게, ２ 보통, ３ 많이"
						+ "\r\n   •·············································•");
			} else {
				return String.format("\t\t 얼음량 (기본값: 보통)\r\n\t     ０ 없음, １ 적게, ２ 보통, ３ 많이"
						+ "\r\n   •·············································•");
			}

		} else if (option.equals("시럽")) {
			return String.format("\t     시럽 추가 (500원, 기본값: 없음)\r\n    ０ 없음, １ 설탕(무료), ２ 바닐라, ３ 헤이즐넛, ４ 카라멜"
					+ "\r\n   •·············································•");

		} else if (option.equals("샷추가")) {
			return String.format(
					"\t   샷 추가 (1샷 당 500원, 기본값: 없음)\r\n      ０ 없음, １ 1샷, ２ 2샷, ３ 3샷, ４ 4샷, ５ 5샷\r\n\t      ６ 6샷, ７ 7샷, ８ 8샷, ９ 9샷"
							+ "\r\n   •·············································•");

		} else if (option.equals("휘핑")) {
			return String.format("\t   휘핑크림 추가 (500원, 기본값: 없음)\r\n\t ０ 없음, １ 일반 휘핑, ２ 에스프레소 휘핑"
					+ "\r\n   •·············································•");

		} else if (option.equals("토핑")) {
			return String.format("\t    토핑 추가 (500원, 기본값: 없음)\r\n       ０ 없음, １ 타피오카펄, ２ 알로에펄, ３ 코코넛펄"
					+ "\r\n   •·············································•");

		} else {
			return "";
		}

	}

	/**
	 * 사용자의 선택을 받은 후에 변경될 화면 구현을 위해 출력값을 반환하는 메소드입니다.
	 * 
	 * @param option 옵션명
	 * @return 출력값
	 */
	private static String printResult(String option) {

		String[] num = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
		String[] numTemp = { "０", "１", "２", "３", "４", "５", "６", "７", "８", "９" };
		String replace = "";

		if (option.equals("얼음량")) {
			for (int i = 0; i < num.length; i++) {
				if (num[i].equals(inputIce)) {
					replace = numTemp[i];
				}
			}

			if (FindData.findMenu(currentMenu.getMenuSeq()).getName().startsWith("핫")) {
				return String.format("\t\t 얼음량 (기본값: 없음)\r\n\t     ０ 없음, １ 적게, ２ 보통, ３ 많이"
						+ "\r\n   •·············································•").replace(replace, "☑");
			} else {
				return String.format("\t\t 얼음량 (기본값: 보통)\r\n\t     ０ 없음, １ 적게, ２ 보통, ３ 많이"
						+ "\r\n   •·············································•").replace(replace, "☑");
			}

		} else if (option.equals("시럽")) {
			for (int i = 0; i < num.length; i++) {
				if (num[i].equals(inputSyrup)) {
					replace = numTemp[i];
				}
			}
			return String.format("\t     시럽 추가 (500원, 기본값: 없음)\r\n    ０ 없음, １ 설탕(무료), ２ 바닐라, ３ 헤이즐넛, ４ 카라멜"
					+ "\r\n   •·············································•").replace(replace, "☑");

		} else if (option.equals("샷추가")) {
			for (int i = 0; i < num.length; i++) {
				if (num[i].equals(inputShot)) {
					replace = numTemp[i];
				}
			}
			return String.format(
					"\t   샷 추가 (1샷 당 500원, 기본값: 없음)\r\n      ０ 없음, １ 1샷, ２ 2샷, ３ 3샷, ４ 4샷, ５ 5샷\r\n\t      ６ 6샷, ７ 7샷, ８ 8샷, ９ 9샷"
							+ "\r\n   •·············································•")
					.replace(replace, "☑");

		} else if (option.equals("휘핑")) {
			for (int i = 0; i < num.length; i++) {
				if (num[i].equals(inputWhipping)) {
					replace = numTemp[i];
				}
			}
			return String.format("\t   휘핑크림 추가 (500원, 기본값: 없음)\r\n\t ０ 없음, １ 일반 휘핑, ２ 에스프레소 휘핑"
					+ "\r\n   •·············································•").replace(replace, "☑");

		} else if (option.equals("토핑")) {
			for (int i = 0; i < num.length; i++) {
				if (num[i].equals(inputTopping)) {
					replace = numTemp[i];
				}
			}
			return String.format("\t    토핑 추가 (500원, 기본값: 없음)\r\n       ０ 없음, １ 타피오카펄, ２ 알로에펄, ３ 코코넛펄"
					+ "\r\n   •·············································•").replace(replace, "☑");

		} else {
			return "";
		}
	}

	/**
	 * 옵션 선택을 마친 currentMenu 객체를 커스텀(빠른 주문) 등록할지 여부와 휴대폰 번호를 입력받는 메소드입니다.
	 */
	private static void saveOption() {

		boolean subLoop = true;
		while (subLoop) {

			printLetter();
			for (int i = 0; i < option.length; i++) {
				System.out.println(printResult(option[i]));
			}
			Output.toolEnd();
			System.out.print("\r\n커스텀 메뉴에 위 옵션을 저장하시겠습니까?(Y/N) : ");
			Scanner scan = new Scanner(System.in);
			String answer = scan.nextLine();

			if (answer.equals("Y") || answer.equals("y")) {

				boolean subsubLoop = true;
				while (subsubLoop) {

					printLetter();
					for (int i = 0; i < option.length; i++) {
						System.out.println(printResult(option[i]));
					}
					Output.toolEnd();

					System.out.print("\r\n휴대폰 번호를 입력해 주세요. (010-XXXX-XXXX) : ");
					String tel = scan.nextLine();
					if (Main.customerLogin(tel)) {
						CustomMenu m = new CustomMenu(findMaxSeq_cmlist(), Main.currentLogin.getSeq(),
								currentMenu.getMenuSeq(), inputIce, inputSyrup, inputShot, inputWhipping, inputTopping);
						// 커스텀메뉴번호,고객번호,메뉴번호,얼음량번호,시럽번호,샷추가번호,휘핑번호,토핑번호

						if (Data.cmlist.stream()
								.filter(cmMenu -> FindData.findCustomer(cmMenu.getClientSeq()).getTel().equals(tel))
								.count() < 5) {

							Data.cmlist.add(m);

						} else {

							for (int i = 0; i < Data.cmlist.size(); i++) {
								if (FindData.findCustomer(Data.cmlist.get(i).getClientSeq()).getTel().equals(tel)) {
									Data.cmlist.remove(i);
									break;
								}
							}

							Data.cmlist.add(m);
						}

						System.out.printf("[%s](이)가 커스텀 메뉴에 저장되었습니다. ([Enter]: 다음으로)\r\n",
								FindData.findMenu(currentMenu.getMenuSeq()).getName());
						scan.nextLine();
						subLoop = false;
						subsubLoop = false;
					} else {
						System.out.print("올바른 형식으로 다시 입력해 주세요. ([Enter]: 계속)");
						scan.nextLine();
					}
					;

				}
			} else if (answer.equals("N") || answer.equals("n")) {
				subLoop = false;
			} else {
				System.out.println("\"Y\" 혹은 \"N\" 형식으로 입력해 주세요. ([Enter]: 계속)");
				scan.nextLine();

			}
		}

	}

	/**
	 * CartOrder.addToCart와 연결해 currentMenu를 장바구니에 추가하는 메소드입니다.
	 */
	public static void addCart() {

		boolean subloop = true;

		while (subloop) {

			printLetter();
			for (int i = 0; i < option.length; i++) {
				System.out.println(printResult(option[i]));
			}
			Output.toolEnd();

			System.out.print("\r\n장바구니에 위 메뉴를 담으시겠습니까? (Y/N) : ");
			Scanner scan = new Scanner(System.in);
			String answer = scan.nextLine();

			if (answer.equals("Y") || answer.equals("y")) {

				String CartSeq = findMaxSeq_cart();
				currentMenu.setSeq(CartSeq);

				if (CartOrder.addToCart(currentMenu)) {
					System.out.printf("[%s](이)가 장바구니에 저장되었습니다. ([Enter]: 초기화면)\r\n",
							FindData.findMenu(currentMenu.getMenuSeq()).getName());
					scan.nextLine();
					subloop = false;

				} else {
					System.out.printf("장바구니가 가득 찼습니다. ([Enter]: 초기화면)");
					scan.nextLine();
					subloop = false;
				}
				;

			} else if (answer.equals("N") || answer.equals("n")) {
				System.out.println("취소되었습니다. ([Enter]: 초기화면)");
				scan.nextLine();
				subloop = false;

			} else {
				System.out.println("\"Y\" 혹은 \"N\" 형식으로 입력해 주세요. ([Enter]: 계속)");
				scan.nextLine();
			}

		}

	}

	/**
	 * 커스텀메뉴 데이터 파일에 새 데이터를 추가하기 위해 가장 큰 메뉴번호를 구하는 메소드입니다.
	 * 
	 * @return 가장 큰 메뉴번호+1
	 */
	private static String findMaxSeq_cmlist() {
		int max = 0;

		for (CustomMenu c : Data.cmlist) {
			if (Integer.parseInt(c.getSeq()) > max) {
				max = Integer.parseInt(c.getSeq());
			}
		}
		return "" + (max + 1);

	}

	/**
	 * 일반 주문 카테고리의 화면 구현에 공통으로 사용되는 문자들을 출력하는 메소드입니다.
	 */
	private static void printLetter() {

		MenuCategory.printStart();
		System.out.println();
		System.out.println("\t     _   ___  ___  _   _   _  _ \r\n" + "\t    / \\ | o \\|_ _|| | / \\ | \\| |\r\n"
				+ "\t   ( o )|  _/ | | | |( o )| \\\\ |\r\n" + "\t    \\_/ |_|   |_| |_| \\_/ |_|\\_|");
		System.out.printf("\r\n\t\t  [%s]", FindData.findMenu(currentMenu.getMenuSeq()).getName());
		System.out.println("\r\n   •·············································•");
	}

	/**
	 * 장바구니 데이터 파일에 새 데이터를 추가하기 위해 가장 큰 메뉴번호를 구하는 메소드입니다.
	 * 
	 * @return 가장 큰 장바구니번호+1
	 */
	public static String findMaxSeq_cart() {
		int max = 0;

		for (Cart c : CartOrder.cart) {
			if (Integer.parseInt(c.getSeq()) > max) {
				max = Integer.parseInt(c.getSeq());
			}
		}

		return "" + (max + 1);
	}
}