<%@page import="com.itwillbs.user.UserBean"%>
<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 유효성 검사</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%

	String id = request.getParameter("id"); 
	UserDAO uDAO = new UserDAO(); 
	
	//UserBean ub = uDAO.getUserBean(id); 
	
	boolean flag = !uDAO.UserCheck(id); 
	System.out.println(flag); 
	//System.out.println(id); 
	
/* 	if (ub == null){
		//response.sendRedirect("signUpForm.jsp?idchk="+id); 
		flag = true; 	
	}else{
		//System.out.println(ub.getId()); 
		//response.sendRedirect("signUpForm.jsp");
		flag = false; 
	} */
%>

<script type="text/javascript">

	if (<%=flag%>){
		alert("사용가능한 아이디입니다.");
		opener.document.fr.idCheck.value = "Yes"; 
		opener.document.fr.id.readOnly=true; 
		self.close(); 
	}else{
		alert("이미 사용 중인 아이디입니다.");
		opener.document.fr.id.value = ""; 
		opener.document.fr.idCheck.value = "";
		self.close();
	}
</script>


</body>
</html>