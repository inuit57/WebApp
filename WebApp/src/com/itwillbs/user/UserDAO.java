package com.itwillbs.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.itwillbs.dao.ObjectDAO;

public class UserDAO extends ObjectDAO {

	private UserBean ub ;
	//UserBean ub = new UserBean.Builder().build(); 
	// 이렇게 하면 그냥 빈 객체 생성된다. 
	
	// id로 User얻어오기
	public boolean UserCheck(String id,String pwd){
		try {
			conn = getConnection();
			
			String sql = "select count(*) from userInfo where id=? and pwd=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				if ( rs.getInt(1) > 0 ) return true; 
				else return false ; 
			}else{
				return false; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		return false;
		 
	}
	
	public boolean UserCheck(String id, String name, String email){
		try {
			conn = getConnection();
			
			String sql = "select id from userInfo where id=? and email=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				return true;  
			}else{
				return false; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		return false;
		 
	}
	
	public boolean UserCheck(String id){
		try {
			conn = getConnection();
			
			String sql = "select id from userInfo where id=?";  
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				return true; 
			}else{
				return false; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		 
		return false ; 
	}
	
	//getUserBean(String id)
	//유저 1명 정보 다 얻어오기 
	public UserBean getUserBean(String id){
		try {
			conn = getConnection();
			
			String sql = "select * from userInfo where id=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery(); 
			if(rs.next()){
				ub = new UserBean.Builder().
						id(rs.getString("id")).
						pwd(rs.getString("pwd")).
						name(rs.getString("name")).
						addr(rs.getString("addr")).
						age(rs.getInt("age")).
						email(rs.getString("email")).
						gender(rs.getString("gender")).
						userGrant(rs.getInt("userGrant")).
						signInDate(rs.getDate("signInDate")).
						post_num(rs.getString("post_num")).
						addr2(rs.getString("addr2")).
						build();
				System.out.println("유저를 찾았습니다.");
			}else{
				System.out.println("정보 없음");
				return null; //없는 경우 null 리턴 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbClose();
		}
		System.out.println(ub); 
		return ub ; 
	}// getUserBean(String id)
	
	//insertUser : 회원 가입
	public boolean insertUser(UserBean ub){
		try {
			conn = getConnection(); 
			
			String sql = "insert into userInfo values(? , ? , ? , ? , ? , ? , ? , 0 , now() , ?, ?) "; 
	
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ub.getId());
			pstmt.setString(2, ub.getPwd());
			pstmt.setString(3, ub.getName());
			pstmt.setString(4, ub.getGender());
			pstmt.setInt(5,ub.getAge()); 
			pstmt.setString(6, ub.getAddr());
			pstmt.setString(7, ub.getEmail());
			pstmt.setString(8, ub.getPost_num());
			pstmt.setString(9, ub.getAddr2());
			
			pstmt.executeUpdate(); 
			System.out.println("회원 등록 완료");
			return true ; 
		} catch (SQLException e) {
			e.printStackTrace();
			return false ;
		} finally {
			dbClose();
		}

	} //insertUser
	

	public boolean deleteUser(String id){
		try {
			conn = getConnection(); 
			
			String sql = "delete from userinfo where id = ?"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate(); 
			
			System.out.println(id+" 삭제완료");
			return true; 
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
		} finally{
			dbClose();
		}

	}	//deleteUser
	
	//비밀번호 업데이트 
	public boolean updateUser(String id, String email, String pw){
		try {
			conn = getConnection(); 
			
			String sql = "update userinfo set pwd = ? where id = ? and email=?"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			pstmt.setString(3, email);
			
			pstmt.executeUpdate(); 
			System.out.println("업데이트 완료");
			
			return true; 
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
		}finally {
			dbClose();
		} 
	} //비밀번호 업데이트 끝. 
	
	public boolean updateUser(UserBean ub){
		try {
			conn = getConnection(); 
			
			String sql = "update userinfo set pwd = ? , name=? , gender=?, age=?,post_num=?, addr=? ,addr2=?, email=? where id = ?"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ub.getPwd());
			pstmt.setString(2, ub.getName());
			pstmt.setString(3, ub.getGender());
			pstmt.setInt(4, ub.getAge());
			pstmt.setString(5, ub.getPost_num());
			pstmt.setString(6, ub.getAddr());
			pstmt.setString(7, ub.getAddr2());
			pstmt.setString(8, ub.getEmail());
			pstmt.setString(9, ub.getId());
			
			pstmt.executeUpdate(); 
			System.out.println("업데이트 완료");
			
			return true; 
		} catch (SQLException e) {
			e.printStackTrace();
			return false; 
		}finally {
			dbClose();
		} 
		
	}
}
