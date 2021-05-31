<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 

	String name = request.getParameter("name"); 
	String email = request.getParameter("email");
	
	UserDAO udao = new UserDAO(); 
	
	String id ="" ; 
	id = udao.getId(name, email);
	
	System.out.println("id 검색 결과 : "+ id) ; 
	
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
		session.setAttribute("id2", show_id);
	}else{
		id = ""; 
	}
%>
<%-- <script>

	if("<%=id%>" != ""){
		window.open( "emailCheckPro.jsp?email=<%=email%>" , "이메일 인증","width=500,height=600");
		setTimeout(() => location.href = "idPwSearch.jsp", 1000) ;
	}else{
		alert("입력하신 정보와 일치하는 회원이 없습니다."); 
		location.href = "idPwSearch.jsp" ;
	}
	 

</script> --%>

{"id" : "<%=id %>"}
