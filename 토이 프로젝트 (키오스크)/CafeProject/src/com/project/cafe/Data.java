package com.project.cafe;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;

import com.project.cafe.dataClass.Category;
import com.project.cafe.dataClass.CustomMenu;
import com.project.cafe.dataClass.Customer;
import com.project.cafe.dataClass.Menu;
import com.project.cafe.dataClass.Option;
import com.project.cafe.dataClass.Order;
import com.project.cafe.dataClass.Stamp;
/**
 * 외부 데이터 파일을 불러오거나 저장하는 클래스입니다.
 * @author 고수경
 *
 */
public class Data {
	
	public static ArrayList<Category> catelist = new ArrayList<Category>();
	public static ArrayList<Customer> clist = new ArrayList<Customer>();
	public static ArrayList<CustomMenu> cmlist = new ArrayList<CustomMenu>();
	public static ArrayList<Menu> mlist = new ArrayList<Menu>();
	public static ArrayList<Order> olist = new ArrayList<Order>();
	public static ArrayList<Stamp> slist = new ArrayList<Stamp>();
	
	public static ArrayList<Option> shotlist = new ArrayList<Option>(); //샷추가
	public static ArrayList<Option> srlist = new ArrayList<Option>(); //시럽
	public static ArrayList<Option> icelist = new ArrayList<Option>(); //얼음
	public static ArrayList<Option> tlist = new ArrayList<Option>(); //토핑
	public static ArrayList<Option> wlist = new ArrayList<Option>(); //휘핑
	
	/**
	 * 공통으로 사용되는 외부 데이터 파일 전체를 불러오는 메소드입니다.
	 */
	
	public static void load() {
		load(DataPath.카테고리);
		load(DataPath.고객);
		load(DataPath.커스텀메뉴);
		load(DataPath.메뉴);
		load(DataPath.주문내역);
		load(DataPath.적립);
			
		load(DataPath.샷추가);
		load(DataPath.시럽);
		load(DataPath.얼음량);
		load(DataPath.토핑);
		load(DataPath.휘핑);
	}
	/**
	 * 특정한 외부 데이터 파일을 불러오는 메소드입니다.
	 * @param path 외부 데이터 파일 경로
	 */
	public static void load(String path) {
		try {
			BufferedReader reader = new BufferedReader(new FileReader(path));

			String line = null;
			
			while ((line = reader.readLine()) != null) {
				
				String[] temp = line.split(",");
				
				if(DataPath.카테고리.equals(path)) {
					catelist.add(카테고리(temp));
				}else if(DataPath.고객.equals(path)) {
					clist.add(고객(temp));
				}else if(DataPath.커스텀메뉴.equals(path)) {
					cmlist.add(커스텀메뉴(temp));
				}else if(DataPath.메뉴.equals(path)) {
					mlist.add(메뉴(temp));
				}else if(DataPath.주문내역.equals(path)) {
					olist.add(주문내역(temp));
				}else if(DataPath.적립.equals(path)) {
					slist.add(적립(temp));
					
					
				}else if(DataPath.샷추가.equals(path)) {
					shotlist.add(샷추가(temp));
				}else if(DataPath.시럽.equals(path)) {
					srlist.add(시럽(temp));
				}else if(DataPath.얼음량.equals(path)) {
					icelist.add(얼음량(temp));
				}else if(DataPath.토핑.equals(path)) {
					tlist.add(토핑(temp));
				}else if(DataPath.휘핑.equals(path)) {
					wlist.add(휘핑(temp));
				}
				
			}
			reader.close();
			
			
		} catch (Exception e) {
			System.out.println("Data.load");
			e.printStackTrace();
		}
	}
	
	/**
	 * 외부 데이터 파일에 정보를 저장하는 메소드입니다.
	 * @param path 파일경로
	 */
	public static void save(String path) {
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter(path));
			
