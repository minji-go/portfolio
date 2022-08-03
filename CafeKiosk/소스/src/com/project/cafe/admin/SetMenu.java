package com.project.cafe.admin;

import java.util.Calendar;
import java.util.Scanner;
import java.util.stream.Collectors;
import com.project.cafe.Data;
import com.project.cafe.DataPath;
import com.project.cafe.MenuCategory;
import com.project.cafe.Output;
import com.project.cafe.dataClass.Category;
import com.project.cafe.dataClass.Menu;

/**
 * 관리자가 메뉴를 추가, 수정, 삭제할 수 있는 클래스입니다.
 * @author 고민지
 *
 */
public class SetMenu {

	private boolean loop;
	private boolean error;
	private String input;
	private String name;
	private int price;
	private char category;
	private Menu theMenu;
	
	
	/**
	 * 메뉴 관리 업무의 전체 흐름을 제어하는 메소드입니다.
	 */
	public void main() {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;
		
		while(loop) {
			
			printMenu();
			
			alarmError(input + "은 올바른 입력이 아닙니다.");
			
			System.out.print("Select ▶ ");
			input = scan.nextLine();
		
		
			if(input.equals("1")) {
				addMenu();
			} else if (input.equals("2")) {
				modifyMenu();
			} else if (input.equals("3")) { 
				deleteMenu();
			} else if (input.equals("0")) {
				return;
			} else {
				error = true;
			}
				
		}
	}
	

	
	/**
	 * 메뉴 추가 업무의 전체 흐름을 제어하는 메소드입니다.
	 */
	private void addMenu() {
		
		if(chooseCategory(1)) {
		
			checkNewMenu();
			
			addNewMenu();
		}

	}
	
	/**
	 * 메뉴 수정 업무의 전체 흐름을 제어하는 메소드입니다.
	 */
	public void modifyMenu() {

		if(chooseCategory(2)) {
		
			chooseMenu();
				
			modifyTheMenu();
		}
	 
	}
	
	/**
	 * 메뉴 삭제 업무의 전체 흐름을 제어하는 메소드입니다.
	 */
	private void deleteMenu() {

		if(chooseCategory(3)) {
			
			chooseMenu();
			
			deleteTheMenu();
		}
		
	}

	/**
	 * 추가할 새로운 메뉴를 입력받는 메소드입니다.
	 */
	private void checkNewMenu() {
		
		Scanner scan = new Scanner(System.in);
		
		String errorMessage = null;
		this.loop = true;

		while(loop) {

			printTheCategory();
			
			System.out.printf("[메뉴 등록] %d번째로 등록할 새로운 메뉴명과 가격을 입력해주세요\n", MenuCategory.menus.size()+1);
			System.out.println();
			
			alarmError(errorMessage);
			
			System.out.print("메뉴명/가격(₩) ▶ ");
			input = scan.nextLine();
			
			try {
				
				if(!input.contains("/") ||  input.indexOf("/") != input.lastIndexOf("/")) {
					throw new Exception();
				}
				
				name = input.split("/")[0];
				
				for(Menu m : Data.mlist) {
					if(name.equals(m.getName())){
						throw new NullPointerException();
					}
				}
				
				price = Integer.parseInt(input.split("/")[1].replace("₩" ,"").replace("원", "").replace(" ", ""));
				
				loop = false;

			} catch (NullPointerException e) { 
				error = true;
				errorMessage = input + "은 이미 존재하는 메뉴입니다. 새롭게 등록할 메뉴명을 입력해주세요.";
			} catch (NumberFormatException e) { 
				error = true;
				errorMessage = input.split("/")[1] + "은 잘못된 형식의 가격입니다. 금액을 입력해주세요(단위: 원(₩))";
			} catch (Exception e) {
				error = true;
				errorMessage = "잘못된 형식의 입력입니다. \"메뉴명/가격\"을 \"/\"로 구분하여 입력해주세요. ";
			}

		}
	}
	
