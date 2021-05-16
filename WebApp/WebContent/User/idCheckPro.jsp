<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	String id = request.getParameter("id"); 
	
	System.out.println(id);
	
	UserDAO uDAO = new UserDAO(); 
		
	boolean flag = !uDAO.UserCheck(id); 
	System.out.println(flag); 
%>

<% if (flag){ %> 
	{ "flag" : "true" } 
<%}else{ %>
	{ "flag" : "false" }
<%} %>
