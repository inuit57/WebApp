<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">

	function checkUser(){
		
		// 1) 비밀번호 일치 여부 확인 
		
		// 2) 입력하지 않은 값이 있는지 확인 
		
		// 3) 
		
		
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
					<td><input style="width: 180px" type="text" name="pw" maxlength="14" placeholder="14자 이하의 영어,숫자 조합" ></td>
					
				</tr>
				<tr>
					<td>비밀번호 확인 :</td>
					<td><input style="width: 180px" type="text" name="pw2"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input style="width: 180px" type="text" name="name"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="gender" value="male">남
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
					<td><input type="text" name="addr"></td> 
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email"> </td>
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