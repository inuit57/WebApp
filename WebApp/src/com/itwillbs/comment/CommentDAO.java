package com.itwillbs.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CommentDAO {

	Connection conn ; 
	PreparedStatement pstmt ; 
	
	public Connection getConnection(){
		Context initCTX;
		try {
			initCTX = new InitialContext();
			DataSource ds = (DataSource)initCTX.lookup("java:comp/env/jdbc/mysqlDB");
				
			try {
				conn = ds.getConnection();
				
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
	
	public boolean insertComment(CommentBean cb){
		int num = 0 ; 
		try {
			conn = getConnection(); 
			
			String sql = "select max(cm_id) from comment"; 
			pstmt = conn.prepareStatement(sql); 
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1); 
			}else{
				num = 0; 
			}
				
			System.out.println(num+1);
			System.out.println(cb.getBid());
			System.out.println(cb.getUid());
			System.out.println(cb.getContent());
			
			sql = "insert into comment values(?, ? , ? , ? ) "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num+1);
			pstmt.setInt(2, cb.getBid());
			pstmt.setString(3, cb.getUid());
			pstmt.setString(4, cb.getContent());
			
			pstmt.executeUpdate();
			
			System.out.println("댓글 작성 완료!"); 
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
		} finally {
			dbClose();
		}
		
		return true; 
	} // insertComment
	
	public ArrayList<CommentBean> getCommentList(int bid){
		ArrayList<CommentBean> arrCb = new ArrayList<>();
		conn = getConnection(); 
		CommentBean cb = null ; 
		String sql = "select * from comment where bid= ? "; 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				cb = new CommentBean(); 
				//cb.setBid(bid);
				cb.setCm_id(rs.getInt("cm_id"));
				cb.setContent(rs.getString("content"));
				cb.setUid(rs.getString("uid"));
				arrCb.add(cb); 
			}
			//System.out.println("댓글 갯수 총 "+ arrCb.size()+"개");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbClose();
		} 
		
		return arrCb; 
		
	}
}