	/**
	 * 입력한 새로운 메뉴를 추가하는 메소드입니다.
	 */
	private void addNewMenu() {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;

		while(loop) {
		
			printTheCategory();
			
			alarmError(input + "은 올바른 입력이 아닙니다.");
			
			System.out.printf("[ %s (₩%,d) ]를 등록하시겠습니까? (y/N) ▶ ",  name, price);
			input = scan.nextLine();
			
			
			if(input.toUpperCase().equals("Y")) { 
				
				String seq = "" + (Data.mlist.stream()
											.map(m-> m.getSeq()).mapToInt(Integer::parseInt)
											.max().getAsInt() + 1);
				
				
				Data.mlist.add(new Menu(seq, name, price, findTheCateSeq()));
				Data.save(DataPath.메뉴);
				
				printTheCategory();
				System.out.println("⚠️ 메뉴가 성공적으로 등록되었습니다.");
				System.out.println();
				Output.pause();
				loop = false; 
				
			} else if (input.toUpperCase().equals("N")) { 
				
				printTheCategory();
				System.out.println("⚠️ 메뉴 등록을 취소하였습니다.");
				System.out.println();
				Output.pause();
				loop = false; 
				
			} else {
				error = true;		
			}

		}
	}

	
	/**
	 * 선택한 메뉴를 삭제하는 메소드입니다.
	 */
	private void deleteTheMenu() {
		Scanner scan = new Scanner(System.in);
		this.loop = true;

		while(loop) {

			printTheCategory();
			
			alarmError(input + "은 올바른 입력이 아닙니다.");
			
			System.out.printf("메뉴[%s]를 정말 삭제하시겠습니까? (y/N) ▶ ", theMenu.getName());
			input = scan.nextLine();
			
			
			if(input.toUpperCase().equals("Y")) { 
				
				String temp = theMenu.getName();
				
				Data.mlist.remove(theMenu);
				Data.save(DataPath.메뉴);
				
				printTheCategory();
				System.out.printf("⚠️ 메뉴[%s]가 성공적으로 삭제되었습니다.\n", temp);
				System.out.println();
				Output.pause();
				
				loop = false; 
				
			} else if (input.toUpperCase().equals("N")) { 
				
				printTheCategory();
				System.out.println("⚠️ 메뉴 삭제를 취소하였습니다.");
				System.out.println();
				Output.pause();
				
				loop = false; 
					
			} else {
				error = true;		
			}

		}
	}

	/**
	 * 메뉴 카테고리 선택을 입력받는 메소드입니다.
	 * @return 카테고리 선택 여부
	 */
	private boolean chooseCategory(int menu) {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;
		
		while(loop) {
			
			Output.toolStart();
			MenuCategory.startCategory();	
			
			switch (menu) {
				case 1 : System.out.println("[메뉴 등록] 등록할 새로운 메뉴의 카테고리를 입력해주세요"); 
							break;
				case 2 : System.out.println("[메뉴 수정] 수정할 메뉴의 카테고리를 입력해주세요"); 
							break;
				case 3 : System.out.println("[메뉴 삭제] 삭제할 메뉴의 카테고리를 입력해주세요"); 
							break;
			}
			
			alarmError(input + "은 올바른 입력이 아닙니다.");
			
			System.out.print("Select ▶ ");
			input = scan.nextLine();
			this.category = input.toUpperCase().charAt(0);
			
			if(input.length() == 1 && ('1' <= this.category && this.category <= '5')) { 
				return true;
			} else if (input.length() == 1 && this.category == '0') {
				return false;
			} else {
				error = true;		
			}
		}
		
		return false;
	}

	/**
	 * 선택한 카테고리에 해당하는 카테고리 번호를 반환하는 메소드입니다.
	 * @return 카테고리 번호
	 */
	private String findTheCateSeq() {
		
		switch(category) {
			case '1' : return findCategorySeq("커피");		
			case '2' : return findCategorySeq("음료");		
			case '3' : return findCategorySeq("티");	
			case '4' : return findCategorySeq("에이드");		
			case '5' : return findCategorySeq("스무디");		
		}
		
		return null;
	}

	/**
	 * 선택한 카테고리에 해당하는 로고를 출력하는 메소드입니다.
	 */
	private void printTheCategory() {

		switch(category) {  
			case '1' : MenuCategory.basicCoffee(); 		return;
			case '2' : MenuCategory.basicBeverage(); 	return;
			case '3' : MenuCategory.basicTea(); 		return;
			case '4' : MenuCategory.basicAde(); 		return;
			case '5' : MenuCategory.basicSmoothe(); 	return;
		}
		System.out.println();
	}

