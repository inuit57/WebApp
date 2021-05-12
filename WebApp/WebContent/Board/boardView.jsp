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
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

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
	
	
	 
%>

<% if ( bb != null ){ 

	//정상적으로 들어왔으니까 여기에서 조회수를 증가시켜주도록 하자. 
	// TODO : 조회수 계속 증가하지 못하도록 막을 것. 
	// 쿠키를 사용해볼까. 
	
	Cookie[] cookies = request.getCookies();
	String str_bid = Integer.toString(bb.getBid());  
	boolean flag = true; 
	if(cookies != null && cookies.length >0){
		for(Cookie c : cookies){
			if(c.getName().equals(str_bid)){
				if(c.getValue().equals(uid)){
					flag = false; 			
				}
			}
			
		}
	}
	
	if(flag){
		//조회수 증가!
		// 유저 id, 그리고 게시글 번호를 같이 저장해야 한다.
		// 무엇을 키로 줘야하지. 게시글 번호를 키로 주고 유저id를 저장하자.
		// 그리고 유저가 로그아웃 한다면 쿠키를 다 지워버리는 식으로 구현하자. 
		//(유저마다 쿠키를 다르게 가져갈 수 있도록)
		
		if( !uid.equals("")) { //비회원은 굳이...조회수 증가 중복은 신경쓰지 말자. 일단은 
			Cookie cookie = new Cookie(str_bid, uid) ;
			cookie.setMaxAge(3600) ; // 단위 : 초
			response.addCookie(cookie);
			System.out.println("쿠키 생성 완료"); 
		}
		bDAO.updateBoard(bb.getBid());
	}
	
%>

<script type="text/javascript">
 

		// 댓글창 업데이트 
	function commentLoad(){
		$.ajax({ 
			url : "<%=request.getContextPath()%>/Board/Comment/commentList.jsp" , 
			type : "post", 
			data : {bid : "<%=bid%>" },
			dataType: "json", 
			success:function(data){
				var t = ""; 
				
				$.each(data, function(index,item ){
					
					t+="<tr>"; 
					t+="<td>"+ item.uid +"</td>";
					t+="<td colspan = '3'><input  class='form-control'  type='text'style='background-color: #e2e2e2;' "+ 
						"value="+item.content+" id='comment"+item.cm_id+ "' readonly='readonly'> </td>"; 

					
					
					t+="<td align='center'><a href='javascript:void(0);' id='upvote"+item.cm_id+ "' "+ 
						"onclick='upvoteComment("+item.cm_id+")'>"+ item.upvote +"<br>[▲]</a></td>";
					t+="<td align='center'><a href='javascript:void(0);' id='downvote"+item.cm_id+"' "+
						"onclick='downvoteComment("+item.cm_id + " )'>"+ item.downvote +"<br>[▼]</a></td>";
					// 이렇게 하면 함수 리턴 값 출력 신경안쓰고 할 수 있다.
					// 클릭해도 최상위로 안가고 좋아 좋아. 
					
// 					t+="<td align='center'><span id=upvote"+item.cm_id+" >"+ item.upvote +"</span><br>[▲]</td>";
// 					t+="<td align='center'><span id=downvote"+item.cm_id+" >"+ item.downvote +"</span><br>[▼]</td>";

					t+="</tr>";
					<!-- 댓글 수정/삭제 버튼 -->
					
					if(item.uid == '<%=uid%>'){
						t+="<tr>"; 
						t+='<td align="right" colspan="6">' ; 
						t+='<input  class="form-control"  type="button" id="btn'+item.cm_id+'" value="수정" onclick="editComment('+item.cm_id+ ')">' ;
						<!-- TODO : 답글 기능 넣기 -->
						t+='<input  class="form-control"  type="button" value="답글" onclick="">'
						t+='<input  class="form-control"  type="button" value="삭제" onclick="deleteComment('+item.cm_id+')">' ;
					}	
					$('#commentHead').nextAll().remove(); //append전에 비워주기 
					$('#commentList').append(t);
				})
			}
		}) //ajax끝.
	}
	 
	$(document).ready(function(){
		commentLoad(); //댓글 가져오기 
	}); 

	function editComment(index){
		
		console.log('btn'+index); 
		
		var btn = document.getElementById('btn'+index); 
		//console.log(btn); 
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
				//location.href="Comment/updateComment.jsp?bid="+<%=bid%>+"&cm_id="+index+"&content="+input.value ; 
				
				$.ajax({ 
					url : "Comment/updateComment.jsp",
					type : "post", 
					data : {bid : "<%=bid%>" , cm_id : index , content : input.value }, 
					datayType :"json" , 
					success:function(data){
						console.log(data); 
						//commentLoad();
					}
				});
					
			}
		}
										
	}//editComment(index)
	
	function deleteComment(index){
		//location.href="Comment/deleteComment.jsp?bid="+<%=bid%>+"&cm_id="+index;
		
		$.ajax({ 
			url : "Comment/deleteComment.jsp",
			type : "post", 
			data : {bid : "<%=bid%>" , cm_id : index }, 
			success:function(data){
				commentLoad();
				console.log(data); 
			}
		});
	}
	
	function upvoteComment(index){
		//location.href="Comment/updateComment.jsp?bid="+<%=bid%>+"&cm_id="+index+"&vote="+updown ;
		
		$.ajax({ 
			url : "Comment/updateComment.jsp",
			type : "post", 
			data : {bid : "<%=bid%>" , cm_id : index , vote : "up" }, 
			datayType :"json" , 
			success:function(data){
				commentLoad(); 
				if(data.result == 0){
					console.log("정상 업데이트 완료!");
				}else if(data.result == 1){
					if(confirm("추천/비추천을 하시려면 로그인 하셔야 합니다. 로그인 하시겠습니까?")){
						location.href="<%=request.getContextPath()%>/User/Login/loginForm.jsp"; 
					}
				}else if(data.result == 2){
					alert("이미 추천/비추천한 댓글입니다.");
				}else if(data.result == 3){
					alert("자신의 댓글에는 추천/비추천할 수 없습니다."); 
				} 
			},
			error:function(data){
				console.log("error") 
			}
		});
	}
	function downvoteComment(index){
		//location.href="Comment/updateComment.jsp?bid="+<%=bid%>+"&cm_id="+index+"&vote="+updown ;
		
		$.ajax({ 
			url : "Comment/updateComment.jsp",
			type : "post", 
			data : {bid : "<%=bid%>" , cm_id : index , vote : "down" }, 
			datayType :"json" , 
			success:function(data){
				commentLoad();
				if(data.result == 0){
					console.log("정상 업데이트 완료!");
				}else if(data.result == 1){
					if(confirm("추천/비추천을 하시려면 로그인 하셔야 합니다. 로그인 하시겠습니까?")){
						location.href="<%=request.getContextPath()%>/User/Login/loginForm.jsp"; 
					}
				}else if(data.result == 2){
					alert("이미 추천/비추천한 댓글입니다.");
				}else if(data.result == 3){
					alert("자신의 댓글에는 추천/비추천할 수 없습니다."); 
				}  
			},
			error:function(data){
				console.log("error") 
			}
		});
	}
