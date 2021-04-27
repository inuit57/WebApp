<%@page import="com.itwillbs.user.UserBean"%>
<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 수정</title>

<%

	String id = (String)session.getAttribute("id");
	UserBean ub = null ; 
	if(id == null){
		//로그인 페이지로 사출!
		response.sendRedirect("Login/loginForm.jsp"); 
	}else{
		// DB에서 정보 얻어오기 
		UserDAO ud = new UserDAO(); 
		
		ub = ud.getUserBean(id); 
	}
	
%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	function deleteChk() {
		if( confirm("정말 회원 탈퇴하시겠습니까?") ){
			location.href = "deleteUser.jsp"; 
		}
	}
	
	function deletepwd(){
		document.fr.pwd.value="";
		document.fr.pwd2.value="";
		document.fr.pwd.focus();
	}
	function checkUser(){
		
		// 1) 비밀번호 일치 여부 확인
		// 2) 입력하지 않은 값이 있는지 확인 
		
		var pwd = document.fr.pwd.value ; 
		
		//아이디
		if(document.fr.id.value == ""){
			alert("아이디를 입력하세요!"); 
			document.fr.id.focus() ; 
			return false; 
		}
		
		//비밀번호
		if ( pwd == ""){
			alert("비밀번호를 입력하세요!"); 
			deletepwd();
			return false; 
		}else if(pwd.length < 6 ){
			alert("비밀번호는 6자 이상 작성해주세요!");
			deletepwd();
			return false;
		}else if ( pwd != document.fr.pwd2.value){
			alert("입력하신 비밀번호가 다릅니다."); 
			deletepwd(); 
			
			return false; 
		}else{
			if (pwd.search(document.fr.id.value)>=0){
				alert("비밀번호에 아이디가 포함될 수는 없습니다.");
				deletepwd(); 
				return false; 
			}
			
			if(/[^a-zA-Z0-9]/g.test(pwd)){
				alert("비밀번호는 숫자와 영문자로만 구성되어야합니다."); 
				deletepwd();
				return false; 
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
	
	 function searchPostCode() {
	        new daum.Postcode({
	            oncomplete: function(data) {

	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	              

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('post_num').value = data.zonecode;
	                document.getElementById("addr").value = roadAddr;            
	              
	            }
	        }).open();
	    }
</script>
</head>
<body>

<% if(ub != null){ %>
	<fieldset  style="width: 600px;"> 
		<legend> 회원 정보 수정 </legend>
		<!-- TODO : 테스트 완료되면 get에서  post로 바꾸기 -->
		<form action="userUpdatePro.jsp" method="get" name="fr" onsubmit="return checkUser()"> 
			<table border="2">
				<tr>
					<td>아이디 :</td>
					<td>
					<input style="width: 100px" type="text" name="id" maxlength="8" readonly="readonly" value=<%=ub.getId() %>>
					</td>					
				</tr>
				<tr>
					<td>비밀번호 :</td>
					<td>
					<input style="width: 180px" type="password" name="pwd" maxlength="14" 
					placeholder="6~14자 이하의 영어,숫자 조합"  value=<%=ub.getPwd() %>></td>
					
				</tr>
				<tr>
					<td>비밀번호 확인 :</td>
					<td><input style="width: 180px" type="password" name="pwd2" maxlength="14" placeholder="6~14자 이하의 영어,숫자 조합" ></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input style="width: 180px" type="text" name="name" maxlength="10" value=<%=ub.getName() %>></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="gender" value="M" <% if(ub.getGender().equals("M")){ %>checked="checked" <%} %>>남
						<input type="radio" name="gender" value="F" <% if(ub.getGender().equals("F")){ %>checked="checked" <%} %> >여
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" min="0" max="100" name="age" value=<%=ub.getAge() %>></td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text" id="post_num" name="post_num" placeholder="우편번호" value='<%=ub.getPost_num() %>'>
						<input type="button" value="검색" onclick="searchPostCode()"> <br> 
						<input type="text" id="addr" name="addr" placeholder="도로명주소" value='<%=ub.getAddr() %>'>
						<input type="text" id="addr2" name="addr2" placeholder="상세주소" value='<%=ub.getAddr2() %>'>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" maxlength="30" value=<%=ub.getEmail() %>> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="확인" >
						<input type="button" value="취소" onclick="location.href='Login/main.jsp'">
						<input type="button" value="회원탈퇴" onclick="deleteChk()">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
<%} %>

</body>
</html>