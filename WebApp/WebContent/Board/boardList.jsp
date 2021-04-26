<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function prePage(curr , min){
		//function prePage(curr){
		//location.href="boardList.jsp?currentIndex="+(curr-1);
		curr = curr - 1; 
		if(curr < min){ curr = min; }
		location.href="boardList.jsp?currentIndex="+(curr);
	}

	function postPage(curr , max){
		//function postPage(curr){
		//location.href="boardList.jsp?currentIndex="+(curr+1);
		curr = curr + 1; 
		if(curr > max) { curr = max; }
		location.href="boardList.jsp?currentIndex="+(curr);
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 목록</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String curr = request.getParameter("currentIndex");
	int currentIndex =1 ; 
	if(curr != null){
		currentIndex = Integer.parseInt(curr);
	}

	BoardDAO bDao = new BoardDAO(); 
	ArrayList<BoardBean> arrBB = bDao.getBoardList(); 

	int size = arrBB.size();  // 전체 게시글 숫자
	int listCut = 3; //한 페이지 목록에 보여질 게시글의 숫자.
	int listStart = (currentIndex-1)*listCut; 
	int listEnd = listStart+listCut ; 
	
	if(listEnd > size) listEnd = size; 
	
	
	int pageCut = 3 ; // 아래 페이지 목록 넘어가는 기준.
	int pageStart = 1+((currentIndex-1)/pageCut)*pageCut ; 
	int pageEnd = pageStart+pageCut-1 ; 
	
	int maxIndex = size/3 + ((size%3 == 0) ? 0 : 1 );
	if(pageEnd > maxIndex) pageEnd = maxIndex; 
	
	if(size >0){
%>
<h1> 총 글 갯수 : <%=arrBB.size() %></h1>

<table border="1">
	<tr>
		<th>번호</th>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<%
	//for(BoardBean bb : arrBB){
		//for(int i = 0 ; i< arrBB.size(); i++){
		for(int i = listStart  ; i< listEnd ; i++){
			BoardBean bb = arrBB.get(i); 	
	%>
		<tr>
			<td align="center"><%=bb.getBid() %></td>
			<td>
				<% int type = Integer.parseInt(bb.getBtype());
					String typeStr = ""; 
					switch(type){
					case 1 : typeStr="공지";break;
					case 2 : typeStr="일반";break;
					case 3 : typeStr="자료";break;
					default :typeStr="오류" ; 
					}
				%>
				<%=typeStr %>
			</td>
			<td><%=bb.getBsubject() %></td>
			<td><%=bb.getUid() %> </td>
			<td><%=bb.getBdate() %></td>
		</tr>
	<%	
	}%>
	<tr>
		<td colspan="5" align="right">
			<input type="button" value="글 작성" onclick="location.href='insertForm.jsp'">
			<input type="button" value="메인으로" onclick="location.href='../User/Login/main.jsp'">
		</td>
	</tr>
</table>

<%
	//이전 버튼
		//if(pageStart > pageCut){
			%>
			<input type="button" value="이전" onclick="prePage(<%=currentIndex%>,1)">
			<%
		//}
		//페이지 번호 출력.
		for(int i= pageStart ; i <= pageEnd ; i++){
%>
			<a href="boardList.jsp?currentIndex=<%=i %>"><%=i %></a>
	<%} 	
	%>
	<%//다음 버튼
	//if(pageEnd < maxIndex ){
	%>
		<input type="button" value="다음" onclick="postPage(<%=currentIndex%>,<%=maxIndex%>)">
	<%//}	%>
<%		
	}else{
	%>
	등록된 글이 없습니다.
<% }%>
</body>
</html>