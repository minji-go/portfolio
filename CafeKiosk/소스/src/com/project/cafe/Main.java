package com.project.cafe;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Calendar;
import java.util.Scanner;
import com.project.cafe.admin.AdminMain;
import com.project.cafe.dataClass.Customer;
import com.project.cafe.dataClass.Stamp;
import com.project.cafe.order.CartOrder;
import com.project.cafe.order.FastOrder;
import com.project.cafe.order.NormalOrder;

/**
 * 프로그램의 시작시 동작하는 기능을 구현하는 클래스입니다.
 * @author 고민지
 * @author 고수경
 * @author 김승연
 */
public class Main {

	public static Customer currentLogin;
	public static String adminPW;
	
	/**
	 * 고객 모드의 주문 및 장바구니 기능과 관리자 모드 진입 흐름을 통제하는 메소드입니다.
	 */
	public static void main(String[] args) {
		
		Data.load(); 
		

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
			}
			
			System.out.println();
			System.out.print("Select ▶ ");

			input = scan.nextLine();
		
			
		
			if(input.equals("1")) {
				NormalOrder n = new NormalOrder();
				n.work();
			} else if (input.equals("2")) {
				FastOrder f = new FastOrder();
				f.work();
			} else if (input.equals("3")) { 
				CartOrder c = new CartOrder();
				c.main();
			} else if (input.startsWith("#")) {
				
				if(adminLogin(input)) {
					AdminMain m = new AdminMain();
					m.main();
					
				} else {
					input = "⚠️ 관리자모드 로그인에 실패하였습니다.";
					error = true;
				}
				
			} else if (input.equals("*")) {
				loop = false; //강제종료
			} else {
				input = "⚠️ " + input + "은(는) 잘못된 접근입니다.";
				error = true;
			}
				
		}
			
	}
	

	/**
	 * 고객의 전화번호가 올바른지 확인하여 저장하는 메소드입니다.
	 */
	public static boolean customerLogin(String input) { 
		
		if(input.startsWith("010")) {
			input = input.substring(3);
		}
		
		char[] temp = input.toCharArray();

		String tel = "010-";
		
		for(char c : temp) {
			if('0' <= c && c <='9') { tel += c; }
			if(tel.length() == 8) {	tel += "-"; }
		}
	
		if(tel.length() == 13) {
			
			for(Customer c : Data.clist) {
				if(c.getTel().equals(tel)) { currentLogin = c; }
			}
			
			if(currentLogin == null) {
				
				currentLogin = new Customer(FindData.nextSeq(Data.clist), tel);
				Data.clist.add(currentLogin);
				Data.slist.add(new Stamp(FindData.nextSeq(Data.slist), currentLogin.getSeq(), "0"));
				Data.save(DataPath.고객);
				Data.save(DataPath.적립);
			}
			return true;
		}
		
		return false;
	}	

	
	/**
	 * 관리자 모드로 진입하기 위해 입력한 비밀번호가 올바른지 확인하는 메소드입니다.
	 */
	public static boolean adminLogin(String password) {
		try {
			
			BufferedReader reader = new BufferedReader(new FileReader("src\\com\\project\\cafe\\data\\관리자.txt"));
			
			String line = null;
			
			while ((line = reader.readLine()) != null) {
				adminPW = line;
			}
			
			if(password.replace("#","").equals(adminPW)) {
				return true;
			}
			
			reader.close();
		
		} catch (Exception e) {
			System.out.println("Main.adminLogin");
			e.printStackTrace();
		}
		return false; //틀릴경우
	}

	/**
	 * 초기화면의 모습을 출력하는 메소드입니다.
	 */
	private static void printMenu() {
		
		Output.toolStart();
		Calendar now = Calendar.getInstance();
		System.out.print("\t\t");
		System.out.printf("     %tF %s:%s %tA  [*.종료]\n", 
							now, now.get(Calendar.HOUR_OF_DAY),now.get(Calendar.MINUTE), now);
		System.out.println();
	
		
		System.out.println("\r\n"
				+ "\t  ______    ______   ________  ________ \r\n"
				+ "\t /      \\  /      \\ /        |/        |\r\n"
				+ "\t/$$$$$$  |/$$$$$$  |$$$$$$$$/ $$$$$$$$/ \r\n"
				+ "\t$$ |  $$/ $$ |__$$ |$$ |__    $$ |__    \r\n"
				+ "\t$$ |      $$    $$ |$$    |   $$    |   \r\n"
				+ "\t$$ |   __ $$$$$$$$ |$$$$$/    $$$$$/    \r\n"
				+ "\t$$ \\__/  |$$ |  $$ |$$ |      $$ |_____ \r\n"
				+ "\t$$    $$/ $$ |  $$ |$$ |      $$       |\r\n"
				+ "\t $$$$$$/  $$/   $$/ $$/       $$$$$$$$/ \r\n"
				+ "");
		System.out.print("\n\n\n");
		System.out.println("\t\t1. 일반 주문 (Order)");
		System.out.println();
		System.out.println("\t\t2. 빠른 주문 (Custom Order)");
		System.out.println();
		System.out.printf("\t\t3. 장바구니 🛒[%d]\n", CartOrder.cart.size());
		System.out.println("\n\n");
		System.out.println("\t🔒 관리자 모드는 \"# + 비밀번호\"를 입력해주세요.");
		System.out.println();
		Output.toolEnd();
		
	}
	
	

}
