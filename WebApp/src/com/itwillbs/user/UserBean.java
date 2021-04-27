package com.itwillbs.user;

import java.sql.Date;

public class UserBean {
	private String id ; 
	private String pwd ; 
	private String name ; 
	private String gender ;  
	private int age ; 
	private String addr ; 
	private String email ; 
	private int userGrant ; 
	private Date signInDate ; 
	private String post_num; 
	private String addr2 ; 
	
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getPost_num() {
		return post_num;
	}
	public void setPost_num(String post_num) {
		this.post_num = post_num;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setUserGrant(int userGrant) {
		this.userGrant = userGrant;
	}
	public void setSignInDate(Date signInDate) {
		this.signInDate = signInDate;
	}
	public String getId() {
		return id;
	}
	public String getPwd() {
		return pwd;
	}
	public String getName() {
		return name;
	}
	public String getGender() {
		return gender;
	}
	public int getAge() {
		return age;
	}
	public String getAddr() {
		return addr;
	}
	public String getEmail() {
		return email;
	}
	public int getUserGrant() {
		return userGrant;
	}
	public Date getSignInDate() {
		return signInDate;
	}
	
	public UserBean(){
		//자바빈즈 액션태그 사용용 기본 생성자 
	}
	
	// 액션태그를 쓰는 자바빈으로 가는 편이 더 좋을 것 같네.
	// 빌더 패턴이 어떤 것인지 공부했다는 것이 소득이다. 
	private UserBean(Builder builder) {
		this.id = builder.id ; 
		this.pwd = builder.pwd; 
		this.name = builder.name ; 
		this.gender = builder.gender ; 
		this.age = builder.age ; 
		this.addr = builder.addr ; 
		this.email = builder.email ; 
		this.userGrant = builder.userGrant; 
		this.signInDate = builder.signInDate; 
		this.post_num = builder.post_num; 
		this.addr2 = builder.addr2; 
	}
	
	public static class Builder{
		private String id ; 
		private String pwd ; 
		private String name ; 
		private String gender ;  
		private int age ; 
		private String addr ; 
		private String email ; 
		private int userGrant ; 
		private Date signInDate ;
		private String post_num; 
		private String addr2 ; 
		
		public Builder id(String id){
			this.id = id; 
			return this; 
		}
		public Builder pwd(String pwd){
			this.pwd = pwd; 
			return this; 
		}
		public Builder name(String name){
			this.name = name; 
			return this; 
		}
		public Builder gender(String gender){
			this.gender = gender;
			return this; 
		}
		public Builder age(int age){
			this.age = age; 
			return this; 
		}
		public Builder addr(String addr){
			this.addr = addr; 
			return this; 
		}
		public Builder email(String email){
			this.email = email; 
			return this; 
		}
		public Builder userGrant(int userGrant){
			this.userGrant = userGrant; 
			return this; 
		}
		public Builder signInDate(Date signInDate){
			this.signInDate = signInDate ; 
			return this; 
		}
		
		public Builder addr2(String addr2){
			this.addr2 = addr2; 
			return this; 
		}
		
		public Builder post_num(String post_num){
			this.post_num = post_num; 
			return this; 
		}

		public UserBean build(){
			return new UserBean(this); 
		}
	}
}
