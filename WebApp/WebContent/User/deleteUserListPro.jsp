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
	//String[] str = request.getParameterValues("arr"); 
	// ace,inuit,test 
	// 이런 형태로 날아온다. 잘라주도록 하자. 
	String[] list = (request.getParameter("arr")).split(","); 
	
	int kill_count = list.length; 
	UserDAO udao = new UserDAO(); 
	boolean flag = false ; 
	flag = udao.deleteUserList(list);  
%>
<script type="text/javascript">

	if(<%=flag%>){
		alert("유저 "+<%=kill_count%> +"명 삭제 완료!"); 
	}else{
		alert("유저 "+<%=kill_count%> +"명 삭제 실패!")
	}
	location.href="userListForm.jsp"; 
</script>
</body>
</html>