	/**
	 * 카테고리명에 해당하는 카테고리 번호를 반환하는 메소드입니다.
	 */
	private String findCategorySeq(String name) {
		String cate = Data.catelist.stream()
							.filter(c->c.getName().equals(name))
							.map(c->c.getSeq())
							.collect(Collectors.joining());
		return cate;
	}

	/**
	 * 수정할 메뉴의 새로운 정보를 입력받아 메뉴를 수정하는 메소드입니다.
	 */
	private void modifyTheMenu() {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;
		String name = null;
		String price = null;
		
		while(loop) {
			
			printTheMenu();

			if(name == null) {
				
				System.out.println("새롭게 변경하실 \"메뉴이름\"을 입력해주세요. (변경 안함: Enter)");
				System.out.println();			
				System.out.println();
				System.out.println();
				
				System.out.printf("<변경 전>%s ▶ <변경 후>", theMenu.getName());
				name = scan.nextLine();
				
			} else {
				
				System.out.println("새롭게 변경하실 \"가격\"을 입력해주세요. (변경 안함: Enter)");
				System.out.println();			

				alarmError(price + "은 올바른 가격이 아닙니다. 금액을 입력해주세요.");
				
				System.out.printf("<변경 전>₩%s ▶ <변경 후> ₩", theMenu.getPrice()); 
				price = scan.nextLine();

				try {
	
					if (price.equals("")) { break; }
					
					int temp = Integer.parseInt(price);
					System.out.println(temp);
					
					if (temp >= 0) {
						loop = false;
					} else {
						throw new Exception();
					}

				} catch (Exception e) {
					error= true;
				}
				
			}
		}
		
		
		
		if(name.equals("") && price.equals("")) {
		
			printTheMenu();
			System.out.println();	
			System.out.println("⚠️ 메뉴 정보를 기존과 같이 유지하였습니다.");
			System.out.println();
			Output.pause();
			
		} else {
			
			if(name.equals("")) { name = theMenu.getName(); }
			if(price.equals("")) { price = String.valueOf(theMenu.getPrice()); }
			
			checkModify(name, price);
			
			System.out.printf("▶ <변경 후> %s (₩%s)\n", name, price);
			System.out.println();
			
			if(input.toLowerCase().equals("y")) {
				
				theMenu.setName(name);
				theMenu.setPrice(Integer.parseInt(price));
				
				Data.save(DataPath.메뉴);
				
				printTheMenu();
				System.out.println();
				System.out.println("⚠️ 메뉴 정보를 새롭게 수정하였습니다. ");
				System.out.println();
				Output.pause();
				
			} else if (input.toLowerCase().equals("n")) {
				
				printTheMenu();
				System.out.println();	
				System.out.println("⚠️ 메뉴 정보를 기존과 같이 유지하였습니다.");
				System.out.println();
				Output.pause();
			}
			
		}
	}

	/**
	 * 메뉴를 입력한 새로운 정보로 변경할지 여부를 재확인 하는 메소드입니다.
	 * @param name 메뉴명
	 * @param price 가격
	 */
	private void checkModify(String name, String price) {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;
		this.input = null;
		
		while(loop) {
			
			printTheMenu();
			
			System.out.printf("▶ <변경 후> %s (₩%s)\n", name, price);
			System.out.println();

			alarmError(input+"은 올바르지 않은 입력입니다.");
		
			System.out.print("메뉴정보를 변경하시겠습니까? (y/N) ▶ ");
			input = scan.nextLine();

			if(input.toLowerCase().equals("y")) {
				loop = false;
			} else if (input.toLowerCase().equals("n")) {
				loop = false;
			} else {
				error = true;
			}
		}
	}

	/**
	 * 메뉴 선택을 입력받는 메소드입니다.
	 */
	private void chooseMenu() {
		
		Scanner scan = new Scanner(System.in);
		
		this.loop = true;

		while(loop) {

			printTheCategory();
			
			alarmError(input + "은 올바른 입력이 아닙니다.");
			
			try {
				
				System.out.print("select ▶ ");
				input = scan.nextLine();
				int seq = Integer.parseInt(input);

				if(1<= seq && seq <= MenuCategory.menus.size()) {
					theMenu = MenuCategory.menus.get(seq-1);
					loop = false;
				} else {
					error = true;
				}
				
			} catch (Exception e) {
				error = true;
			}
		}
	}

