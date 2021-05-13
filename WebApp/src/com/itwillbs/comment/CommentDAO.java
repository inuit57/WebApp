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

	public CommentBean getComment(int cm_id){
		CommentBean cb = null; 
		conn = getConnection() ; 
		
		String sql = "select * from comment where cm_id = ?"; 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cm_id);
			ResultSet rs= pstmt.executeQuery();
			
			if(rs.next()){
				cb = new CommentBean(); 
				cb.setBid(rs.getInt("bid"));
				cb.setCm_id(rs.getInt("cm_id"));
				cb.setContent(rs.getString("content"));
				cb.setUid(rs.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null; 
		}finally {
			dbClose();
		}
		
		return cb; 
	} //getComment(int cm_id){
	
	public int getCommentCnt(String uid){
		conn = getConnection();
		try {
			String sql = "select count(cm_id) from comment where uid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				return rs.getInt(1); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return 0 ; 
	} // getCommentCnt(String uid){
	
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
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, num+1);
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
		//String sql = "select * from comment where bid= ? ";
		String sql = "select c.* , cv.up_vote as upvote, cv.down_vote as downvote "
					 + "from comment c join comment_vote cv on c.cm_id = cv.cm_id where c.bid= ?" ; 
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
				cb.setUpvote(rs.getInt("upvote"));
				cb.setDownvote(rs.getInt("downvote"));
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
	
	public ArrayList<CommentBean> getBestCommentList(int bid){
		ArrayList<CommentBean> arrCb = new ArrayList<>();
		conn = getConnection(); 
		CommentBean cb = null ; 
		//String sql = "select * from comment where bid= ? ";
		String sql = "select c.* , cv.up_vote as upvote, cv.down_vote as downvote "
					 + "from comment c join comment_vote cv on c.cm_id = cv.cm_id "
					 +" where c.bid= ? and  cv.up_vote  >=  cv.down_vote + 10 order by cv.up_vote desc limit 3" ; 
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
				cb.setUpvote(rs.getInt("upvote"));
				cb.setDownvote(rs.getInt("downvote"));
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
		 
		// String sql = "delete from comment where bid=? and cm_id=?";
		// 이거를 DB에서 지워버리는 대신 삭제된 댓글입니다. 하는 식으로 처리하기? 
		// comment_vote, comment_vote_record 테이블에서 먼저 지워주는 작업이 필요하다.
		
		String sql =""; 
		try {
			// 댓글 추천 기록 관리하는 테이블에서 삭제 
			sql = "delete from comment_vote_record where bid=? and cm_id=?";	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, cb.getCm_id());
			
			pstmt.executeUpdate();
			
			//댓글 추천수 테이블에서도 삭제 
			sql = "delete from comment_vote where bid=? and cm_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, cb.getCm_id());
			
			pstmt.executeUpdate();
			
			//마지막으로 comment 테이블에서 삭제 진행 
			sql = "delete from comment where bid=? and cm_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getBid());
			pstmt.setInt(2, cb.getCm_id());
			
			pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("댓글 삭제 실패 ");
			return false ; 
		} finally{
			dbClose();
		}
		
		//마지막으로 comment 테이블에서 삭제 진행 
		//이 부분은 이후에 답글 기능 넣게 되면 변경해놓을 예정. 
		//댓글의 삭제 동작을 답글 기능 추가한 뒤 변경하게 된다면 이 부분도 약간 수정이 필요할 수도 있다.
		
		// 
//		sql = "delete from comment where bid=? and cm_id=?";
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, cb.getBid());
//			pstmt.setInt(2, cb.getCm_id());
//			
//			pstmt.executeUpdate(); 
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			System.out.println("댓글 삭제 실패 ");
//			return false; 
//		}finally{
//			dbClose();
//		}
//
		// 댓글 삭제 완료 
		System.out.println("댓글 삭제 완료");
		
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
				sql = "update comment_vote set up_vote = up_vote+1 where bid=? and cm_id=?" ; 
			}else{
				sql = "update comment_vote set down_vote = down_vote+1 where bid=? and cm_id=?" ;
			}
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cb.getBid());
				pstmt.setInt(2, cb.getCm_id());
				pstmt.executeUpdate(); 
				
				sql = "insert into comment_vote_record values(?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cb.getBid());
				pstmt.setInt(2, cb.getCm_id());
				pstmt.setString(3,uid) ; 
				pstmt.executeUpdate();
				
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
