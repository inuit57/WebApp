<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원탈퇴 처리</title>
</head>
<body>
<%
	
	UserDAO ud = new UserDAO(); 
	String id = (String)session.getAttribute("id") ;
	session.invalidate(); //세션 정보 다 지워주기
	
	if(id == null){
		response.sendRedirect("Login/loginForm.jsp"); 
	}else{
	
		ud.deleteUser(id); 
		//session.invalidate(); //세션 정보 다 지워주기 
		
		response.sendRedirect("Login/main.jsp");
	}
	
%>
</body>
</html>