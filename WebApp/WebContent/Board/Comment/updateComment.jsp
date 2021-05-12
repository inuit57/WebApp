<%@page import="com.itwillbs.comment.CommentBean"%>
<%@page import="com.itwillbs.comment.CommentDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="cb" class="com.itwillbs.comment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>

<%
	CommentDAO cDAO = new CommentDAO();

	String uid = (String)session.getAttribute("id"); 
	String vote = request.getParameter("vote");
	
	String cm_id = request.getParameter("cm_id"); 
	
	System.out.println(cm_id); 
	//if(cm_id != null){
	//	int cm_id_num = Integer.parseInt(cm_id); 
		// TODO : 자신의 댓글에는 추천/비추천 못하게 막기
	CommentBean cb2 = cDAO.getComment(Integer.parseInt(cm_id));
	//System.out.println(cb2.getUid());
	//}
	
	 
	
	if(vote == null) vote =""; 
	if(uid == null) uid="" ; 
	
	boolean flag = false; 
	
	int updown = 0 ; 
	
	if(vote.equals("")  ){
		flag = cDAO.updateComment(cb);
	}else if(!uid.equals("") && !uid.equals(cb2.getUid()) ){
		if(vote.equals("up")){
			updown =1 ; 
		}else{
			updown =0 ; 
		}
		flag = cDAO.updownvote(cb, uid, updown); 
	}
	
	int result = -1 ; 
	
	
	if (flag){
		result = 0 ;  // 정상 업데이트 완료 
	}else if(uid.equals("")){
		result = 1; // 로그인이나 하십쇼 - 비회원이 추천/비추천하려고 할 때 
	}else if(uid.equals(cb2.getUid())){
		result = 3; // 자신 댓글 추천하는 경우 
	}else if(!vote.equals("")){
		result = 2;  //이미 추천을 준 경우 
	}else{
		result = 4; //다른 예외 경우 처리용 
	}
	
%>


{ "result" : "<%=result %>"} 
