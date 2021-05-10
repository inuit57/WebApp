<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<script type="text/javascript">
	function moveList(){
			
			var curr = <%=(String)session.getAttribute("curr")%>; 
			var listCnt = <%=(String)session.getAttribute("listCnt")%>
			
			if (curr == null) curr = 1 ;
			if (listCnt == null) listCnt = 3; 
			
			location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 
	}
</script>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8"); 
	String bid = (String)request.getParameter("bID"); 

	UserDAO uDAO = new UserDAO(); 
	String uid = ""; 
	
	if(session.getAttribute("id")!=null){
		uid = (String)session.getAttribute("id"); 
	}


%>
<!--  header 시작 -->
 
 <jsp:include page="/layout/header.jsp"></jsp:include>
 
<!--  header 끝 -->

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<fieldset> 	
	<legend>게시글 작성</legend>
	<form  class="form-inline" action="insertPro.jsp" method="post" enctype="multipart/form-data">
		<div class="form-group">
		<div class="table-responsive">
		<table border="1"  id="tb" class="table table-bordered ">
			<tr> 
				<td>
					<select class="col-sm-2 form-control"  name="btype">
					<% if( uDAO.getUserBean(uid).getUserGrant() >2 ){ %>
						<option value="1">공지</option>
					<%} %>
						<option value="2" selected="selected">일반</option>
						<option value="3">자료</option>
					</select>
				</td>
				<td colspan="2">
					<input type="text"   class="form-control" name="bsubject" placeholder="제목">  
				</td>
			</tr>
			<tr> 
				<td colspan="3">
					<textarea class="form-control"  cols="35" rows="10" name="bcontent" placeholder="내용"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
				<input type="file" class="form-control"  name="file_name" >
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
					<input type="submit" class="form-control"  value="작성">
					<input type="button"  class="form-control"  value="취소" onclick="moveList()">
				</td> 
			</tr>
		</table>
		</div>
		</div>
	</form>
</fieldset>
</div>
</body>
</html>