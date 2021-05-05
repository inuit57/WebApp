<%@page import="java.net.URLEncoder"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.concurrent.BrokenBarrierException"%>
<%@page import="java.io.FileInputStream"%>
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
	String fileName = request.getParameter("file_name"); 

	// 업로드한 가상 경로
	String savePath = "upload"; 
	// 파일이 업로드된 경로
	ServletContext ctx = getServletContext(); // 내 프로젝트 정보를 가지고 온다. 
	String sDownloadPath = ctx.getRealPath(savePath); 
	
	System.out.println("upload 폴더의 실제주소 (서버 안에 있는) : "+ sDownloadPath); 
	
	// 서버에 업로드된 파일명 생성
	String sFilePath = sDownloadPath + "\\" + fileName; 
	
	System.out.println("파일명 : " + sFilePath); 
	/////////////////////////////////////////////////////////////////////
	
	// * 자바/웹 에서 파일을 업로드/다운로드할 때 파일의 확장자는 중요하지 않음. 
	// => 스트림으로 데이터를 주고 받기 때문이다. => 해당 파일 웹에서 표현하는 MIME 타입
	
	// 파일 업로드 
	
	// 파일을 한 번에 읽고 쓰기 하는 배열 ( = buffer ) 
	byte[] bArr = new byte[4096] ; 
	
	//파일 주소를 주거나 혹은 File 객체를 주거나.
	//파일 입력스트림 객체 
	// 파일을 읽고 쓰는 것 : file-input , 파일을 닫고 저장되는 것 : file-output 
	// 여기에서는 서버에 저장된 것을 불러오는 것, input 
	FileInputStream fis = new FileInputStream(sFilePath);

	//다운로드할 파일의 MIME 타입을 가져오기 
	// * MIME 타입 : 클라이언트에게 전송된 문서의 다양성을 표현하기 위한 메커니즘
	String sMimeType = getServletContext().getMimeType(sFilePath); 
	
	System.out.println("sMimeType = " + sMimeType);
	
	//MIME 타입이 없을 경우 기본값으로 지정
	if(sMimeType == null){
		sMimeType = "application/octet-stream"; 
	}
	
	//응답할 페이지에 MIME 타입을 지정 (jsp MIME 타입 -> 다운로드파일 MIME타입으로 변경)
	response.setContentType(sMimeType); 
	
	//사용자의 브라우저를 확인 (IE 여부) 
	// IE 는 다운로드시 한글파일의 이름이 깨진다. 공백문자로 +로 바뀌기도 한다.
	// 변경처리 
	
	// 헤더에서 사용자 정보를 가져오기 
	String agent = request.getHeader("User-Agent"); 
	System.out.println("사용자 정보 : " + agent);
	
	//사용자 정보 안에 "MISE" , "Trident" 있을 경우 
	boolean ieBrowser = (agent.indexOf("MSIE")> -1 || agent.indexOf("Trident")>-1); 
	
	
	if(ieBrowser){
		fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		// UTF-8 로 변경(한글이 안 깨지도록)
		// +기호를 띄어쓰기(%20)로 변경
	}else{
		// 모든 브라우저들 한글 깨짐 방지 (인코딩 방식 UTF-8로 변경)
		fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1"); 
	}
	/////////////////////////////////////////////////////////////////////
	
	// 모든 파일이 다운로드 형태로 처리되도록 설정
	// => 브라우저에서 해석되는 파일도 다운로드처럼 처리하기 위한 설정
	response.setHeader("Content-Disposition", "attachment; filename= "+fileName);
	
	// 다운로드
	// 브라우저를 사용해서 밖으로 출력할 수 있는 통로를 생성 
	ServletOutputStream out2 = response.getOutputStream(); 
	
	int numRead; 
	
	// -1 은 파일의 끝 (EOF, End Of File)
	while((numRead = fis.read(bArr, 0 , bArr.length)) != -1){
		out2.write(bArr,0,numRead); 	
	}
	
	out2.flush(); //버퍼의 빈공백을 채워서 데이터를 전달하는 방법 (버퍼 비우기) 
	out2.close(); 
	
	fis.close(); 
%>

</body>
</html>
