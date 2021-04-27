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
	
	function updateView(bid){
		//UpdateView를 따로 만들지 않고
		//여기 안에서 disable을 풀어주고 수정을 바로 할 수 있게 시도했으나 잘 되지 않는다.
		//제이쿼리 검색해서도 해보았는데 잘 되지는 않는다... ㅠㅠ 
		
		//TODO : 비밀번호를 한번더 받도록 한다? 
		location.href="updateView.jsp?bID="+bid; 
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 내용</title>
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
		<table border="2">
			<tr> 
				<td>
					<select name="btype"  disabled="disabled" >
						<option value="1" <% if(bb.getBtype().equals("1")){ %>selected="selected" <%} %>>공지</option>
						<option value="2" <% if(bb.getBtype().equals("2")){ %>selected="selected" <%} %>>일반</option>
						<option value="3" <% if(bb.getBtype().equals("3")){ %>selected="selected" <%} %>>자료</option>
					</select>
				</td>
				<td colspan="2">
					<input type="text" name="bsubject" placeholder="제목"  
					readonly="readonly" value=<%=bb.getBsubject() %>>  
				</td>
			</tr>
			<tr> 
				<td colspan="3">
					<textarea rows="20" cols="30" name="bcontent" placeholder="내용" 
					readonly="readonly" ><%=bb.getBcontent() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
				<%
					if ( bb.getUid().equals(session.getAttribute("id"))){
						// TODO : 계정 권한이 관리자인 경우에만 삭제 버튼 활성화 되도록 추가
				%>
					<input type="button" id="editBtn" value="수정" onclick="updateView(<%=bid %>)" >
					
					<input type="button" value="삭제" onclick="location.href='deletePro.jsp?bid=<%=bid%>'">
				<%} %>
					<input type="button" value="목록" onclick="moveList()">
				</td> 
			</tr>
		</table>
</fieldset>
<% } %>
</body>
</html>