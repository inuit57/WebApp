<%@page import="javax.swing.text.Document"%>
<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%-- 
<jsp:useBean id="bb" class="com.itwillbs.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bb"/> 

파일업로드를 같이 넣으면서 거기에서 다 먹어버려서 useBean을 못 쓴다.
--%>

<%
	String listCnt = (String) session.getAttribute("listCnt");
	String curr = (String) session.getAttribute("curr");

	if (listCnt == null) {
		listCnt = "3";
	}
	if (curr == null) {
		curr = "1";
	}

	String id = (String) session.getAttribute("id");
	if (id == null) {
		System.out.println("잘못된 접근입니다.");
		//	response.sendRedirect("../User/Login/main.jsp"); //메인 페이지로 사출. 
	} else {

		BoardDAO bdao = new BoardDAO();
		BoardBean bb = new BoardBean(); 
		bb.setUid(id);
	
		
		//파일 업로드 처리 
		String path = request.getRealPath("/upload");
		System.out.println("파일 저장되는 실제 경로 : " + path); 
		
		// 2) 파일의 크기를 지정 -> 최대 10Mb로 제한.
		//int maxSize2 = 10 * 1024 * 1024 ; // 10 MB
		int maxSize = 10 * ( 1 << 20) ; 
		
		// 파일 업로드 => Multipart 객체를 생성
		MultipartRequest multi = new MultipartRequest(
								request, // => jsp 내장객체(파라미터)
								path, // => 실제 파일이 저장될 위치
								maxSize, // => 파일의 최대 크기
								"UTF-8", // => 파일 업로드시 인코딩
								new DefaultFileRenamePolicy() // => 파일이름이 중복될 경우의 처리
								); 
		
		bb.setBsubject(multi.getParameter("bsubject")); 
		bb.setBcontent(multi.getParameter("bcontent")); 
		bb.setBtype(multi.getParameter("btype"));
		bb.setFile_name(multi.getFilesystemName("file_name")); 
		
		boolean flag = bdao.insertBoard(bb);
		
		String view = multi.getParameter("view"); 
		if(view == null){
			view = "1"; 
		}
		
		
		if(flag){
			if( view.equals("1")){
				response.sendRedirect("boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt);
			}else{
				response.sendRedirect("ImageBoard.jsp?listCnt="+listCnt);
			}
		}
		
	}
%>


</body>
</html>