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

	CommentDAO cdao = new CommentDAO(); 
	
	int bid = Integer.parseInt( request.getParameter("bid") ) ; 
	String isBest = request.getParameter("isBest"); 
	
	ArrayList<CommentBean> cbList = null ; 
	
	if(isBest.equals("no")){
		cbList = cdao.getCommentList(bid);
	}else{
		cbList = cdao.getBestCommentList(bid); 
	}
	 
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
			
			cmBean.put("alive", cb.getAlive()); 
			cmBean.put("ref" , cb.getRef()); 
			cmBean.put("lev" , cb.getLev()); 
			
			cmList.add(cmBean); 
		}
	}
%>

<% if (cmList != null){ %>
	<%=cmList%>
<%}%> 