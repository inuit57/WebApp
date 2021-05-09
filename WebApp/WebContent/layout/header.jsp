<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<%
	String path = request.getContextPath(); 
%>

<link href="<%=request.getContextPath()%>/layout/dashboard.css" rel="stylesheet">
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="<%=path%>/User/Login/main.jsp">메인</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            
            <% if(session.getAttribute("id") == null){ %>
            <li><a href="#">Guest</a></li>
            <li><a href="<%=path%>/User/Login/loginForm.jsp">로그인</a></li>
            <%}else{ %>
            <!--  회원 정보 수정으로 이동 -->
            <li><a href="<%=path%>/User/userUpdateForm.jsp"><%=session.getAttribute("id") %></a></li>
            <li><a href="<%=path%>/User/Login/logoutPro.jsp">로그아웃</a></li>
            <%} %>
            <li><a href="<%=path%>/User/idPwSearch.jsp">회원정보찾기</a></li>
            <%-- <li><a href="<%=path%>/Board/ImageBoard.jsp">갤러리</a></li> --%>
          </ul>
          <!-- 이거는 쓸지 안 쓸지는 좀 고민해보자. 
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form> 
          -->
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">전체메뉴 <span class="sr-only">(current)</span></a></li>
            <li><a href="<%=path%>/Board/boardList.jsp">게시판</a></li>
            <li><a href="<%=path%>/Board/ImageBoard.jsp">갤러리</a></li>
            
            <!-- <li><a href="#">Export</a></li> -->
          </ul>
          
          <!-- 
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item</a></li>
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
           -->
        </div>