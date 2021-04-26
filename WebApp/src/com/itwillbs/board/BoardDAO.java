package com.itwillbs.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {
	Connection conn ; 
	PreparedStatement pstmt ; 
	
	public Connection getConnection(){
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
	
	
	public boolean insertBoard(BoardBean bb){
		int num =0 ; 
		try {
			conn = getConnection(); 
			
			//게시판 번호 구하기 시작. 
			String sql = "select max(bid) from board" ; 
		
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery(); 
			
			if(rs.next()){
				num = rs.getInt(1) +1 ; 
			}
			//게시판 번호 구하기 끝. 
			
			//게시판에 글 넣기 시작.
			sql = "insert into board values( " +
					" ? , ?, ? , ? , ? , ? , ? , now() ) "; 
					//bid, uid, bsubject , btype,  bcontent, ref_id, comment_id	
		
			pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getUid());
			pstmt.setString(3, bb.getBsubject());
			pstmt.setString(4, bb.getBtype());
			pstmt.setString(5, bb.getBcontent());
			pstmt.setInt(6, bb.getRef_id());
			pstmt.setInt(7, bb.getComment_id());
			// 게시판에 글 넣기 끝. 
			
			pstmt.executeUpdate(); //
			System.out.println("작성완료!");
			
			return true ; 
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return false; 
	} //insertBoard(BoardBean bb)
	
	public ArrayList<BoardBean> getBoardList(){
		ArrayList<BoardBean> arrBB = new ArrayList<>(); 
		
		try {
			conn = getConnection(); 
			String sql = "select * from board order by bid desc"; 
		
		
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery(); 
			BoardBean bb = null ; 
			while(rs.next()){
				bb = new BoardBean(); 
				bb.setBcontent(rs.getString("bcontent"));
				bb.setBid(rs.getInt("bid"));
				bb.setBsubject(rs.getString("bsubject"));
				bb.setBtype(rs.getString("btype"));
				bb.setUid(rs.getString("uid"));
				bb.setComment_id(rs.getInt("comment_id"));
				bb.setRef_id(rs.getInt("ref_id"));
				bb.setBdate(rs.getDate("bdate"));
				
				arrBB.add(bb); 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		
		return arrBB; 
	}
}
