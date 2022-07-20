package com.project.care.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

import com.project.care.DBUtil;
import com.project.care.dto.CompanyDTO;
import com.project.care.dto.LoginDTO;

public class CompanyDAO {

	Connection conn;
	PreparedStatement pstat;
	Statement stat;
	ResultSet rs;
	
	public CompanyDAO () {
		conn = DBUtil.open();
	}

	public CompanyDTO companyLogin(LoginDTO dto) {
		try {
			String sql = "select * from tblCompany where id = ? and password = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				CompanyDTO companydto = new CompanyDTO();
				
				companydto.setId(rs.getString("id"));
				companydto.setName(rs.getString("name"));
				companydto.setTel(rs.getString("tel"));
				companydto.setAddress(rs.getString("address"));
				companydto.setXcoor(rs.getString("xcoor"));
				companydto.setYcoor(rs.getString("ycoor"));
				companydto.setBusiness(rs.getString("business"));
				companydto.setPassword(rs.getString("password"));
				
				return companydto;
			}
		} catch (Exception e) {
			System.out.println("CompanyDAO.companyLogin");
			e.printStackTrace();
		}
		return null;
	}

	public String findId(HashMap<String, String> map) {
		try {
			String sql = "select * from tblCompany where name = ? and tel = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("name"));
			pstat.setString(2, map.get("tel"));
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				return rs.getString("id");
			}
		} catch (Exception e) {
			System.out.println("CompanyDAO.findId");
			e.printStackTrace();
		}
		return null;
	}

	public String findPassword(HashMap<String, String> map) {
		try {
			String sql = "select * from tblCompany where name = ? and tel = ? and id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("name"));
			pstat.setString(2, map.get("tel"));
			pstat.setString(3, map.get("id"));
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				return rs.getString("password");
			}
		} catch (Exception e) {
			System.out.println("CompanyDAO.findPassword");
			e.printStackTrace();
		}
		return null;
	}

	public int updatePassword(HashMap<String, String> map) {
		try {
			String sql = "update tblCompany set password = ? where id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, map.get("password"));
			pstat.setString(2, map.get("id"));
			
			return pstat.executeUpdate();
		} catch (Exception e) {
			System.out.println("CompanyDAO.updatePassword");
			e.printStackTrace();
		}
		return 0;
	}
}
