package com.itwillbs.comment;

public class CommentBean {

	private int cm_id; // 댓글 번호 PK
	private int bid;  // 글 번호 
	private String uid; //댓글 작성자
	private String content ; //댓글 내용 
	
	private int lev ; // 답글 들여쓰기  
	private int ref ; // 부모 댓글(답글의 최상위 댓글) 
	private int alive ; // 삭제 여부 
	private int rel ; // 답글의 순서 구분용 
	
	// TODO : 댓글 작성 시간
	

	//댓글 추천/비추천 숫자
	private int upvote ; 
	private int downvote; 
	
	public int getRel() {
		return rel;
	}
	public void setRel(int rel) {
		this.rel = rel;
	}
	
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getAlive() {
		return alive;
	}
	public void setAlive(int alive) {
		this.alive = alive;
	}

	public int getUpvote() {
		return upvote;
	}
	public void setUpvote(int upvote) {
		this.upvote = upvote;
	}
	public int getDownvote() {
		return downvote;
	}
	public void setDownvote(int downvote) {
		this.downvote = downvote;
	}
	
	public int getCm_id() {
		return cm_id;
	}
	public void setCm_id(int cm_id) {
		this.cm_id = cm_id;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	

	
	
	
}
