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

		public UserBean build(){
			return new UserBean(this); 
		}
	}
}
