<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">

	function checkUser(){
		
		// 1) 비밀번호 일치 여부 확인
		// 2) 입력하지 않은 값이 있는지 확인 
		
		// 3) 
		
		var pw = document.fr.pw.value ; 
		
		//아이디
		if(document.fr.id.value == ""){
			alert("아이디를 입력하세요!"); 
			document.fr.id.focus() ; 
			return false; 
		}
		//비밀번호
		if ( pw == ""){
			alert("비밀번호를 입력하세요!"); 
			document.fr.pw.focus();
			return false; 
		}else if(pw.length < 6 ){
			alert("비밀번호는 6자 이상 작성해주세요!");
			document.fr.pw.value="";
			document.fr.pw.focus();
			return false;
		}else if ( pw != document.fr.pw2.value){
			alert("입력하신 비밀번호가 다릅니다."); 
			document.fr.pw.value="";
			document.fr.pw2.value ="" ;
			document.fr.pw.focus(); 
			
			return false; 
		}else{
			if (pw.search(document.fr.id.value)>=0){
				alert("비밀번호에 아이디가 포함될 수는 없습니다.");
				pw = ""; 
				document.fr.pw.focus(); 
				return false; 
			}
			var pwd_check = '/^[a-z|A-Z|0-9]';
			//if (pwd_check.test(pw)){
			if(!/^[a-zA-Z0-9]$/.test(pw)){
				alert("비밀번호는 숫자와 영문자로만 구성되어야합니다."); 
				document.fr.pw.value=""; 
				document.fr.pw2.value="";  
				document.fr.pw.focus(); 
				
				return false; 
			}else{
				//alert(pw.value); 
			}
		}
		//이름
		if(document.fr.name.value == ""){
			alert("이름을 입력하세요!"); 
			document.fr.name.focus(); 
			return false; 
		}
		// 성별 - 기본적으로 남자를 고르게 해두었으니 따로 검사는 X
		// 나이
		if( document.fr.age.value == ""){
			alert("나이를 입력하세요!"); 
			document.fr.age.focus(); 
			return false; 
		}
		//주소
		if (document.fr.addr.value == ""){
			alert("주소를 입력하세요!") ; 
			document.fr.addr.focus(); 
			return false; 
		}
		// 이메일 
		if ( document.fr.email.value == ""){
			alert("이메일을 입력하세요!") ; 
			document.fr.email.focus(); 
			return false ; 
		}
		
	}
	
	function checkID(){
		
		// TODO - idCheckPro.jsp 에서 DB 조회해서 중복된 아이디인지 확인하는 로직 필요. 
		location.href = "idCheckPro.jsp?id=" + document.fr.id.value ; 
		
	}

</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>
</head>
<body>
	<!-- 회원가입 페이지 입니다. -->

	<!-- TODO : 크기 조정 필요 -->
	<fieldset style="width: 400px; height: 300px;">
		<legend> 회원 가입 </legend>
		<!--  TODO 유효성검사 (onsubmit)  -->
		<form action="signUpPro.jsp" method="post" name="fr" onsubmit="return checkUser()">
			<table border="2">
				<tr>
					<td>아이디 :</td>
					<td><input style="width: 100px" type="text" name="id" maxlength="8" placeholder="영문,숫자(8자)">

						<!--  TODO 중복확인 로직 넣기  -->
						<!--  DB에 가서 select를 해봐야 한다.  --> 
						<input type="button" value="중복확인"
								onclick="checkID()"></td>
				</tr>
				<tr>
					<td>비밀번호 :</td>
					<td><input style="width: 180px" type="password" name="pw" maxlength="14" placeholder="6~14자 이하의 영어,숫자 조합" ></td>
					
				</tr>
				<tr>
					<td>비밀번호 확인 :</td>
					<td><input style="width: 180px" type="password" name="pw2" maxlength="14" placeholder="6~14자 이하의 영어,숫자 조합" ></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input style="width: 180px" type="text" name="name" maxlength="10"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="gender" value="male" checked="checked">남
						<input type="radio" name="gender" value="female">여
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" min="0" max="100" name="age" ></td>
				</tr>
				<tr>
					<td>주소</td>
					<!--  TODO 주소 API 사용해보기  -->
					<td><input type="text" name="addr" maxlength="100"></td> 
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" maxlength="30"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="확인" >
						<input type="button" value="취소">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>


</body>
</html>