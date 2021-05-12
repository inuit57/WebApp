<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.itwillbs.comment.CommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.comment.CommentDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

// 	Class.forName("com.mysql.jdbc.Driver"); 
// 	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/itwill" ,"root", "1234"); 

	CommentDAO cdao = new CommentDAO(); 
	
	int bid = Integer.parseInt( request.getParameter("bid") ) ; 
	
	ArrayList<CommentBean> cbList = cdao.getCommentList(bid); 
	 
	JSONArray cmList = null ; 
	if(cbList.size() > 0){
		cmList = new JSONArray();	
		for(CommentBean cb : cbList){
			JSONObject cmBean = new JSONObject();
			
			cmBean.put("cm_id" , cb.getCm_id()) ; //hidden으로. 
			cmBean.put("uid", cb.getUid()); 
			cmBean.put("content", cb.getContent()); 
			cmBean.put("upvote" , cb.getUpvote()); 
			cmBean.put("downvote" , cb.getDownvote()); 
			
			cmList.add(cmBean); 
		}
	}
%>

<% if (cmList != null){ %>
	<%=cmList%>
<%}%> 