<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 수정</title>

<script type="text/javascript">

	function deleteChk() {
		if( confirm("정말 회원 탈퇴하시겠습니까?") ){
			location.href = "deleteUser.jsp"; 
		}
	}
</script>
</head>
<body>

	<fieldset style="width: 400px; height: 300px;">
		<legend> 회원 정보 수정 </legend>
		<!-- TODO : 테스트 완료되면 get에서  post로 바꾸기 -->
		<form action="signUpPro.jsp" method="get" name="fr" onsubmit="return checkUser()">
			<table border="2">
				<tr>
					<td>아이디 :</td>
					<td>
					<input style="width: 100px" type="text" name="id" maxlength="8" disabled="disabled">
					</td>					
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
						<input type="radio" name="gender" value="M" >남
						<input type="radio" name="gender" value="F">여
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" min="0" max="100" name="age" ></td>
				</tr>
				<tr>
					<td>주소</td>
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
						<input type="button" value="회원탈퇴" onclick="deleteChk()">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>


</body>
</html>