package com.itwillbs.board;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.itwillbs.dao.ObjectDAO;

public class BoardDAO extends ObjectDAO {
	
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
			sql = "insert into board(bid,uid,bsubject,btype,bcontent,user_score,file_name , bdate) " +
					"values( ? , ?, ? , ? , ? , ? , ? , now() ) "; 
					//bid, uid, bsubject , btype,  bcontent, user_score,file_name
		
			pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getUid());
			pstmt.setString(3, bb.getBsubject());
			pstmt.setString(4, bb.getBtype());
			pstmt.setString(5, bb.getBcontent());
			pstmt.setInt(6, bb.getUser_score());
			pstmt.setString(7, bb.getFile_name());
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
			//String sql = "select b.* , count(c.bid) from board b order by bid desc "; 
			String sql = "select b.* , count(c.cm_id) as cm_count from board b left join comment c on b.bid = c.bid group by(b.bid) order by bid desc" ; 
		
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
				bb.setUser_score(rs.getInt("user_score"));
				bb.setFile_name(rs.getString("file_name"));
				bb.setBdate(rs.getDate("bdate"));
				bb.setComment_cnt(rs.getInt("cm_count"));
				
				arrBB.add(bb); 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		
		return arrBB; 
	} //getBoardList
	
	public BoardBean getBoard(int bid){
		BoardBean bb = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select * from board where bid = ?"; 
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1	, bid);
			ResultSet rs = pstmt.executeQuery();  
			while(rs.next()){
				bb = new BoardBean(); 
				bb.setBcontent(rs.getString("bcontent"));
				bb.setBid(rs.getInt("bid"));
				bb.setBsubject(rs.getString("bsubject"));
				bb.setBtype(rs.getString("btype"));
				bb.setUid(rs.getString("uid"));
				bb.setUser_score(rs.getInt("user_score"));
				bb.setFile_name(rs.getString("file_name"));
				bb.setBdate(rs.getDate("bdate"));	 
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		
		return bb; 
	} //public BoardBean getBoard(int bid){
	
	public BoardBean getNextBoard(int bid){
		BoardBean bb = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select * from board where bid > ? limit 1 ;  "; 
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1	, bid);
			ResultSet rs = pstmt.executeQuery();  
			if(rs.next()){
				bb = new BoardBean(); 
				bb.setBcontent(rs.getString("bcontent"));
				bb.setBid(rs.getInt("bid"));
				bb.setBsubject(rs.getString("bsubject"));
				bb.setBtype(rs.getString("btype"));
				bb.setUid(rs.getString("uid"));
				bb.setUser_score(rs.getInt("user_score"));
				bb.setFile_name(rs.getString("file_name"));
				bb.setBdate(rs.getDate("bdate"));	 
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		
		return bb; 
	} // 다음 글 찾기 
	
	public BoardBean getPreBoard(int bid){
		BoardBean bb = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select * from board where bid < ? order by bid desc limit 1 ;  "; 
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1	, bid);
			ResultSet rs = pstmt.executeQuery();  
			if(rs.next()){
				bb = new BoardBean(); 
				bb.setBcontent(rs.getString("bcontent"));
				bb.setBid(rs.getInt("bid"));
				bb.setBsubject(rs.getString("bsubject"));
				bb.setBtype(rs.getString("btype"));
				bb.setUid(rs.getString("uid"));
				bb.setUser_score(rs.getInt("user_score"));
				bb.setFile_name(rs.getString("file_name"));
				bb.setBdate(rs.getDate("bdate"));	 
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		
		return bb; 
	} // 다음 글 찾기 
	
	
	public boolean deleteBoard(int bid){
		try {
			conn = getConnection(); 
			String sql = "delete from board where bid = ?"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			
			pstmt.executeUpdate(); 
			System.out.println("삭제 완료!");
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
		}finally {
			dbClose();
		}
		return true; 
	} // deleteBoard() 
	
	public boolean updateBoard(BoardBean bb){
		
		conn = getConnection(); 
		String sql = "Update Board set btype=?, bsubject=?, bcontent=? ,file_name=?  where bid=?";
		//String sql = "Update Board set btype=?, bsubject=?, bcontent=?  where bid=?";
		//System.out.println(bb.getBcontent());
		//System.out.println(bb.getBsubject());
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bb.getBtype());
			pstmt.setString(2, bb.getBsubject());
			pstmt.setString(3, bb.getBcontent());
			pstmt.setString(4, bb.getFile_name());
			pstmt.setInt(5, bb.getBid());
			
			pstmt.executeUpdate(); 
			System.out.println(bb.getBid());
			System.out.println(bb.getBtype());
			System.out.println("업데이트 완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
			
		} finally {
			dbClose();
		}
		
		return true; 
	}
}
