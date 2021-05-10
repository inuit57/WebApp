<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="com.itwillbs.comment.CommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.comment.CommentDAO"%>
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
		var viewType = <%=(String)session.getAttribute("viewType")%>;
		
		if (curr == null) curr = 1 ;
		if (listCnt == null) listCnt = 3; 
		
		if( viewType == "1"){
			location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 
		}else if ( viewType == "2"){
			location.href="ImageBoard.jsp?listCnt="+listCnt;
		}
		
	}
	
	function updateView(bid){
		//UpdateView를 따로 만들지 않고
		//여기 안에서 disable을 풀어주고 수정을 바로 할 수 있게 시도했으나 잘 되지 않는다.
		//제이쿼리 검색해서도 해보았는데 잘 되지는 않는다... ㅠㅠ 
		
		//TODO : 비밀번호를 한번더 받도록 한다? -> 굳이? 
		location.href="updateView.jsp?bID="+bid; 
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 내용</title>
</head>


<body>
<%
	request.setCharacterEncoding("UTF-8"); 
	String bid = request.getParameter("bID"); 
	
	int bid_n = 0  ; 
	BoardDAO bDAO = new BoardDAO(); 
	CommentDAO cDAO = new CommentDAO(); 
	UserDAO uDAO = new UserDAO(); 
	BoardBean bb = null ; 
	ArrayList<CommentBean> arrCb = null ;
	if(bid == null){ 
		response.sendRedirect("../User/Login/main.jsp");
	}else{
		bid_n = Integer.parseInt(bid) ; 
		bb = bDAO.getBoard(bid_n); 
		
		arrCb = cDAO.getCommentList(bid_n); 
	}
	
	
	boolean isAdmin = false; 
	String uid ="";
	if(session.getAttribute("id") != null ){
		isAdmin = (uDAO.getUserBean((String)session.getAttribute("id")).getUserGrant() > 2) ;
		uid = (String)session.getAttribute("id"); 
	}
	
	/// TODO : 조회수 늘여주는 로직 넣기 
	// 단, 새로고침 등의 행위로 조회수가 늘어나지 않도록 조치를 취할 필요가 있다. 
	// IP를 체크하는 것이 좋을까, 아니면...다른 좋은 방법이 있을까.
	 
%>

<% if ( bb != null ){ 

	//정상적으로 들어왔으니까 여기에서 조회수를 증가시켜주도록 하자. 
	
	bDAO.updateBoard(bb.getBid()); 
%>

<!--  header 시작 -->
 
 <jsp:include page="/layout/header.jsp"></jsp:include>
 
<!--  header 끝 -->
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<fieldset> 
	<legend>게시글 내용</legend>
	<form  class="form-inline">
	<div class="form-group">
		<table border="1"  id="tb" class="table table-bordered ">
			<tr> 
				<td>
					<select name="btype" class="col-sm-2 form-control"  disabled="disabled" >
						<% if( isAdmin ){ %>
							<option value="1" <% if(bb.getBtype().equals("1")){ %>selected="selected" <%} %>>공지</option>
						<% } %>
						<option value="2" <% if(bb.getBtype().equals("2")){ %>selected="selected" <%} %>>일반</option>
						<option value="3" <% if(bb.getBtype().equals("3")){ %>selected="selected" <%} %>>자료</option>
					</select>
				</td>
				<td colspan="5">
					<input   class="form-control"   type="text" name="bsubject" placeholder="제목"  
					readonly="readonly" value=<%=bb.getBsubject() %>>  

				</td>
			</tr>
			<tr> 
				<td colspan="6">
					<textarea   class="form-control"  rows="20" cols="35" name="bcontent" placeholder="내용" 
					readonly="readonly" ><%=bb.getBcontent() %> </textarea>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="right"> 
				<!--  파일명 출력해주기  -->
				 
				<%if( bb.getFile_name() != null ){%>
					<a href="../fileTest/fileDownload.jsp?file_name=<%=bb.getFile_name() %>"><%=bb.getFile_name() %></a>
				<%} %>
				
				<%
					if ( bb.getUid().equals(uid)){
						// TODO : 계정 권한이 관리자인 경우에도 삭제 버튼 활성화 되도록 추가
				%>
				
					<input type="button"   class="form-control"  id="editBtn" value="수정" onclick="updateView(<%=bid %>)" >
				
				
					<input type="button"   class="form-control"  value="삭제" onclick="location.href='deletePro.jsp?bid=<%=bid%>'">
				
				<%}else if( isAdmin ){ %>
				
					<input type="button"  class="form-control"  value="삭제" onclick="location.href='deletePro.jsp?bid=<%=bid%>'">
				
				<%} %>
				
					<input type="button"  class="form-control"  value="목록" onclick="moveList()">
				</td> 
			</tr>
			
			<!--  댓글들 읽어서 테이블 형태로 찍어주기 -->
			<%
			if(arrCb.size() > 0){
				%>
				<tr>
				<td colspan="6">댓글 목록</td>
				<!--  TODO : 댓글도 페이징 넣기?  -->
				</tr>
				<%
				for(int i = 0 ; i< arrCb.size(); i++){
					CommentBean cb = arrCb.get(i) ; 
					%>
					<tr>
						<td><%=cb.getUid() %></td>
						<td colspan = "6">
						
						<input  class="form-control"  type="text" id='comment<%=cb.getCm_id() %>' style="background-color: #e2e2e2;" 
						value='<%=arrCb.get(i).getContent() %>' readonly="readonly">
						
						<!-- TODO :  댓글 수정/삭제 버튼 -->
						<% if ( uid.equals(cb.getUid())){ %>
						<input  class="form-control"  type="button" id='btn<%=cb.getCm_id() %>' value="수정" onclick="editComment('<%=cb.getCm_id() %>')">
						<input  class="form-control"  type="button" value="삭제" onclick="deleteComment('<%=cb.getCm_id() %>')"></td>
						<%} %>
						
						<script>
							//이것도 Ajax로 동작을 변경할 것. 
							function editComment(index){
								var btn = document.getElementById('btn'+index); 
								var input = document.getElementById('comment'+index); 
								
								if(btn.value == '수정'){
									btn.value = '완료'; 
									input.style="background-color: white;"
									input.removeAttribute("readonly"); 
								}else{
									btn.value='수정'; 
									input.style="background-color: #e2e2e2;"
									input.setAttribute("readonly", "readonly");
									
									if(input.value == ""){
										alert("내용을 작성해주세요!"); 
									}else{
										//DB에 업데이트
										location.href="Comment/updateComment.jsp?bid="+<%=bid%>+"&cm_id="+index+"&content="+input.value ; 
									}
								}
																
							}//editComment(index)
							
							function deleteComment(index){
								location.href="Comment/deleteComment.jsp?bid="+<%=bid%>+"&cm_id="+index;
							}
						</script>
						
					</tr>
					<%
				}
			%>
			<%} %>
			<!--  댓글 유효성 검사 : required로 대체. -->
		 	<!-- <form class="form-inline"  action="Comment/insertComment.jsp"  > --> 
		 	<% if(!uid.equals("")){ %>
				<tr>
					<%-- <td align="center"><input  class="form-control" type="text" name="uid" value='<%=session.getAttribute("id") %>' readonly="readonly"></td> --%>
					
					<td> <%=uid %> </td> 
					<td colspan="4">
						<input class="form-control"  type="text" id="content" name="content" placeholder="댓글" required="required">
						<%-- <input type="hidden" name="bid" value="<%=bid %>"> --%>
					</td>
					<td><input  class="form-control"  type="button" value="작성" onclick="insertComment()"></td>
					<script>
						function insertComment(){
							// TODO : Ajax로 변경할 것.  
							location.href="Comment/insertComment.jsp?uid=<%=session.getAttribute("id") %>"+"&content="+document.getElementById('content').value+"&bid=<%=bid%>";
						}
					</script>
				</tr>
			<%} %>
			<tr>
				<td>다음글</td>
				<td colspan="5" align="center">
				<%
					BoardBean bb2 = bDAO.getNextBoard(bid_n); 
					if(bb2 !=null){
						%>
						<a href="boardView.jsp?bID=<%=bb2.getBid() %>">
							<%=bb2.getBsubject() %>(<%=bb2.getComment_cnt() %>)
						</a>
						<%
					}else{
				%>
					다음 글이 없습니다.
				<%} %>
				</td>
			</tr>
			<tr>
				<td>이전글</td>
				<td colspan="5" align="center">
				<%
					BoardBean bb3 = bDAO.getPreBoard(bid_n); 
					if(bb3 !=null){
						%>
						<a href="boardView.jsp?bID=<%=bb3.getBid() %>">
							<%=bb3.getBsubject() %>(<%=bb3.getComment_cnt() %>)
						</a>
						<%
					}else{
				%>
					이전 글이 없습니다.
				<%} %>
				</td>
			</tr>
		</table>
		</div>
		</form>
		
</fieldset>
<% } %>
</body>
</html>