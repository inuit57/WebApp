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

	String name = request.getParameter("name"); 
	String email = request.getParameter("email");
	
	UserDAO udao = new UserDAO(); 
	
	String id ="" ; 
	id = udao.getId(name, email);
	
	
	if(id != null){
		String show_id ="";	 
		for(int i = 0 ; i< id.length() ; i++){
			 
			if(i == (id.length()/2) || i == (id.length()/2 +1) ) {
				show_id +="*"; 
			}else{
				show_id += id.charAt(i);
			}
		}
		session.setAttribute("id", show_id);
	}
%>
<script>

	if("<%=id%>" != ""){
		window.open( "emailCheckPro.jsp?email=<%=email%>" , "이메일 인증","width=500,height=600");
		setTimeout(() => location.href = "idPwSearch.jsp", 1000)
	}else{
		location.href = "idPwSearch.jsp"; 
		alert("입력하신 정보와 일치하는 회원이 없습니다."); 
	}


</script>
</body>
</html>