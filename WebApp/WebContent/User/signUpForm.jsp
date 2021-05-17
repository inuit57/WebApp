<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<script type="text/javascript">

	$(document).ready(function () {
		if($("#id").val() == ""){
			$("#idCheck22").text("아이디를 입력하세요.");
			$("#idCheck22").css("color" , "red");
		}
		
		if($("#pwd").val() == "" ){
			$("#pwdCheck22").text("비밀번호를 입력하세요.");
			$("#pwdCheck22").css("color" , "red");
		}
		
		if($("#pwd2").val() == "" ){
			$("#pwd2Check22").text("비밀번호를 입력하세요.");
			$("#pwd2Check22").css("color" , "red");
		}
		
		if($("#name").val() == "" ){
			$("#nameCheck22").text("이름을 입력하세요.");
			$("#nameCheck22").css("color" , "red");
		}

		if($("#email").val() == ""){
			//alert("이메일 인증!!"); 
			$("#emailCheck22").text("이메일 인증을 진행하세요.");
			$("#emailCheck22").css("color" , "red");
		}
		
		// TODO : 다른 항목들도 밑에 뜨게끔 기본적으로 세팅하기
		// Ajax로 다 적용해보고 말이다. 
	})

	//이메일을 다르게 입력할 경우 다시 인증을 진행하도록 하기. 
	//이메일 인증을 진행하고 변경하더라도 다시 하도록. 
	function eamilCheckAgain(){ 
		$("#emailCheck22").text("이메일 인증을 진행하세요.");
		$("#emailCheck22").css("color" , "red");
	}
	
	function pwdCheck(){
		var pwd_v = $("#pwd").val()
		var pwd2_v = $("#pwd2").val()
		
		//일반 비밀번호 검사
		if(pwd_v == "" ){
			$("#pwdCheck22").text("비밀번호를 입력하세요.");
		}else if( pwd_v.length < 6){
			$("#pwdCheck22").text("비밀번호는 6자 이상이어야합니다.");
		}else if(pwd_v.search(document.fr.id.value) >= 0){
			$("#pwdCheck22").text("비밀번호에 아이디가 포함될 수는 없습니다.");
		}else if(/[^a-zA-Z0-9]/g.test(pwd_v)){
			$("#pwdCheck22").text("비밀번호는 숫자와 영문자로만 구성되어야합니다."); 
		}else{
			$("#pwdCheck22").text("");
			$("#pwd2Check22").text(""); 
		}
		
		//비밀번호 확인 검사 
		if(pwd2_v != pwd_v ){
			$("#pwd2Check22").text("입력하신 비밀번호가 다릅니다."); 
			$("#pwd2Check22").css("color" , "red");
		}else{
			$("#pwd2Check22").text("");
		}
	}

	function nameCheck(){
		var name_v = $("#name").val(); 
		
		if( name_v == ""){
			$("#nameCheck22").text("이름을 입력하세요.");
		}else{
			$("#nameCheck22").text("");
		}
	}
	
	
 	function idCheckAjax() {		
		$.ajax({
		
			url : "idCheckPro.jsp",
			data : {id : $("#id").val()} ,
			dataType : "json",
			success: function(data){
							
				console.log(data.flag); 
				if(data.flag == "true"){
					console.log("true!"); 
					 
					$("#idCheck22").text("사용 가능한 아이디입니다.");
					$("#idCheck22").css("color" , "blue"); 
					 
					
				}else{
					$("#idCheck22").text("이미 사용 중이거나 탈퇴한 아이디입니다.");
					$("#idCheck22").css("color" , "red");
					 
				}
				
				if($("#id").val() == ""){
					$("#idCheck22").text("아이디를 입력하세요.");
					$("#idCheck22").css("color" , "red");
					
				}
			},
			
			error : function(data) {
				console.log(data);
				console.log("error") ; 
				
			}
		}); //ajax 끝
	}

</script>

