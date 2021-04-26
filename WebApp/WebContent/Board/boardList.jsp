<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 목록</title>
</head>
<body>
<%

	BoardDAO bDao = new BoardDAO(); 
	ArrayList<BoardBean> arrBB = bDao.getBoardList(); 

	if(arrBB.size() >0){
%>
<h1> 총 글 갯수 : <%=arrBB.size() %></h1>

<table border="1">
	<tr>
	<th>글 번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
	</tr>
	<%
	for(BoardBean bb : arrBB){
	%>
		<tr>
			<td><%=bb.getBid() %></td>
			<td><%=bb.getBsubject() %></td>
			<td><%=bb.getBcontent()%></td>
			<td><%=bb.getBdate() %></td>
		</tr>
	<%	
	}%>
</table>

<%} %>
</body>
</html>