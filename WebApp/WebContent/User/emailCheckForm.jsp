<%@page import="mailTest.KeyGenerator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>이메일 인증</title>
</head>
<body>

<input type="text" id="key_input" placeholder="인증키를 입력하세요"> <br>
<input type="button" value="인증키 재발송" onclick="generateKey()">
<input type="button" id="key_check" value="인증 확인" onclick="check()"> <br>
<%
	request.setCharacterEncoding("UTF-8"); 
	
	String email_addr = request.getParameter("email");
	
	if(email_addr != null){
		session.setAttribute("email", email_addr); 
	}
	
	// TODO : DB 상에서 email이 있는 경우, 아이디 찾기로 보내기? 
			 
	
	String Key = (String)session.getAttribute("key");  
%>
<%

	boolean flag = false ; 
	// 여기 안에서 한번에 바꾸려고 처리하려니까 잘 되진 않는다. 
	// 세션 안에 집어넣고 처리하는 식으로 구현하는 것으로 한다.
	
	String searchID = (String)session.getAttribute("id2"); 
	session.removeAttribute("id2") ; 
	// id로 동일하게 주니까 로그인 쪽에 id가 **로 가려져서 출력된다. 
	// 그 부분을 수정. 
%>

<script type="text/javascript">
	
	var keyValid = true; 
	
	function generateKey(){
		//location.reload();
		keyValid=true; 
		document.getElementById("key_check").disabled=false;
		location.href="emailCheckPro.jsp?email="+"<%= (String)session.getAttribute("email")%>"; 
		
	}
	
	function check(){
		if (document.getElementById("key_input").value == "<%=Key%>" && keyValid ){
			alert("인증 완료 되었습니다.");
			keyValid= false; 
			//alert("<%=Key%>" + "<%=(String)session.getAttribute("key")%>");
			//alert(document.referrer); 

			if(  document.referrer.includes("signUpForm.jsp") ) {
				opener.document.fr.emailCheck.value = "Yes"; 
// 				opener.document.fr.emailCheck22.text ="이메일 인증 완료되었습니다." ;
				$("#emailCheck22" , opener.document).text("이메일 인증 완료되었습니다.");
				$("#emailCheck22" , opener.document).css("color", "blue"); 
			}else if( document.referrer.includes("idSearchPro.jsp") ){ // 아이디 찾기 처리
				//아이디는 중간에 **을 넣어서 알려주기
				alert("아이디는 <%=searchID%> 입니다."); 
				opener.location.href="Login/loginForm.jsp"; 
			}
			 
			
			self.close(); 
		}else{
			alert("인증 암호를 다시 확인하세요.  " +  "<%=Key%>" );
		}
	}

		 
	
	var stDate = new Date().getTime();
	var edDate = new Date().getTime() + 50000; // 종료날짜
	var RemainDate = edDate - stDate;
	 
	
	var time =  30;//60 ; 
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
			<%-- 
			클라이언트에서는 서버 쪽 값들을 변경할 수 없다.
			<% session.removeAttribute("key"); Key= null; %>
			 --%>
			keyValid= false; 
			alert("인증시간이 만료되었습니다. 인증키를 재발급하세요.");
			
			document.getElementById("key_check").disabled=true;
			//location.href="emailCheckPro.jsp?timeout=1"; 
		}
		
		
	} , 1000);
	
	//removeAttribute(String name)
</script>

<p>남은시간 : <span id="time"></span></p>
</body>
</html>