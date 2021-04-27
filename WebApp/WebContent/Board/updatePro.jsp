<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bb" class="com.itwillbs.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bb"/>

<%
	BoardDAO bDao = new BoardDAO(); 
	
	boolean flag = bDao.updateBoard(bb); 
		
%>
<script type="text/javascript">
	if(<%=flag%> ){
		alert("업데이트 완료!"); 
	}
	var curr = <%=(String)session.getAttribute("curr")%>; 
	var listCnt = <%=(String)session.getAttribute("listCnt")%>
	
	if (curr == null) curr = 1 ;
	if (listCnt == null) listCnt = 3; 
	
	location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 

</script>
</body>
</html>