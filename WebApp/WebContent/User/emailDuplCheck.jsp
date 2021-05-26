<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 

	String email = request.getParameter("email"); 
	System.out.println(email); 
	UserDAO udao = new UserDAO(); 
	
	boolean flag = udao.emailCheck(email); 
	System.out.println(flag); 
	
%>

<% if (flag) { %>
	{ "flag" : "true"} 
<%}else{ %>
	{ "flag" : "false"} 
<%}%>