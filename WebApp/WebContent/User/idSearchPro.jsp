<%@page import="com.itwillbs.user.UserDAO"%>
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
	request.setCharacterEncoding("UTF-8"); 

	String name = request.getParameter("name"); 
	String email = request.getParameter("email");
	
	UserDAO udao = new UserDAO(); 
	
	String id ="" ; 
	id = udao.getId(name, email);
	
	
	if(id != null){
		String show_id ="";	 
		int len = id.length() ; 
		boolean isLarger6 = false; 
		if( len < 6 ){
			// 길이가 6보다 작은 경우 가운데 2개 가리기.
			isLarger6 = false; 
		}else{
			// 길이가 6보다 큰 경우 가운데 3개 가리기. 
			isLarger6 = true; 
		}
		for(int i = 0 ; i< id.length() ; i++){
			
			if(i == (id.length()/2) || i == (id.length()/2 +1) ) {
				show_id +="*"; 
			}else{
				if(isLarger6 && (i == (id.length()/2) - 1) ){ 
					show_id +="*";
				}else{
					show_id += id.charAt(i);
				}
			}
		}
		session.setAttribute("id", show_id);
	}else{
		id = ""; 
	}
%>
<script>

	if("<%=id%>" != ""){
		window.open( "emailCheckPro.jsp?email=<%=email%>" , "이메일 인증","width=500,height=600");
	}else{
		alert("입력하신 정보와 일치하는 회원이 없습니다."); 
	}
	location.href = "idPwSearch.jsp"

</script>
</body>
</html>