<%@page import="com.itwillbs.user.UserBean"%>
<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>TestDB</h1>

<%
	//연결 테스트 
	UserDAO userDao = new UserDAO(); 
	UserBean ub = userDao.getUserBean("test"); 
	
	System.out.print(ub.getName());
%>

</body>
</html>