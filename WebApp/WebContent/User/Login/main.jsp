<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="com.itwillbs.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인 페이지</title>
</head>
<body>

<%

	String id = (String)session.getAttribute("id");
	
	UserDAO uDao = new UserDAO(); 
	
	if (id != null){
		System.out.println(id);
		String pwd = uDao.getUserBean(id).getpwd();
	}else{
		// 로그인 페이지로 이동.
		response.sendRedirect("loginForm.jsp");
	}
	
%>

<h2> <%=id %>님 환영합니다.</h2>

<input type="button" value="로그아웃" onclick="location.href='logoutPro.jsp'">
<input type="button" value="정보수정" onclick="location.href='../userUpdateForm.jsp'">


</body>
</html>