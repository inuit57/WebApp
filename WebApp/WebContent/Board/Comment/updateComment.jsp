<%@page import="com.itwillbs.comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="cb" class="com.itwillbs.comment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>

<%
	CommentDAO cDAO = new CommentDAO();

	String uid = (String)session.getAttribute("id"); 
	String vote = request.getParameter("vote"); 
	if(vote == null) vote =""; 
	if(uid == null) uid="" ; 
	
	boolean flag = false; 
	
	int updown = 0 ; 
	
	if(vote.equals("")){
		flag = cDAO.updateComment(cb);
	}else if(!uid.equals("")){
		if(vote.equals("up")){
			updown =1 ; 
		}else{
			updown =0 ; 
		}
		flag = cDAO.updownvote(cb, uid, updown); 
	}
	
%>

<script type="text/javascript">

	if(<%=flag%>){
		console.log("댓글 업데이트 완료"); 
		//location.href="../boardView.jsp?bID=<%=cb.getBid()%>" ;
	}else if("<%=uid%>" ==""){
		if(confirm("추천/비추천을 하시려면 로그인 하셔야 합니다. 로그인 하시겠습니까?")){
			//location.href="<%=request.getContextPath()%>/User/Login/loginForm.jsp"; 
		}
	}else if("<%=vote%>" != ""){
		alert("이미 추천/비추천을 주셨습니다.");
		//location.href="../boardView.jsp?bID=<%=cb.getBid()%>" ;
	}
</script>

<%=flag %>
</body>
</html>