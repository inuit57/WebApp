<%@page import="mailTest.KeyGenerator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	KeyGenerator key = new KeyGenerator() ; 

	session.setAttribute("key", key.getKey());  
	//클라 쪽에서 시간을 재서 시간이 지났을 때 이거를 날려버리는 것이 좋지 싶네. 

	response.sendRedirect("emailCheckForm.jsp"); 
	
	// 여기에서 키를 생성해서 돌려주도록 한다. 
%>
</body>
</html>