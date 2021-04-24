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