	/** 
	 * 메뉴 수정 시 선택한 메뉴에 대한 기존 정보를 출력하는 메소드입니다.
	 */
	private void printTheMenu() {
		Output.toolStart();
		System.out.println();
		
		printASCIImodify();
		System.out.println("  ───────────────────────────────────────────────────");	
		System.out.println();
		
		String categoryName = null;
		
		for(Category c : Data.catelist) {
			if(c.getSeq().equals(theMenu.getCseq())) {
				categoryName = c.getName();
			}
		}
		
		System.out.println("▶ 선택한 메뉴 정보");
		System.out.println();
		
		System.out.println("\t- 카테고리: " + categoryName);
		System.out.println("\t- 메뉴번호: " + theMenu.getSeq());
		System.out.println("\t- 메뉴이름: " + theMenu.getName());
		System.out.println("\t- 메뉴가격: ₩" + theMenu.getPrice());
		System.out.println();

		Output.toolEnd();
		System.out.println();
	}
	
	/**
	 * 입력값이 올바르지 않았을 때 에러 메시지를 출력하는 메소드입니다.
	 * @param message 입력값
	 */
	private void alarmError(String message) {
		
		if(error) {
			System.out.println("⚠️ " + message);  
			error = false;
		} else {
			System.out.println();
		}
		
		System.out.println();
	}

	
	/**
	 * 관리자가 메뉴 관리 모드에 진입하면 나타나는 메인화면을 출력하는 메소드입니다.
	 */
	private static void printMenu() {
		
		Output.toolStart();
		Calendar now = Calendar.getInstance();
		System.out.print("\t\t\t");
		System.out.printf("%tF %s:%s %tA\n", 
							now, now.get(Calendar.HOUR_OF_DAY),now.get(Calendar.MINUTE), now);
		System.out.println();
	
		
		System.out.println("       _______. _______ .___________.\r\n"
				+ "      /       ||   ____||           |\r\n"
				+ "     |   (----`|  |__   `---|  |----`\r\n"
				+ "      \\   \\    |   __|      |  |\r\n"
				+ "  .----)   |   |  |____     |  |\r\n"
				+ "  |_______/    |_______|    |__|");
		System.out.println("\t.___  ___.  _______ .__   __.  __    __\r\n"
				+ "\t|   \\/   | |   ____||  \\ |  | |  |  |  |\r\n"
				+ "\t|  \\  /  | |  |__   |   \\|  | |  |  |  |\r\n"
				+ "\t|  |\\/|  | |   __|  |  . `  | |  |  |  |\r\n"
				+ "\t|  |  |  | |  |____ |  |\\   | |  `--'  |\r\n"
				+ "\t|__|  |__| |_______||__| \\__|  \\______/\r\n"
				+ "");
		System.out.println("  ───────────────────────────────────────────────────");
		System.out.println();
		System.out.println("\t\t1. 메뉴 등록 (add)");
		System.out.println();
		System.out.println("\t\t2. 메뉴 수정 (modify)");
		System.out.println();
		System.out.println("\t\t3. 메뉴 삭제 (delete)");
		System.out.println();
		System.out.println("\t\t0. 뒤로");
		System.out.println();
		Output.toolEnd();
		System.out.println();
	}
	
	/**
	 * 관리자가 메뉴 수정 모드에 진입하면 나타나는 로고를 출력하는 메소드입니다.
	 */
	private void printASCIImodify() {
		System.out.println(".______     _______      _______. _______ ._________.\r\n"
				+ "|   _  \\   |   ____|    /       ||   ____||           |\r\n"
				+ "|  |_)  |  |  |__      |   (----`|  |__   `---|  |--`\r\n"
				+ "|      /   |   __|      \\   \\    |   __|      |  |\r\n"
				+ "|  |\\  \\--.|  |____ .----)   |   |  |____     |  |\r\n"
				+ "| _| `.___||_______||_______/    |_______|    |__|");
		System.out.println(".___  ___.  _______ .__   __.  __    __\r\n"
				+ "|   \\/   | |   ____||  \\ |  | |  |  |  |\r\n"
				+ "|  \\  /  | |  |__   |   \\|  | |  |  |  |\r\n"
				+ "|  |\\/|  | |   __|  |  . `  | |  |  |  |\r\n"
				+ "|  |  |  | |  |____ |  |\\   | |  `--'  |\r\n"
				+ "|__|  |__| |_______||__| \\__|  \\______/\r\n"
				+ "");
	}

}
