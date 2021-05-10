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
			
			//댓글 작성할 때 comment_vote 테이블에도 같이 넣어주도록 한다. 
			sql = "insert into comment_vote(bid, cm_id, up_vote,down_vote) values(? , ? , 0 , 0) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num+1);
			pstmt.setInt(2, cb.getBid());
			
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
		// 이거를 DB에서 지워버리는 대신 삭제된 댓글입니다. 하는 식으로 처리하기? 
		// 만약 지운다고 한다면 comment_vote, comment_vote_record 테이블에서도 같이 작업이 필요하다. 
		
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
	
	
	//댓글 추천 여부 확인 함수 
	public boolean isVoted(CommentBean cb , String uid ){ 
		conn = getConnection(); 
		String sql = "select uid from comment_vote_record where bid=? and cm_id =? and uid=? ";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, cb.getCm_id());
			pstmt.setString(3, uid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				return false; 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		
		return true; 
	} //댓글 추천 여부 확인 함수  
	
	
	//댓글 추천 관리 함수
	public boolean updownvote(CommentBean cb, String uid , int updown){
		if(isVoted(cb , uid)){
			conn = getConnection();
			String sql = ""; 
			
			if(updown > 0){
				sql = "update comment_vote set upvote = upvote+1 where bid=? and cm_id=?" ; 
			}else{
				sql = "update comment_vote set downvote = downvote+1 where bid=? and cm_id=?" ;
			}
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cb.getBid());
				pstmt.setInt(2, cb.getCm_id());
				pstmt.executeQuery(); 
				
				sql = "insert into comment_vote_record values(?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cb.getBid());
				pstmt.setInt(2, cb.getCm_id());
				pstmt.setString(3,uid) ; 
				pstmt.executeQuery();
				
			} catch (SQLException e) {
				e.printStackTrace();
				return false ; 
			} finally{
				dbClose();
			}
			
			return true; 
		}else{
			// 다른 값을 주는게 좋으려나. 
			// 이미 추천된 경우로 가야하긴 한데. 
			// SQLException과는 다른 형태로 반환해주는 것이 좋을까. 
			return false; 
		}
	} //댓글 추천 관리 함수 끝.
	

}
