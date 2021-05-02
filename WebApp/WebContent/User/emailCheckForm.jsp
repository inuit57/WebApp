<%@page import="mailTest.KeyGenerator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  TODO : 시간 제한을 두는 것도 생각해볼 수 있겠다. -->
<!--  세션에 넣고 제한 시간을 두면 되려나.  -->

<input type="text" id="key_input" placeholder="인증키를 입력하세요"> <br>
<input type="button" value="인증키 재발송" onclick="generateKey()">
<input type="button" value="인증 확인" onclick="check()"> <br>
<%
	request.setCharacterEncoding("UTF-8"); 
	
	String email_addr = (String)session.getAttribute("email");
	
	if(email_addr == ""){
		email_addr = request.getParameter("email");
	}else{
		session.setAttribute("email", email_addr); 
	}
	  
			//request.getParameter("email"); 
	
	String Key = (String)session.getAttribute("key");  
%>
<%

	boolean flag = false ; 
	// 여기 안에서 한번에 바꾸려고 처리하려니까 잘 되진 않는다. 
	// 세션 안에 집어넣고 처리하는 식으로 구현하는 것으로 한다. 
%>

<script type="text/javascript">
	
	//var key = "test"; 
	
	function generateKey(){
		//location.reload();
		location.href="emailCheckPro.jsp"; 
	}
	
	function check(){
		if (document.getElementById("key_input").value == "<%=Key%>" ){
			alert("인증 완료 되었습니다..");
			opener.document.fr.emailCheck.value = "Yes"; 
			opener.document.fr.email.value = "<%=email_addr%>" ; //값 넣어주기 
			
			self.close(); 
		}else{
			alert("인증 암호를 다시 확인하세요.  " +  "<%=Key%>" );
			//opener.document.fr.id.value = ""; 
			//opener.document.fr.emailCheck.value = "";
			//self.close();
		}
	}

		 
	
	var stDate = new Date().getTime();
	var edDate = new Date().getTime() + 50000; // 종료날짜
	var RemainDate = edDate - stDate;
	 
	
	var time =  60 ; 
	var min = "" ; //분
	var sec= "" ; // 초
	
	var x = setInterval(function() { 
		min = parseInt(time/60) ; 
		sec = time%60 ; 
		
		document.getElementById("time").innerHTML = min + "분" + sec + "초"; 
		
		time -- ; 
		
		if(time < 0){
			clearInterval(x) ; 
			document.getElementById("time").innerHTML = "시간초과"; 
			<% session.removeAttribute("key"); %>
			alert("인증시간이 만료되었습니다. 인증키를 재발급하세요.");
			//location.href="emailCheckPro.jsp?timeout=1"; 
		}
		
		
	} , 1000);
	
	//removeAttribute(String name)
</script>

<p>남은시간 : <span id="time"></span></p>
</body>
</html>