<%@page import="java.util.ArrayList"%>
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
	UserBean ub = null; 
	
	if (id != null){
		System.out.println(id);
		ub = uDao.getUserBean(id); 
		
		if(ub != null){ String pwd = ub.getPwd(); }
		// TODO : 정보 수정할 때 비밀번호 한번 입력하게 하기 
	}else{
		id = ""; 
	}
	
%>

<!--  header 시작 -->
 
 <jsp:include page="/layout/header.jsp"></jsp:include>
 
<!--  header 끝 -->

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<form  class="form-inline">
<% if ( !id.equals("")){ %>
	<h2>
	 <%if(ub.getUserGrant() == 3){ %> [관리자]
	 <%}else if(ub.getUserGrant() == 2){ %> [운영진]
	 <%}else if(ub.getUserGrant() == 1){ %> [정회원]
	 <%}else if(ub.getUserGrant() == 1){ %> [준회원] <%} %>
	 <%=id %>님 환영합니다.
	 
	 </h2>
	 <hr>
	 <% if(ub.getUserGrant() < 1){ %> 
	 	<span>정회원 등업조건 : 댓글 3회 이상 작성</span><br>
	 	<hr>
	 <%} %>
	
	<input class="form-control"  type="button" value="로그아웃" onclick="location.href='logoutPro.jsp'">
	<input class="form-control"  type="button" value="정보수정" onclick="location.href='../userUpdateForm.jsp'">
<%}else{ %>
	<h1>익명의 방문자 님 환영합니다.</h1>
	<input class="form-control"  type="button" value="로그인" onclick="location.href='loginForm.jsp'">
	<input class="form-control"  type="button" value="회원가입" onclick="location.href='../signUpForm.jsp'"> 
<%} %>
	</form>
<form  class="form-inline">

<!--  TODO : 활동 내역 보기 ? 
		작성글 , 작성 댓글 추려서 보여주기? 
		혹은 작성 글 갯수 , 댓글 갯수 같은 것들 적어서 보여주기 
 -->
 
 <!--  TODO : 관리자 메뉴  -->
<!-- 권한 조회해서 3인지 확인하는 로직 넣을 것. -->
 <% if(id.equals("admin")){ %>
	 <h3>관리자 메뉴</h3>
	 <hr>
	 <input class="form-control"  type="button" value="회원관리" onclick="location.href='../userListForm.jsp'">
<%} %>
</form>

<!--  TODO : 활동 내역 보기 ? 
		작성글 , 작성 댓글 추려서 보여주기? 
		혹은 작성 글 갯수 , 댓글 갯수 같은 것들 적어서 보여주기 
 -->
<% if ( !id.equals("")){ 

	ArrayList<Integer> arr =  uDao.getUserActivity(id); 
	if(arr!= null){
%>
<form  class="form-inline">
	<div class="form-group">
		<h3>활동내역</h3>
		<hr>
		<table border="1"  id="tb" class="table table-bordered ">
		<!--  하나의 컬럼으로 조회할 수 없을까?  -->
			<tr>
				<th>작성글 갯수</th>
				<th>작성댓글 갯수</th>
				<th>추천/비추천 갯수</th>
			</tr>
			<tr>
				<td><%=arr.get(0) %></td>
				<td><%=arr.get(1) %></td>
				<td><%=arr.get(2) %></td>
			</tr>
		</table>
	</div>
</form>
<%} } %>
</div>
</body>
</html>