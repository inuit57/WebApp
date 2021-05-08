<%@page import="com.itwillbs.comment.CommentDAO"%>
<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
	a {
	  text-decoration-line: none;
	}
</style>


<script type="text/javascript">
	function prePage(curr , min , listCnt){
		//function prePage(curr){
		//location.href="boardList.jsp?currentIndex="+(curr-1);
		curr = curr - 1; 
		if(curr < min){ curr = min; }
		location.href="boardList.jsp?currentIndex="+(curr) +"&listCnt="+listCnt;
	}

	function postPage(curr, max,listCnt){
		//function postPage(curr){
		//location.href="boardList.jsp?currentIndex="+(curr+1);
		curr = curr + 1; 
		if(curr > max) { curr = max; }
		location.href="boardList.jsp?currentIndex="+(curr)+"&listCnt="+listCnt;;
	}
		
	function listChange(listCnt){
		location.href="boardList.jsp?listCnt="+listCnt; 
	}
	
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 목록</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String curr = request.getParameter("currentIndex");
	String listCnt = request.getParameter("listCnt"); 
	String id = (String)session.getAttribute("id");
	
	
	String btype = request.getParameter("btype");
	
	String searchType = request.getParameter("searchType");

	String searchText = request.getParameter("searchText");
	
	
	if(id == null){
		//response.sendRedirect("../User/Login/main.jsp");
		//메인으로 이동시키는 대신, 비회원이더라도 기능 제한을 두고 
		//글 내용을 확인하는 것은 가능하도록? 
	}
	
	//TODO : 세션 또는 쿠키에 저장하자. 
	// curr, listCnt  
	// 세션에 저장하는 게 좋으려나. 
	
	int currentIndex =1 ; 
	if(curr != null){
		currentIndex = Integer.parseInt(curr);
		session.setAttribute("curr", curr); 
	}

	session.setAttribute("viewType", "1");  // 1 : list 
	session.setMaxInactiveInterval(5000); 

	
	BoardDAO bDao = new BoardDAO(); 
	
	
	ArrayList<BoardBean> arrBB = bDao.getBoardList(); //아무 조건도 안 주었을 경우에 나오는 경우
	
	//아래에 검색기능을 적용하였을 때를 좀 넣어보도록 하자. 
	//검색한 정보도 내가 가지고 있다가 넣어줘야한다. 
	
	//먼저 분류만으로 조회한 경우 -> 이거는 따로 만들거나 하자. 
	if(btype != null && !btype.equals("*")){
		arrBB = bDao.getBoardList(btype); 
	}
	
	if ( searchText != null) { 
		System.out.println(searchText); 
		arrBB = bDao.getBoardList(btype, searchType, searchText); 				
	}else{
		System.out.println("아무것도 없사와요");
	}
	
	
	
	int size = arrBB.size();  // 전체 게시글 숫자
	int listCut = 3; //한 페이지 목록에 보여질 게시글의 숫자.
	if(listCnt != null){
		listCut = Integer.parseInt(listCnt); 
		session.setAttribute("listCnt", listCnt); 
	}
	
	int listStart = (currentIndex-1)*listCut; 
	int listEnd = listStart+listCut ; 
	
	if(listEnd > size) listEnd = size; 
	
	
	int pageCut = 3 ; // 아래 페이지 목록 넘어가는 기준.
	int pageStart = 1+((currentIndex-1)/pageCut)*pageCut ; 
	int pageEnd = pageStart+pageCut-1 ; 
	
	int maxIndex = size/listCut + ((size%listCut == 0) ? 0 : 1 );
	if(pageEnd > maxIndex) pageEnd = maxIndex; 
	
	if(size >0){
%>
<%-- <h1> 총 글 갯수 : <%=arrBB.size() %></h1> --%>
<%-- <h2> 현재 사용자 : <%=session.getAttribute("id") %></h2> --%>

<div align="center">
<table border="1"  id="tb" class="table  table-hover table-bordered "">
	<tr>
		<td id="max_size_td"  colspan="6" align="right">
			한 페이지당 글 갯수 : 
			<select name="listCut" onchange="listChange(this.value)">
				<option value="3"  <%if(listCut == 3){%> selected="selected" <%} %>>3</option>
				<option value="5"  <%if(listCut == 5){%> selected="selected" <%} %> >5</option>
				<option value="10" <%if(listCut == 10){%> selected="selected" <%} %> >10</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>번호</th>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%
	int i ; 
	//for(BoardBean bb : arrBB){
		//for(int i = 0 ; i< arrBB.size(); i++){
		for(i = listStart  ; i< listEnd ; i++){
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
					default :typeStr="" ; 
					}
				%>
				<%=typeStr %>
			</td>
			<td>
				<a href="boardView.jsp?bID=<%=bb.getBid() %>" onclick="return userGrantCheck(<%=bb.getBtype()%>)">
					<%=bb.getBsubject() %>(<%=bb.getComment_cnt() %>)
				</a>
			</td>
			<td><%=bb.getUid() %> </td>
			<td><%=bb.getBdate() %></td>
			<td><%=bb.getView_cnt() %></td>
		</tr>
	<%	
	}%>
	<%
		if(listEnd == size){
			for(; i<listStart+listCut ; i++){
				%>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
				<%
			}
		}
	%>
	<tr>
		<td id="max_size_td"  colspan="6" align="right">
			<input type="button" value="갤러리로 전환" onclick="location.href='ImageBoard.jsp'">
			<% if ( id != null){ %>
			<input type="button" value="글 작성" onclick="location.href='insertForm.jsp'">
			<% } %>
			<input type="button" value="메인으로" onclick="location.href='../User/Login/main.jsp'">
		</td>
	</tr>
</table>
<div align="center">

<!-- 검색 기능 -->
<form action="boardList.jsp" class="form-inline">
 	<div class="form-group">
		<select class="col-sm-2 form-control" name="btype">
			<option value="_">전체</option>
			<option value="1">공지</option>
			<option value="2">일반</option>
			<option value="3">자료</option>
		</select> 
		<select class="col-sm-2 form-control" name="searchType">
			<option value="bsubject">제목</option>
			<option value="uid">작성자</option>
			<option value="bcontent">내용</option>
		</select>
		<div class="col-xs-4" align="center">
			<input type="text"   class="form-control" name="searchText" placeholder="검색어를 입력하세요.">
		</div>
	</div>
	<input type="submit"  class="btn btn-default" value="검색">
</form>
</div>

</div>	
<div align="center">
<%
	//이전 버튼
		//if(pageStart > pageCut){
			%>
			<input type="button"  class="btn btn-default" value="이전" onclick="prePage(<%=currentIndex%>,1,<%=listCut%>)">
			<%
		//}
		//페이지 번호 출력.
		for(i= pageStart ; i <= pageEnd ; i++){
%>
			<a href="boardList.jsp?currentIndex=<%=i %>"><%=i %></a>
	<%} 	
	%>
	<%//다음 버튼
	//if(pageEnd < maxIndex ){
	%>
		<input type="button"  class="btn btn-default" value="다음" onclick="postPage(<%=currentIndex%>,<%=maxIndex%>,<%=listCut%>)">
	<%//}	%>
</div>	
<%		
	}else{
	%>
	등록된 글이 없습니다.
<% }%>
</body>
</html>