			if(DataPath.카테고리.equals(path)) {
				save카테고리(writer);
			}else if(DataPath.고객.equals(path)) {
				save고객(writer);
			}else if(DataPath.커스텀메뉴.equals(path)) {
				save커스텀메뉴(writer);
			}else if(DataPath.메뉴.equals(path)) {
				save메뉴(writer);
			}else if(DataPath.주문내역.equals(path)) {
				save주문내역(writer);
			}else if(DataPath.적립.equals(path)) {
				save적립(writer);
			}
			
			writer.close();
			
			
		} catch (Exception e) {
			System.out.println("Data.save");
			e.printStackTrace();
		}
	}
	
	
	private static Category 카테고리(String[] temp) {
		return new Category(temp[0],temp[1]);
	}
	private static Customer 고객(String[] temp) {
		return new Customer(temp[0],temp[1]);
	}
	private static CustomMenu 커스텀메뉴(String[] temp) {
		return new CustomMenu(temp[0],temp[1],temp[2],temp[3],temp[4],temp[5],temp[6],temp[7]);
	}
	private static Menu 메뉴(String[] temp) {
		return new Menu(temp[0],temp[1],Integer.parseInt(temp[2]),temp[3]);
	}
	private static Order 주문내역(String[] temp) {
		return new Order(temp[0],temp[1],temp[2],temp[3]);
	}
	private static Stamp 적립(String[] temp) {
		return new Stamp(temp[0],temp[1],temp[2]);
	}
	private static Option 샷추가(String[] temp) {
		return new Option(temp[0],temp[1],Integer.parseInt(temp[2]));
	}
	private static Option 시럽(String[] temp) {
		return new Option(temp[0],temp[1],Integer.parseInt(temp[2]));
	}
	private static Option 얼음량(String[] temp) {
		return new Option(temp[0],temp[1],Integer.parseInt(temp[2]));
	}
	private static Option 토핑(String[] temp) {
		return new Option(temp[0],temp[1],Integer.parseInt(temp[2]));
	}
	private static Option 휘핑(String[] temp) {
		return new Option(temp[0],temp[1],Integer.parseInt(temp[2]));
	}
	
	private static void save카테고리(BufferedWriter writer) throws Exception  {

		for(Category c : catelist) {
			String line = String.format("%s,%s\n"
										, c.getSeq()
										, c.getName());
					
			writer.write(line);
		}
	}
	
	
	private static void save고객(BufferedWriter writer) throws Exception  {

		for(Customer cus : clist) {
			String line = String.format("%s,%s\n"
										, cus.getSeq()
										, cus.getTel());
					
			writer.write(line);
		}
	}
	
	private static void save커스텀메뉴(BufferedWriter writer) throws Exception  {

		for(CustomMenu cm : cmlist) {
			String line = String.format("%s,%s,%s,%s,%s,%s,%s,%s\n"
										,cm.getSeq()
										,cm.getClientSeq()
										,cm.getMenuSeq()
										,cm.getIceSeq()
										,cm.getSyrupSeq()
										,cm.getShotSeq()
										,cm.getWhippingSeq()
										,cm.getToppingSeq());
					
			writer.write(line);
		}
	}
	
	private static void save메뉴(BufferedWriter writer) throws Exception  {

		for(Menu m : mlist) {
			String line = String.format("%s,%s,%d,%s\n"
										,m.getSeq()
										,m.getName()
										,m.getPrice()
										,m.getCseq());
					
			writer.write(line);
		}
	}
	
	private static void save주문내역(BufferedWriter writer) throws Exception  {

		for(Order o : olist) {
			String line = String.format("%s,%s,%s,%s\n"
										,o.getSeq()
										,o.getMenuSeq()
										,o.getsOrderDate()
										,o.getCustomerSeq());
					
			writer.write(line);
		}
	}
	
	private static void save적립(BufferedWriter writer) throws Exception  {

		for(Stamp s : slist) {
			String line = String.format("%s,%s,%s\n"
										,s.getSeq()
										,s.getCumstomerSeq()
										,s.getStamp());
					
			writer.write(line);
		}
	}
	
	
	
	
	
}