</script>					

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
					readonly="readonly" value="<%=bb.getBsubject() %>">  

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
			
			
			<!-- TODO : 베스트 댓글 3개 정도 넣어주기  -->
			
			<!--  댓글들 읽어서 테이블 형태로 찍어주기 -->
			<tr>
			<td colspan="7">
			<table id="commentList" class="table table-bordered " >
			<%
			if(arrCb.size() > 0){
				%>
				<tr id="commentHead">
				<td colspan="6" align="right"> [댓글 목록]     
				<input class="form-control" type="button" onclick="commentLoad()" value="댓글 새로고침">
				</td>
				<!--  TODO : 댓글도 페이징 넣기?  -->
				</tr>
			
			<%} %>
			</table>
			</td>
			</tr>
			<!--  댓글 유효성 검사 : required로 대체. -->
		 	<% if(!uid.equals("")){ %>
				<tr>
					<%-- <td align="center"><input  class="form-control" type="text" name="uid" value='<%=session.getAttribute("id") %>' readonly="readonly"></td> --%>
					
					<td> <%=uid %> </td> 
					<td colspan="4">
						<input class="form-control"  type="text" id="content" name="content" placeholder="댓글" required="required">
						<%-- <input type="hidden" name="bid" value="<%=bid %>"> --%>
					</td>
					<td><input  class="form-control"  id="comment_write" type="button" value="작성" onclick="insertComment()"></td>
					<script>
					
						function insertComment(){
							// TODO : Ajax로 변경할 것.  
							//location.href="Comment/insertComment.jsp?uid=<%=session.getAttribute("id") %>"+"&content="+document.getElementById('content').value+"&bid=<%=bid%>";
							
							var content = $("#content").val() ; 
							
							$.ajax({ 
								url : "Comment/insertComment.jsp",
								type : "post", 
								data : {uid : "<%=uid %>" ,content : content , bid : "<%=bid%>" }, 
								//datayType :"json" , 
								success:function(data){
									commentLoad(); 
									console.log("댓글 작성 완료!") ; 
								},
								error:function(data){
									console.log("error") ; 
								}
							});
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