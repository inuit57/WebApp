<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>

<%

/* 	String id = (String)session.getAttribute("id");
	
	if (id != null){
		response.sendRedirect("main.jsp");  
	} */
%>

	<fieldset>
		<legend>로그인</legend>
		<!--  테스트 끝나고 get에서 post로 바꿀 것. -->
		<form action="loginPro.jsp" method="get">
			아이디 : <input type="text" name="id"><br> 
			비밀번호 : <input type="password" name="pwd"> <br> 
			<input type="submit" value="로그인"> <br>
			<!--  TODO 다른 방식으로 로그인? 카카오톡/네이버 아이디로? -->
			<input type="button" value="회원가입"
				onclick="location.href='../signUpForm.jsp'">
		</form>
	</fieldset>

</body>
</html>