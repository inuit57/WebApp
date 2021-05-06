package com.itwillbs.board;

import java.sql.Date;

public class BoardBean {

	private int bid;  // 게시글 id
	private String uid ; //유저 이름
	private String btype ; 
	private String bsubject ; 
	private String bcontent ; 
	private int user_score ; 
	private String file_name ;
	private Date bdate ; 
	private int view_cnt; 
	
	private int comment_cnt ; //댓글 갯수 
	//고민을 좀 했는데 여기에서 처리하는 게 좋을 거 같다. 
	
	public void setComment_cnt(int comment_cnt){
		this.comment_cnt = comment_cnt; 
	}
	
	public int getComment_cnt(){
		return comment_cnt; 
	}
	// comment 테이블이랑 JOIN해서 처리된 댓글 수를 저장할 용도
	// 매번 댓글 수 조회하려고 DB 쿼리 날려보는 것보다는 한번에 가져와서
	// 저장하고 사용하는 편이 좀더 좋을 거라는 판단.
	
	
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public int getUser_score() {
		return user_score;
	}
	public void setUser_score(int user_score) {
		this.user_score = user_score;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public Date getBdate() {
		return bdate;
	}
	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public String getBsubject() {
		return bsubject;
	}
	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	
}
