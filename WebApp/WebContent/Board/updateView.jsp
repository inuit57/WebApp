<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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

	UserDAO uDAO = new UserDAO(); 
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
	<form action="updatePro.jsp" method="post" enctype="multipart/form-data" onsubmit="return update()">
		<table border="2">
			<tr> 
				<td>
					<select name="btype" >
						<% if( uDAO.getUserBean(bb.getUid()).getUserGrant() >2 ){ %>
							<option value="1" <% if(bb.getBtype().equals("1")){ %>selected="selected" <%} %>>공지</option>
						<%} %>
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
				<td colspan="3">
				<input type="text" id="file_now" readonly="readonly"
					value="<%= (bb.getFile_name()==null) ? "" : bb.getFile_name() %>">
				<input type="button" name="file_delete" value="파일삭제" 
					onclick="deleteFile()"> 
				</td>				
			</tr>
			<tr>
				<td colspan="3" >
				<input type="file" name="file_name" id="file_name" onchange="updateFile(this)">
				</td>
			</tr>
			<script>
				function deleteFile(){
					
					console.log(document.getElementById("file_name"));
					console.log(document.getElementById("file_now"));
					
					// TODO : Ajax로 처리하기 
					// 파일 경로 + 이름 넘겨서 삭제 로직 처리. 
					// window.open("deleteFile.jsp?file_name=<%=bb.getFile_name()%>");
					//여기에서 할 게 아니라 submit 되면 거기에서 처리해야겠네. 
					document.getElementById("file_name").value="";
					document.getElementById("file_now").value="";
					
				}
				function updateFile(fileName){ 
					document.getElementById("file_now").value=fileName.value;  
				}
			</script>			
			<tr>
				<td colspan="3" align="right">
				<%
					if ( bb.getUid().equals(session.getAttribute("id"))){
						// TODO : 계정 권한이 관리자인 경우에도 삭제 버튼 활성화 되도록 추가
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