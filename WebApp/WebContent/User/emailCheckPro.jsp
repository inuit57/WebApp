
<%@page import="com.itwillbs.user.UserDAO"%>
<%@page import="mailTest.KeyGenerator"%>
<%@page import="mailTest.SMTPAuthenticator"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
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
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id"); 
	String email = request.getParameter("email"); 
	if ( email != null){	
		session.setAttribute("email", email);
	}
	
	String pwReset = request.getParameter("pwReset"); 
	
	KeyGenerator key = null ; 
	String from = "inuit57@naver.com";  //보내는 이
	String to = email; // 받는 이 
	String subject = null ;  
	String content = null ;  //이거를 임시비밀번호로? 
	if(pwReset != null){ 
		key = new KeyGenerator(8) ;
		subject = "비밀번호 재설정";
		content = "임시비밀번호 : " + key.getKey();
		
		UserDAO udao = new UserDAO(); 
		udao.updateUser(id, email, key.getKey()); 
		// 이 시점에서 DB에 업데이트 작업을 진행해주도록 하자. 
		//비밀번호 초기화 해주는 경우에는 session에 저장하진 않는다. 
		
	} //비밀번호 초기화의 경우 8자리로 생성
	else {
		key = new KeyGenerator(6);   
		
		subject = "이메일 인증 요청";
		content = "인증번호 : " + key.getKey();
		session.setAttribute("key", key.getKey()); //세션에 생성한 키 값을 저장한다.
		//메일을 보내는 동작도 여기에서 수행한다. 키 재발급 + 메일 발송 
	}

	
	Properties p = new Properties(); // 정보를 담을 객체
	 
	p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
	 
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	// SMTP 서버에 접속하기 위한 정보들
	 
	try{
	    Authenticator auth = new SMTPAuthenticator();
	    Session ses = Session.getInstance(p, auth);
	     
	    ses.setDebug(true);
	    
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
	    msg.setSubject(subject); // 제목
	     
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); // 보내는 사람
	     
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	     
	    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
	     
	    Transport.send(msg); // 전송
	} catch(Exception e){
	    e.printStackTrace();
	    //out.println("<script>alert('Send Mail Failed..');history.back();</script>");
	    return;
	}
	 
	//out.println("<script>alert('Send Mail Success!!');location.href='mailForm.jsp';</script>");
	// 성공 시
	
	
	
	// 여기에서 키를 생성해서 돌려주도록 한다.
	if(pwReset != null){  
		//비밀번호 초기화 동작을 수행한다.
		//다시 로그인 페이지로 넘겨주자.
		response.sendRedirect("Login/loginForm.jsp"); 
		 
	}else{
		response.sendRedirect("emailCheckForm.jsp");  
	}
%>
</body>
</html>