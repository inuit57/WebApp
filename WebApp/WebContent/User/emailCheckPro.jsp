
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
	String email = request.getParameter("email"); 
	if ( email != null){	
		session.setAttribute("email", email);
	}
	
	KeyGenerator key = new KeyGenerator() ; 

	session.setAttribute("key", key.getKey());  
	//클라 쪽에서 시간을 재서 시간이 지났을 때 이거를 날려버리는 것이 좋지 싶네. 

	
	//메일을 보내는 동작도 여기에서 수행한다. 키 재발급 + 메일 발송 
	
	 
	String from = "inuit57@naver.com";  //보내는 이
	String to = email; // 받는 이 
	String subject = "이메일 인증 요청"; 
	String content = "인증번호 : " + key.getKey(); 
	// 입력값 받음
	 
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
	response.sendRedirect("emailCheckForm.jsp");  
%>
</body>
</html>