package com.project.care;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	
	private static Connection conn;

	public static Connection open() {
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "team";
		String pw = "java1234";
	
		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection(url, id, pw);
			
			return conn;
			
		} catch (Exception e) {
			System.out.println("DBUtil.open");
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	public static void close() {
		
		try {
			conn.close();
		} catch (Exception e) {
			System.out.println("DBUtil.close");
			e.printStackTrace();
		}
	}
	
}
