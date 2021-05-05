<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="com.itwillbs.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인 페이지</title>
</head>
<body>

<%

	String id = (String)session.getAttribute("id");
	
	UserDAO uDao = new UserDAO(); 
	
	if (id != null){
		System.out.println(id);
		UserBean ub = uDao.getUserBean(id); 
		
		if(ub != null){ String pwd = ub.getPwd(); }
		// TODO : 정보 수정할 때 비밀번호 한번 입력하게 하기 
	}else{
		// 로그인 페이지로 이동.
		id = ""; 
		response.sendRedirect("loginForm.jsp");
	}
	
%>

<h2> <%=id %>님 환영합니다.</h2>

<input type="button" value="로그아웃" onclick="location.href='logoutPro.jsp'">
<input type="button" value="정보수정" onclick="location.href='../userUpdateForm.jsp'">
<input type="button" value="게시판" onclick="location.href='../../Board/boardList.jsp'">

<!--  TODO : 활동 내역 보기 ? 
		작성글 , 작성 댓글 추려서 보여주기? 
		혹은 작성 글 갯수 , 댓글 갯수 같은 것들 적어서 보여주기 
 -->
 
 <!--  TODO : 관리자 메뉴  -->
<!-- 권한 조회해서 3인지 확인하는 로직 넣을 것. -->
 <% if(id.equals("admin")){ %>
	 <fieldset>
	 <legend>관리자 메뉴</legend>
	 <input type="button" value="회원관리" onclick="location.href='../userListForm.jsp'">
	</fieldset>
<%} %>
</body>
</html>