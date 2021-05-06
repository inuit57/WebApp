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
<form action="idSearchPro.jsp" name="idForm" onsubmit="return idSearch()">
	이름 입력 :  <input type="text" name="name" placeholder="이름 입력"><br>
	이메일 입력 : <input type="email" name="email" id="email" placeholder="이메일을 입력하세요." ><br> 
	<input type="hidden" name="emailCheck" >
	<input type="submit" value="아이디 찾기" >
</form>

<h1># pw 찾기<h1>
<form action="keyResetPro.jsp" name="pwForm" onsubmit="return pwCheck()">
	아이디 입력 : <input type="text" name="id" placeholder="아이디 입력"><br>
	이름 입력 :  <input type="text" name="name" placeholder="이름 입력"><br>
	이메일 입력 : <input type="email" name="email" placeholder="이메일을 입력하세요." ><br>
	<input type="submit" value="비밀번호 재발급" > 
</form>

<script type="text/javascript">

	function idSearch(){
		// 입력한 정보와 일치하는 것이 DB에 있는지 확인하기 
		if(document.idForm.name.value == ""){
			alert("이름를 입력하세요!"); 
			document.pwForm.name.focus; 
			return false; 
		}
		
		if(document.idForm.email.value == ""){
			alert("이메일을 입력하세요!"); 
			document.pwForm.email.focus; 
			return false; 
		}	
		//window.open( "emailCheckPro.jsp?email="+document.getElementById("email").value  , "이메일 인증","width=500,height=600");
	
	}
	
	function pwSearch(){
		//window.open( "emailCheckPro.jsp?email="+document.getElementById("email").value  , "이메일 인증","width=500,height=600");
		
		if(document.pwForm.id.value == ""){
			alert("아이디를 입력하세요!"); 
			document.pwForm.id.focus; 
			return false; 
		}
		
		if(document.pwForm.name.value == ""){
			alert("이름를 입력하세요!"); 
			document.pwForm.name.focus; 
			return false; 
		}
		
		if(document.pwForm.email.value == ""){
			alert("이메일을 입력하세요!"); 
			document.pwForm.email.focus; 
			return false; 
		}
	}
</script>

</body>
</html>