<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body>
<% 
	String loginType = (String)session.getAttribute("loginType"); 
	if(loginType == null) loginType="normal"; 
	
	session.invalidate(); //세션에 저장된 정보를 모두 삭제
	
/* 	Cookie[] cookies = request.getCookies(); 
	for(Cookie c : cookies){
		c.setMaxAge(0); // 모든 쿠키도 삭제
		response.addCookie(c);
	} */
	
%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('37f8964af0801ae7c162647308ed7997'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단

function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined); 
    }
  } 

</script>


<script type="text/javascript">
	alert("정상적으로 로그아웃 되었습니다");
	
	<%if(loginType.equals("kakao")){%>
		kakaoLogout();
		console.log("카카오 로그아웃 완료"); 
	<%}else if(loginType.equals("normal")){%>
		location.href="main.jsp";
	<%}%>
	
	location.href="main.jsp";
</script>

</body>
</html>