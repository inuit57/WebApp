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

	// ID , 이메일를 받는다. 
	// DB에서 해당 조건에 맞는 사람이 있는 지를 확인한다. 
	String id = request.getParameter("id"); 
	String name = request.getParameter("name"); 
	String email = request.getParameter("email"); 
	
	UserDAO udao = new UserDAO(); 
	boolean flag = false ; 
	
	flag = udao.UserCheck(id, name, email); 
	// id, 이름, 이메일 3개 인자 받아서 처리? 
	
	 		
	// 없을 경우 -> 오류 메시지를 띄워주고 다시 입력하도록 유도한다. 
	
	// 있는 경우 -> 
	// 입력한 이메일로 임시비밀번호를 발급해준다. 
	// DB 상에 있는 비밀번호도 임시비밀번호로 업데이트 시킨다. 
	// (* 추가 기능 : 임시비밀번호로 로그인할 경우 비밀번호를 변경하도록 한다.) 

%>
<script type="text/javascript">

	if(!<%=flag%>){
		// 일치하는 유저가 없는 경우 
		if(confirm("일치하는 유저가 없습니다. 회원가입하시겠습니까?")){
			location.href="signUpForm.jsp"; 
		}else{
			location.href="idPwSearch.jsp"; 
		}
	}else{
		//일치하는 유저가 있는 경우 
		alert("이메일로 임시비밀번호를 발급하였습니다."); 
		// 키 발급하는 쪽에서 임시비밀번호 넣어줘도 상관은 없겠다. 
		location.href = "emailCheckPro.jsp?pwReset=1&email="+"<%=email%>"+"&id="+"<%=id%>"; 
	}
</script>
</body>
</html>