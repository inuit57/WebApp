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

import com.itwillbs.dao.ObjectDAO;

public class CommentDAO extends ObjectDAO{

	
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
		
	}//getCommentList 
	
	public boolean updateComment(CommentBean cb){
		conn = getConnection(); 
		String sql = "update comment set content = ? where bid=? and cm_id=?"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cb.getContent());
			pstmt.setInt(2, cb.getBid());
			pstmt.setInt(3, cb.getCm_id());
			
			pstmt.executeUpdate(); 
			// 댓글 수정 완료 
			System.out.println("댓글 수정 완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false ; 
		} finally {
			dbClose();
		}
		
		return true; 
	} // updateComment() 
	
	public boolean deleteComment(CommentBean cb){
		conn = getConnection(); 
		String sql = "delete from comment where bid=? and cm_id=?"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, cb.getCm_id());
			
			pstmt.executeUpdate(); 
			// 댓글 삭제 완료 
			System.out.println("댓글 삭제 완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false ; 
		} finally {
			dbClose();
		}
		
		return true; 
	} // deleteComment
}
