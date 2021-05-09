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
<%

	String id = request.getParameter("id"); 
	String pwd = request.getParameter("pwd"); 
	
	String name = request.getParameter("name"); 
	String email = request.getParameter("email"); 
	String loginType = request.getParameter("loginType"); 
	
	UserDAO uDAO = new UserDAO(); 

	//정보 확인하기 
	//(비밀번호와 일치하는지). 
	//
	boolean flag = false; 
	
	switch(loginType){
		case "normal" :
			flag = uDAO.UserCheck(id, pwd);
			break;
		case "kakao" :
			id = uDAO.getId(name, email);
			flag = !(id == null); 
			//System.out.println("id 조회 결과 : " + id);
			session.setAttribute("loginType", "kakao");

			break;
	}
	//flag = uDAO.UserCheck(id, pwd); 
	
	if(flag){
		session.setAttribute("id", id); // 세션에 로그인 정보 저장 
		session.setMaxInactiveInterval(10000); 
		
		//TODO : 사용자 권한 단계 변경해주기 
		//회원가입한 날짜 기준으로 X일 이후에 다시 로그인할 경우
		//준회원에서 정회원으로 바뀌는 로직 넣기 
		
		//TODO : 사용자 권한 단계 변경해주기 
		//회원의 방문 횟수가 X번 이상일 경우
		//준회원에서 정회원으로 바뀌는 로직 넣기
		//(DB 수정 필요)
		
	}
	//아닐 경우 경고창 띄워줄 것. -> 아래의 js 코드에서 수행
%>

<script type="text/javascript">
	if(<%=flag%>){
		alert("로그인 성공!"); 
		location.href="main.jsp" ; 
	}else{
		// TODO : 아이디/비밀번호 어떤 것이 틀렸는지 여부? 
		// TODO : 아이디조차 없는 경우, 회원가입을 유도할지? 
		
		//alert("<%=loginType%>");

		<% if( loginType.equals("normal")){ %>
			alert("아이디나 비밀번호를 확인하세요.");
		<%} else{ %>
			alert("<%=loginType%>"+": 연동되지 않은 계정입니다.");

		<%}%>
		location.href = "loginForm.jsp"; 
	}
</script>
</body>
</html>