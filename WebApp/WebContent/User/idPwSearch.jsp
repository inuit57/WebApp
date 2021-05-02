<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 찾기</title>
</head>
<body>

<h1># id 찾기</h1><br>
이메일 입력 : <input type="email" name="email" id="email" placeholder="이메일을 입력하세요." ><br> 
<input type="hidden" name="emailCheck" >
<input type="button" value="아이디 찾기" onclick="idSearch()">

<h1># pw 찾기<h1><br>
<form action="pwSearch.jsp" >
아이디 입력 : <input type="text" name="id" placeholder="아이디 입력"><br>
이메일 입력 : <input type="email" name="email" placeholder="이메일을 입력하세요." ><br>
<input type="button" value="아이디 찾기" onclick="pwSearch()"> 
</form>

<script type="text/javascript">

	function idSearch(){
		window.open( "emailCheckPro.jsp?email="+document.getElementById("email").value  , "이메일 인증","width=500,height=600");
	
	}
	
	function pwSearch(){
		window.open( "emailCheckPro.jsp?email="+document.getElementById("email").value  , "이메일 인증","width=500,height=600");
	}
</script>

</body>
</html>