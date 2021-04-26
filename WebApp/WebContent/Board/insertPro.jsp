<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
</head>
<body>
<%

	String id = (String)session.getAttribute("id"); 
	if ( id == null) { 
	//	response.sendRedirect("../User/Login/main.jsp"); //메인 페이지로 사출. 
	}else{
		
		BoardDAO bdao = new BoardDAO(); 
		
	}
	
	
%>

</body>
</html>