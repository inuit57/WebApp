<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 찾기</title>
</head>
<body>
<!--  header 시작 -->
 <jsp:include page="/layout/header.jsp"></jsp:include> 
<!--  header 끝 -->
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">


<h1># id 찾기</h1><br>
<form  class="form-inline" action="#" name="idForm" onsubmit="return idSearch()">
<div class="form-group">
	<table border="1"  id="tb" class="table table-bordered ">
	<tr>
	<td>이름 입력</td>
	<td><input class="form-control" type="text" name="name" id="name" placeholder="이름 입력"></td></tr>
	<tr>
	<td>이메일 입력</td>
	<td><input class="form-control" type="email" name="email" id="email" placeholder="이메일을 입력하세요." > 
	<input type="hidden" name="emailCheck" >
	</td></tr>
	<tr>
	<td colspan="2" align="right">
<!-- 	<input class="form-control" type="submit" value="아이디 찾기" > -->
	<input class="form-control" type="button" value="아이디 찾기" onclick="idSearch()">
	</td></tr>
	</table>
</div>
</form>

<hr>
<h1># 비밀번호 재발급</h1>
<form  class="form-inline" action="keyResetPro.jsp" name="pwForm" onsubmit="return pwCheck()">
<div class="form-group">
	<table border="1"  id="tb" class="table table-bordered ">
	<tr>
	<td>아이디</td>
	<td> <input class="form-control" type="text" name="id" placeholder="아이디 입력"></td>
	</tr>
	<tr>
	<td>이름</td>
	<td><input class="form-control" type="text" name="name" placeholder="이름 입력"></td>
	</tr>
	<tr>
	<td>이메일</td>
	<td><input class="form-control" type="email" name="email" placeholder="이메일을 입력하세요." ></td>
	</tr>
	<tr>
	<td colspan="2" align="right"><input class="form-control" type="submit" value="비밀번호 재발급" ></td>
	</tr>
	</table>
</div> 
</form>

</div>
<script type="text/javascript">

	function idSearch(){
		// 입력한 정보와 일치하는 것이 DB에 있는지 확인하기 
		// ajax로 동작시키기? 
		
		var searchID =""; 
				
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
		
		$.ajax({
			url : "idSearchPro.jsp",
			data : {name : $("#name").val() , email:$("#email").val() } ,
			dataType : "json",
			success: function(data){
				console.log(data.id); 
				
				if(data.id == ""){
					console.log(searchID); 
					alert("입력하신 정보와 일치하는 회원이 없습니다.");
				}else{
					window.open( "emailCheckPro.jsp?email="+$('#email').val() , "이메일 인증","width=500,height=600");
				}
			},
			error : function(data) {
				console.log(data);
				console.log("error") ; 
				
			}
		}); //ajax 끝
		
		
	}
	
	function pwSearch(){
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