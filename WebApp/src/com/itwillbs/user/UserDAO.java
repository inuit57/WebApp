package com.itwillbs.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UserDAO {

	private UserBean ub ;
	//UserBean ub = new UserBean.Builder().build(); 
	// 이렇게 하면 그냥 빈 객체 생성된다. 
	private Connection conn ; 
	private PreparedStatement pstmt; 
	
	//연결 설정
	private Connection getConnection(){
		Context initCTX;
		try {
			initCTX = new InitialContext();
			DataSource ds = (DataSource)initCTX.lookup("java:comp/env/jdbc/mysqlDB");
			
			
			try {
				conn = ds.getConnection();
				System.out.println("연결 성공!");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		} catch (NamingException e) {
			
			e.printStackTrace();
		} 
		
		return conn ; 
	} //getConnection(); 
	
	public void dbClose(){
		try {
			if(conn!= null){
				pstmt.close();
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} //dbClose(); 
	
	// id로 User얻어오기
	public boolean UserCheck(String id,String pwd){
		try {
			conn = getConnection();
			
			String sql = "select count(*) from userInfo where id=? and pwd=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				return true; 
			}else{
				return false; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		return false;
		 
	}
	
	public boolean UserCheck(String id){
		try {
			conn = getConnection();
			
			String sql = "select count(*) from userInfo where id=?";  
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				return true; 
			}else{
				return false; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		 
		return false ; 
	}
	
	public UserBean getUserBean(String id){
		try {
			conn = getConnection();
			
			String sql = "select * from userInfo where id=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				ub = new UserBean.Builder().
						id(rs.getString("id")).
						pwd(rs.getString("pwd")).
						name(rs.getString("name")).
						addr(rs.getString("addr")).
						age(rs.getInt("age")).
						email(rs.getString("email")).
						gender(rs.getString("gender")).
						userGrant(rs.getInt("userGrant")).
						signInDate(rs.getDate("signInDate")).
						build();
			}else{
				return null; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		System.out.println(ub); 
		return ub ; 
	}
}
