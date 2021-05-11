package com.itwillbs.comment;

public class CommentBean {

	private int cm_id; // 댓글 번호 PK
	private int bid;  // 글 번호 
	private String uid; //댓글 작성자
	private String content ; //댓글 내용 
	
	//댓글의 답글?? 
	//댓글 작성 시간
	
	//댓글 추천/비추천 숫자?
	private int upvote ; 
	private int downvote; 
	
	
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
