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
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<%
	for(BoardBean bb : arrBB){
	%>
		<tr>
			<td align="center"><%=bb.getBid() %></td>
			<td>
				<% int type = Integer.parseInt(bb.getBtype());
					String typeStr = ""; 
					switch(type){
					case 1 : typeStr="공지";break;
					case 2 : typeStr="일반";break;
					case 3 : typeStr="자료";break;
					}
				%>
				<%=typeStr %>
			</td>
			<td><%=bb.getBsubject() %></td>
			<td><%=bb.getUid() %> </td>
			<td><%=bb.getBdate() %></td>
		</tr>
	<%	
	}%>
	<tr>
		<td colspan="5" align="right">
			<input type="button" value="글 작성" onclick="location.href='insertForm.jsp'">
			<input type="button" value="메인으로" onclick="location.href='../User/Login/main.jsp'">
		</td>
	</tr>
</table>

<%}else{
	%>
	등록된 글이 없습니다.
<% }%>
</body>
</html>