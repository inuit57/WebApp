<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>로그인</title>
</head>
<body>

<!--  카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!--  카카오 로그인 -->

<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<script>


<!--  카카오 로그인 -->
Kakao.init('37f8964af0801ae7c162647308ed7997'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단


var email  
var name 

function kakaoLogin() {
    Kakao.Auth.loginForm({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          data: {
              property_keys: ["properties.nickname", "kakao_account.email"]
          }, // 여기에 넣은 것만 가져올 수도 있구나. 아하. 
          success: function (response) {
        	  console.log(response);
        	  
        	  console.log(response.properties.nickname);
        	  console.log(response.kakao_account.email);
        	  //이거를 이제 저장해서 처리하면 되겠다. 
        	   
        	  name = response.properties.nickname ;
        	  email = response.kakao_account.email ;
        	  
        	  $("#name").val(name);
        	  $("#email").val(email);
        	  $("#loginType").val("kakao");
        	  
        	  $("#loginForm").submit();
        	  //location.href="loginPro.jsp?name="+name+"&email="+email+"&loginType=kakao"; 
   
          },
          fail: function (error) {
            console.log(error);
          },
        })
      },
      fail: function (error) {
        console.log(error);
      },
    })
  }


</script>

<!--  header 시작 -->
 <jsp:include page="/layout/header.jsp"></jsp:include> 
<!--  header 끝 -->
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<fieldset>
		<legend>로그인</legend>
		<!--  테스트 끝나고 get에서 post로 바꿀 것. -->

		<form class="form-inline" action="loginPro.jsp" id="loginForm" method="post">
		<div class="form-group">
		<table border="1"  id="tb" class="table table-bordered ">
			<tr>
			<td>아이디</td>
			<td> <input class="form-control" type="text" name="id" autocomplete="off" ></td>
			</tr>
			<tr>
			<td>비밀번호</td> 
			<td> <input class="form-control" type="password" name="pwd"></td> 
			
			<input  type="hidden" id="name" name="name">  
			<input  type="hidden" id="email" name="email">
			<input  type="hidden" id="loginType" name="loginType" value="normal">
			</tr>    
			<tr>
			<td colspan="2">
				<input class="form-control"  type="submit" value="로그인">
			 
			<!--  TODO 다른 방식으로 로그인? 카카오톡/네이버 아이디로? -->
				<img src="<%=request.getContextPath() %>/img/kakao_login_medium.png"  onclick="kakaoLogin()">
				<!-- <input class="form-control"  type="button" value="카카오 로그인" onclick="kakaoLogin()"> --> 
			</td>
			</tr>
			<tr>
			<td>
			<input class="form-control"  type="button" value="회원가입" onclick="location.href='../signUpForm.jsp'">
			</td>
			<td>
			<input class="form-control"  type="button" value="아이디/비밀번호 찾기"
				onclick="location.href='../idPwSearch.jsp'">
			</td>
			</tr>
			</table>
			</div>
		</form>
	</fieldset>
</div>
</body>
</html>