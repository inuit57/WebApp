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
				
				cb.setRef(rs.getInt("ref"));
				cb.setLev(rs.getInt("lev"));
				cb.setAlive(rs.getInt("alive"));
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
			String sql = "select count(cm_id) from comment where uid = ? and alive = 1";
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
				
			
			// 추가로 답글인지 여부를 여기에서 확인해볼 필요가 있다. 
			// lev을 다르게 변경해야 한다는 이야기입니다. 
			// ref도 말이죠. 
			
			int parent_cm_id = cb.getRef(); 
			sql = "select lev,ref from comment where cm_id = ? "; 			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, parent_cm_id); // 답글이 아닌 경우에는 0을 준다. 
			rs = pstmt.executeQuery(); 
			if(rs.next()){ // 답글인 경우 
				cb.setLev(rs.getInt("lev")+1);
				
				int ref_tmp = rs.getInt("ref"); 
				int lev_tmp = rs.getInt("lev")+1; 
				
				// max를 구하려는 것은 부모로부터 댓글 여러 개를 달았을 때
				// 제일 아래에 달리게 하려는 목적이다. 
				
				// 근데 이렇게 접근하면 중간에 댓글을 넣어주는 것이 조금 꼬일 수 있다. 
				// 중간에 넣어주려고 한다면 바로 위의 부모 rel + 1 을 넣는 식으로 가야만 한다. 
				
				// 중간에 넣는 것을 어떻게 구분할 수 있을까. 
				// 쿼리를 다르게 써야만 할 거 같네 이건. 
				// ... 해당 lev에 다른 것이 있는지를 확인하는 식으로 처리해야 할듯. 
				
				// lev을 사용하면 되려나. 같은 lev에서 마지막으로 접근한다면 어떨까. 
				// lev : 1 - max(rel)로 접근
				// lev : 2 - 
				
				sql = "select count(*) from comment where ref = ? and lev= ? "; 
				pstmt = conn.prepareStatement(sql); 
				pstmt.setInt(1, ref_tmp);
				pstmt.setInt(2, lev_tmp);
				rs = pstmt.executeQuery(); 
				
				int cnt = 0 ; 
				if(rs.next()){
					cnt = rs.getInt(1); 
				}
				
				rs = null; 
				System.out.println("count : " + cnt); 
				
				if( cnt > 0){
					sql = "select max(rel) as rel from comment where ref = ? and lev >= ? "; 
					pstmt = conn.prepareStatement(sql); 
					pstmt.setInt(1, ref_tmp);
					pstmt.setInt(2, lev_tmp);
					rs = pstmt.executeQuery(); 
					
					if(rs.next()){
						int rel_tmp = rs.getInt("rel")+1; 
						
						System.out.println("max(rel) : "+ rel_tmp);
						cb.setRel(rel_tmp); 
						// 기존에 해당 rel 값을 가지고 있던 애들을 1칸 뒤로 밀어준다.
						sql = "update comment set rel = rel +1 where rel >=  ?"; 
						pstmt = conn.prepareStatement(sql); 
						pstmt.setInt(1, cb.getRel());				
						pstmt.executeUpdate();
					}
					
				}else{ // 첫번째 자식을 만드는 경우.
					sql = "select rel from comment where cm_id = ? "; 
					pstmt = conn.prepareStatement(sql); 
					pstmt.setInt(1, parent_cm_id);  
					rs = pstmt.executeQuery();
					
					if(rs.next()){
						int rel_tmp = rs.getInt("rel")+1; 
						
						System.out.println("rel_tmp : " + rel_tmp);
						
						cb.setRel(rel_tmp); 
						// 기존에 해당 rel 값을 가지고 있던 애들을 1칸 뒤로 밀어준다.
						sql = "update comment set rel = rel +1 where rel >=  ?"; 
						pstmt = conn.prepareStatement(sql); 
						pstmt.setInt(1, rel_tmp);				
						pstmt.executeUpdate();
					}
				}
					
				cb.setRef(ref_tmp);
			}else{
				//답글이 아닌 경우
				cb.setRef(num+1);
				cb.setLev(0);
			}
			
			
			
			
			sql = "insert into comment(cm_id, bid,uid,content,ref,lev,alive ,rel) " + 
					           "values(  ?,    ? , ? , ?  ,   ?  , ? , 1, ?) "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num+1);
			pstmt.setInt(2, cb.getBid());
			pstmt.setString(3, cb.getUid());
			pstmt.setString(4, cb.getContent());
			
			// 답글 작성할 때 이거를 처리해줘야한다.
			// 답글이 아닌 경우에는 (cm_id , 0 ) 이 기본값이 된다. 
//			pstmt.setInt(5, num+1);  // ref	 
//			pstmt.setInt(6, 0 );     // lev
			
			pstmt.setInt(5, cb.getRef());  // ref	 
			pstmt.setInt(6, cb.getLev());  // lev
			pstmt.setInt(7, cb.getRel()); //rel 
			
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
//		String sql = "select c.* , cv.up_vote as upvote, cv.down_vote as downvote "
//					 + "from comment c join comment_vote cv on c.cm_id = cv.cm_id where c.bid= ?" ;
		
		// "삭제된 댓글입니다." 보여주기 위해서 left outer join 처리.
		// 답글 처리를 위해서 정렬 작업도 진행해야 한다. 
		String sql = "select c.* , cv.up_vote as upvote, cv.down_vote as downvote " +
				     "from comment c left join comment_vote cv on c.cm_id = cv.cm_id where c.bid= ? " + 
				     "order by ref asc , rel asc" ; // , cm_id asc"	;
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
				
				cb.setLev(rs.getInt("lev"));
				cb.setAlive(rs.getInt("alive"));
				cb.setRef(rs.getInt("ref"));
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
				if(rs.getInt("alive") == 0) continue; //삭제된 댓글은 베스트 댓글에 표시 X
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
			//sql = "delete from comment where bid=? and cm_id=?";
			
			// 삭제하는 대신, alive 를 0으로 변경.
			sql = "update comment set alive = 0  where bid=? and cm_id=?";
			
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
