<%@page import="com.itwillbs.comment.CommentDAO"%>
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
	request.setCharacterEncoding("UTF-8"); 
%>
<jsp:useBean id="cb" class="com.itwillbs.comment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>
<%

	CommentDAO cDao = new CommentDAO(); 

	boolean flag = cDao.deleteComment(cb); 
%>
<script type="text/javascript">

	if(<%=flag%>) {
		alert("댓글 삭제 완료!"); 
	}
	
	location.href="../boardView.jsp?bID=<%=cb.getBid()%>" ;
</script>
</body>
</html>