<%@page import="com.itwillbs.user.UserBean"%>
<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="com.itwillbs.comment.CommentDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="cb" class="com.itwillbs.comment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>

<%
	CommentDAO cDAO = new CommentDAO(); 

	boolean flag = cDAO.insertComment(cb);
	
	String id = (String)session.getAttribute("id"); 
	if(id == null){ id ="";} 
 
	
	UserDAO uDAO = new UserDAO() ; 
	UserBean ub = uDAO.getUserBean(id);
	
	String grantUpdate = "no";  
	

	
	// 여기에서 유저 권한 업데이트도 같이 처리해주도록 합시다.	
	if((ub.getUserGrant() < 1)  && (cDAO.getCommentCnt(id) >= 3) ) {
		//비회원이고 댓글 갯수가 3개 이상이라면 정회원으로 등업시켜준다. 		
		if(uDAO.updateUser(id, 1)){  // 정회원으로 등업! 
			// 등업완료 메시지를 json에 담아주도록 하자.
			grantUpdate = "yes" ; 
		}		
	}
%>

{ "grantUpdate" : "<%=grantUpdate %>" } 