<%@page import="com.itwillbs.board.BoardDAO"%>
<%@page import="com.itwillbs.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%

	request.setCharacterEncoding("UTF-8"); 
	boolean result = true; 
	String bid = (String)request.getParameter("bid"); 
	if ( bid == null){
		result = false;
	}else{
		BoardDAO bDao = new BoardDAO(); 
		
		result = bDao.deleteBoard(Integer.parseInt(bid)); 
	}
	
%>
<script type="text/javascript">
	if(<%=result%>){
		alert("삭제 완료!"); 
	}else{
		alert("잘못된 접근입니다."); 
	}
	
	var curr = <%=(String)session.getAttribute("curr")%>; 
	var listCnt = <%=(String)session.getAttribute("listCnt")%>
	
	if (curr == null) curr = 1 ;
	if (listCnt == null) listCnt = 3; 
	
	location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 
</script>
<body>

</body>
</html>