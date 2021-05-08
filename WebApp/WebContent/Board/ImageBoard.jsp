<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>게시판 : 갤러리뷰</title>

<script type="text/javascript">
	function userGrantCheck(btype){
		// 분류가 자료인 경우, 비회원은 볼 수 없도록 조치.
		if( <%=session.getAttribute("id")%> == null && btype == 3 ){
			if( confirm("비회원은 볼 수 없는 글입니다.로그인 하시겠습니까?") ) { 
				location.href= "<%=request.getContextPath()%>"+"/User/Login/loginForm.jsp"; 
			}
			return false; 
		}
	}
</script>
</head>
<body>

<!-- 
	이미지 파일을 등록하였다면 이미지 파일을 보여주고 
	만약 그렇지 않다면 기본 이미지를 보여주는 식으로 작업하도록 하자. 
	
	아니면 프로필 이미지를 보여주는 것은 어떨까. 
	만약 프로필 이미지를 등록하였다고 한다면. 
 -->

<%
	session.setAttribute("viewType", "2");  // 2 : gallery . 
	session.setMaxInactiveInterval(5000); 

	request.setCharacterEncoding("UTF-8"); 

	BoardDAO bDao = new BoardDAO(); 
	ArrayList<BoardBean> arrBB = bDao.getBoardList();
	
	int size = arrBB.size(); 

	int listCut = 3; 
	BoardBean bb = null; 
	
	String listCnt = request.getParameter("listCnt"); 
	if(listCnt != null){
		listCut = Integer.parseInt(listCnt);
		session.setAttribute("listCnt", listCnt);
	}
%>

<table border="2"> 
	<tr align="right">
		<td colspan= "<%=listCut%>">
		<input type="button" value="리스트로 전환" onclick="location.href='boardList.jsp'">
		한 열에 보이는 갯수 : 
		<select name="listCut" onchange="listChange(this.value)">
			<option value="3"  <%if(listCut == 3){%> selected="selected" <%} %>>3</option>
			<option value="4"  <%if(listCut == 4){%> selected="selected" <%} %> >4</option>
			<option value="5" <%if(listCut == 5){%> selected="selected" <%} %> >5</option>
		</select>
		<script type="text/javascript">
		
			function listChange(value){
				location.href="ImageBoard.jsp?listCnt="+value;
			}
		</script>
		</td>
	</tr>

	<% 
		for (int i = 0 ; i< (size/listCut) ; i++){ // 열 갯수	 	 
	%>
		<tr>
			<% for(int j = 0 ; j<listCut ; j++){  %>			
			<!-- 만약 등록된 파일이 이미지 파일이 아니거나 없는 경우 기본이미지를 보여주기 -->
			<td>
			<%
			 	String file_name = arrBB.get(i*listCut + j).getFile_name(); 
			 	if( (file_name != null && !file_name.equals("")) 
			 		 && ((file_name.indexOf(".jpg") > -1) || (file_name.indexOf(".png") > -1))){
			 		//System.out.println((file_name.indexOf(".png")) ); 
			 		// 파일 이름이 jpg , png 인 경우에 처리하도록. 
			 		ServletContext ctx = getServletContext(); 
			 		//String filePath = ctx.getRealPath("upload")+"\\"+file_name;
			 		// 문제 발생 - 서버 파일에 클라이언트가 접근하는 것은 보안상 막혀있다.
			 		// 그래서 이미지가 출력되지 않는다. (not allowed to load local resource)
			 		
			 		%>
			 	<img src="../fileTest/imgTest.jsp?file_name=<%=file_name %>" width="256" height="256">		
			 	<%
			 	}else{
			%>
			
			 <img src="../img/test.png" width="256" height="256">
			 <%} %>
			 </td>
			<%} %>
		</tr>
		<tr align="center">
			<% for(int j = 0 ; j< listCut ; j++){ 
				bb = arrBB.get(i*listCut+ j);	
			%>
			<td> 
		<!-- 제목 -->
			<a href="boardView.jsp?bID=<%=bb.getBid() %>" onclick="userGrantCheck(<%=bb.getBtype()%>">
			 [<%= (bb.getBtype().equals("1")) ? "공지" : (bb.getBtype().equals("2")) ? "일반" : "자료"  %>]<%= bb.getBsubject() %></a>  </td>

			<%} %>
		</tr>
	<%} //for문 종료 %>
</table>


<!-- TODO : 밑에 숫자로 여러 개 보이게도 좀 해줘야한다.  -->


</body>
</html>