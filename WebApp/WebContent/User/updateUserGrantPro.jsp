
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
<%
	request.setCharacterEncoding("UTF-8"); 
	String id = request.getParameter("id"); 
	int grant = Integer.parseInt(request.getParameter("grant")); 
	
	UserDAO udao = new UserDAO(); 
	boolean flag = false ; 
	
	flag = udao.updateUser(id, grant); 
%>
<script type="text/javascript">
	if(<%=flag%>){
		alert("권한 업데이트 완료!"); 
	}else{
		alert("권한 업데이트 실패.");
	}
	
	location.href="userListForm.jsp"; 

</script>
</body>
</html>