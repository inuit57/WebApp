<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	// TODO : JSON으로 이쁘게 받아서 한번에 map에 때려박고 처리하기. 
	String[] uid_list = (request.getParameter("uid_list")).split(",");
	String[] grant_list = request.getParameter("grant_list").split(","); 
	
	HashMap<String, Integer> userMap = new HashMap<String,Integer>();
	int size = uid_list.length; 
	for(int i =0 ; i< size ; i++){
		userMap.put(uid_list[i], Integer.parseInt(grant_list[i])); 	
	}
	
	UserDAO udao = new UserDAO();
	
	boolean flag = false; 
	flag = 	udao.updateUser(userMap); 

%>

<script type="text/javascript">

	if(<%=flag%>){
		alert("총 "+<%=size%> + "명의 권한 업데이트 완료!") ; 
	}else{
		alert("업데이트 실패!"); 
	}
	location.href="userListForm.jsp"; 
</script>
</body>
</html>