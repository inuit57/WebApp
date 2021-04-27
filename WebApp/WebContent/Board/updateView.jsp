<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">

	function moveList(){
		var curr = <%=(String)session.getAttribute("curr")%>; 
		var listCnt = <%=(String)session.getAttribute("listCnt")%>
		
		if (curr == null) curr = 1 ;
		if (listCnt == null) listCnt = 3; 
		
		location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 
	}
	
	function moveBack(){
		history.back();
	}
	
	function update(){
		
		//TODO : 유효성 검사하기 
		
		//return false; //
	}
	
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); 
	String bid = (String)request.getParameter("bID"); 

	BoardDAO bDAO = new BoardDAO(); 
	BoardBean bb = null ; 
	if(bid == null){ 
		response.sendRedirect("../User/Login/main.jsp"); 
	}else{
		bb = bDAO.getBoard(Integer.parseInt(bid)); 
	}
%>

<% if ( bb != null ){ %>
<fieldset> 
	<legend>게시글 내용</legend>
	<form action="updatePro.jsp"  method="get" onsubmit="return update()">
		<table border="2">
			<tr> 
				<td>
					<select name="btype" >
						<option value="1" <% if(bb.getBtype().equals("1")){ %>selected="selected" <%} %>>공지</option>
						<option value="2" <% if(bb.getBtype().equals("2")){ %>selected="selected" <%} %>>일반</option>
						<option value="3" <% if(bb.getBtype().equals("3")){ %>selected="selected" <%} %>>자료</option>
					</select>
				</td>
				<td colspan="2">
					<input type="text" name="bsubject" placeholder="제목"  value=<%=bb.getBsubject() %>>  
					<input type="hidden" name="bid" value=<%=bid%> >
				</td>
			</tr>
			<tr> 
				<td colspan="3">
					<textarea rows="20" cols="30" name="bcontent" placeholder="내용" ><%=bb.getBcontent() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
				<%
					if ( bb.getUid().equals(session.getAttribute("id"))){
						// TODO : 계정 권한이 관리자인 경우에만 삭제 버튼 활성화 되도록 추가
				%>
					<input type="submit" value="수정완료" >
					
					<input type="button" value="취소" onclick="moveBack()">
				<%} %>
					<input type="button" value="목록" onclick="moveList()">
				</td> 
			</tr>
		</table>
	</form>
</fieldset>
<% } %>
</body>
</html>