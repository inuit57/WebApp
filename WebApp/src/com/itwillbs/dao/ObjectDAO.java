package com.itwillbs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ObjectDAO {
	protected Connection conn ; 
	protected PreparedStatement pstmt ; 
	
	public Connection getConnection(){
		Context initCTX;
		try {
			initCTX = new InitialContext();
			DataSource ds = (DataSource)initCTX.lookup("java:comp/env/jdbc/mysqlDB");
				
			try {
				conn = ds.getConnection();
				//System.out.println("board 연결 성공!");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		} catch (NamingException e) {
			
			e.printStackTrace();
		} 
		
		return conn ; 
	} // getConnection 
	
	public void dbClose(){
		if(conn!= null){
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
	}// dbClose
}