<script type="text/javascript">

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
		
		//if (document.fr.idCheck.value == ""){
		if( $("#idCheck22").text() != "사용 가능한 아이디입니다."){
			alert("사용할 수 없는 아이디입니다.");
			document.fr.id.focus(); 
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
		
		if( $("#emailCheck22").text() != "이메일 인증 완료되었습니다."){
			alert("이메일 인증을 진행하세요!");
			document.fr.email.focus(); 
			return false; 
		}
		
// 		if (document.fr.emailCheck.value == ""){
// 			alert("이메일 인증을 진행하세요!");
// 			document.fr.email.focus(); 
// 			return false; 
// 		}
		 
	}
	
	function checkID(){
		if ( document.fr.id.value == "" ){
			alert("아이디를 입력하세요!") ; 
			return;
		}
		window.open( "idCheckPro.jsp?id=" + document.fr.id.value , "idChkPopup","width=500,height=600" );
		document.fr.idChkBtn.disabled=true;
		document.fr.idChangeBtn.disabled=false;
		
	}
	
	function checkEmail(){
		
		var email_v = document.fr.email.value ; 
		if ( email_v == "" ){
			alert("이메일을 입력하세요!") ; 
			return;
		}else if( email_v.search("@") < 0){
			alert("잘못된 이메일 주소입니다!") ;
			return ;
		}
		
		window.open( "emailCheckPro.jsp?email="+document.fr.email.value  , "이메일 인증","width=500,height=600")
		 
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
    
    function changeID() {
    	document.fr.idCheck.value = "";
    	document.fr.id.readOnly=false;	
    	document.fr.idChkBtn.disabled=false; 
    	document.fr.idChangeBtn.disabled=true;
	}
    
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>
</head>
<body>
	<!-- 회원가입 페이지 입니다. -->


<!--  header 시작 -->
 <jsp:include page="/layout/header.jsp"></jsp:include>
<!--  header 끝 -->

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<fieldset  style="width: 600px;"> 
		<legend> 회원 가입 </legend>
		<!-- TODO : 테스트 완료되면 get에서  post로 바꾸기 -->
		<form  class="form-inline" action="signUpPro.jsp" method="get" name="fr" onsubmit="return checkUser()">
			<div class="form-group">
			<table border="1"  id="tb" class="table table-hover table-bordered "> 
				<tr>
					<td>아이디 :</td>
					<td><input class="form-control" type="text" name="id" id="id" maxlength="8" autocomplete="off" 
					placeholder="영문,숫자(8자)"  onkeyup="idCheckAjax()" onchange="idCheckAjax()"><br> 
					<div id="idCheck22" ></div>
					</td>					
				</tr>
				<tr>
					<td>비밀번호 :</td>
					<td>
					<input class="form-control"  type="password" name="pwd" id="pwd" maxlength="14" 
					placeholder="6~14자 이하의 영어,숫자" onkeyup="pwdCheck()" onchange="pwdCheck()" >
					<br><div id="pwdCheck22" ></div>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인 :</td>
					<td>
					<input class="form-control"  type="password" name="pwd2" id="pwd2" maxlength="14" 
					placeholder="6~14자 이하의 영어,숫자" onkeyup="pwdCheck()" onchange="pwdCheck()" >
					<br><div id="pwd2Check22" ></div>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
					<input class="form-control"  type="text" name="name" id="name" maxlength="10" autocomplete="off"
					onkeyup="nameCheck()" onchange="nameCheck()" >
					<br><div id="nameCheck22" ></div>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input class="form-control"  type="radio" name="gender" value="M" checked="checked">남
						<input class="form-control"  type="radio" name="gender" value="F">여
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input class="form-control"  type="number" min="0" max="100" name="age" ></td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input class="form-control"  type="text" id="post_num" name="post_num" placeholder="우편번호" autocomplete=”off”>
						<input class="form-control"  type="button" value="검색" onclick="searchPostCode()"> <br> 
						<input class="form-control"  type="text" id="addr" name="addr" placeholder="도로명주소" autocomplete="off">
						<input class="form-control"  type="text" id="addr2" name="addr2" placeholder="상세주소" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<!-- TODO : 이메일을 한번 DB에서 조회해보고 만약 있다면 아이디/비밀번호 찾기로? -->
					<td><input class="form-control"  type="email" name="email" id="email" maxlength="30" autocomplete="off"
					onkeyup="eamilCheckAgain()" onchange="eamilCheckAgain()" > 
					
					<input class="form-control"  type="button" value="이메일 인증" onclick="checkEmail()">
					<div id="emailCheck22" style="color:red"></div>
					<input type="hidden" name="emailCheck" disabled="disabled">
					</td>
					
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input class="form-control"  type="submit" value="확인" >
						<input class="form-control"  type="button" value="취소" onclick="location.href='Login/main.jsp'">
					</td>
				</tr>
			</table>
			</div>
		</form>
	</fieldset>
</div>


</body>
</html>