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
%>
	<jsp:useBean id="userBean" class="com.itwillbs.user.UserBean"></jsp:useBean>
	<%-- 에러가 왜 나는가 했는데 public 기본 생성자가 없어서 그랬다...  --%>
	<jsp:setProperty property="*" name="userBean"/> 
	
<% 
	UserDAO ud = new UserDAO(); 
	
	String new_pwd = request.getParameter("new_pwd"); 
	System.out.println("new_pwd : " + new_pwd);
	
	boolean flag = false; 
	if ( ud.UserCheck(userBean.getId(), userBean.getPwd()) ) {
		userBean.setPwd(new_pwd); 
		flag = ud.updateUser(userBean);
	}
	
%>
<script type="text/javascript">

	if (<%=flag%>){
		alert("정보가 수정되었습니다."); 
		location.href = "Login/main.jsp";
	}else{
		alert("잘못된 접근입니다."); 
		location.href = "Login/main.jsp";
	}
</script>
</body>
</html>