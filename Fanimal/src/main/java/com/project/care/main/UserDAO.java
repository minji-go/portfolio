package com.project.care.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

import com.project.care.DBUtil;
import com.project.care.dto.LoginDTO;
import com.project.care.dto.UserDTO;

public class UserDAO {

	Connection conn;
	PreparedStatement pstat;
	Statement stat;
	ResultSet rs;
	
	public UserDAO () {
		conn = DBUtil.open();
	}

	public UserDTO userLogin(LoginDTO dto) {
		try {
			String sql = "select * from tblUser where id = ? and password = ?";
			
			pstat = conn.prepareStatement(sql);
			
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				UserDTO userdto = new UserDTO();
				
				userdto.setId(rs.getString("id"));
				userdto.setName(rs.getString("name"));
				userdto.setNickname(rs.getString("nickname"));
				userdto.setPassword(rs.getString("password"));
				userdto.setTel(rs.getString("tel"));
				userdto.setAddress(rs.getString("address"));
				userdto.setJoindate(rs.getString("joindate"));
				userdto.setXcoor(rs.getString("xcoor"));
				userdto.setYcoor(rs.getString("ycoor"));
				
				return userdto;
			}
			
		} catch (Exception e) {
			System.out.println("UserDAO.userLogin");
			e.printStackTrace();
		}
		return null;
	}

	public String findId(HashMap<String, String> map) {
		try {
			//회원 아이디 찾기
			String sql = "select * from tblUser where name = ? and tel = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("name"));
			pstat.setString(2, map.get("tel"));
			
			rs = pstat.executeQuery();
			
			if(rs.next()) { // 아이디 있으면 아이디 반환
				return rs.getString("id"); 
			}
		} catch (Exception e) {
			System.out.println("UserDAO.findId");
			e.printStackTrace();
		}
		return null;
	}

	public String findPassword(HashMap<String, String> map) {
		try {
			String sql = "select * from tblUser where name = ? and id = ? and tel = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("name"));
			pstat.setString(2, map.get("id"));
			pstat.setString(3, map.get("tel"));
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				return rs.getString("password");
			}
		} catch (Exception e) {
			System.out.println("UserDAO.findPassword");
			e.printStackTrace();
		}
		return null;
	}

	public int updatePassword(HashMap<String, String> map) {
		try {
			String sql = "update tblUser set password = ? where id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("password"));
			pstat.setString(2, map.get("id"));
			
			return pstat.executeUpdate();
		} catch (Exception e) {
			System.out.println("UserDAO.updatePassword");
			e.printStackTrace();
		}
		return 0;
	}
	
}
