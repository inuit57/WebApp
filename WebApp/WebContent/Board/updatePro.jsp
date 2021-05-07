<%@page import="java.io.File"%>
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
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%-- 
	<jsp:useBean id="bb" class="com.itwillbs.board.BoardBean"></jsp:useBean>
	<jsp:setProperty property="*" name="bb" />
	 --%>
	<%
		BoardDAO bDao = new BoardDAO();
		BoardBean bb = new BoardBean(); 
		
		//파일 업로드 처리 
		String path = request.getRealPath("/upload");
		System.out.println("파일 저장되는 실제 경로 : " + path);
				
		// 2) 파일의 크기를 지정 -> 최대 10Mb로 제한.
		//int maxSize2 = 10 * 1024 * 1024 ; // 10 MB
		int maxSize = 10 * (1 << 20);

		// 파일 업로드 => Multipart 객체를 생성
		MultipartRequest multi = new MultipartRequest(request, // => jsp 내장객체(파라미터)
				path, // => 실제 파일이 저장될 위치
				maxSize, // => 파일의 최대 크기
				"UTF-8", // => 파일 업로드시 인코딩
				new DefaultFileRenamePolicy() // => 파일이름이 중복될 경우의 처리
		);

		int bid = Integer.parseInt(multi.getParameter("bid")) ;

		
		bb.setBid(bid); 
		bb.setBsubject(multi.getParameter("bsubject"));
		bb.setBcontent(multi.getParameter("bcontent"));
		bb.setBtype(multi.getParameter("btype"));
		
		String file_name = bDao.getBoard(bid).getFile_name(); //기존에 저장된 파일이름 
		if(file_name == null)  file_name = ""; 
		String file_now = multi.getParameter("file_now"); 
		bb.setFile_name(file_now); 
		
		//String file_now = multi.getFilesystemName("file_name") ; //새로 넣어줄 파일 이름 또는 기존의 파일명. 
		// 문제는 이렇게 접근하게 되면은 업데이트하면 무조건 기존 파일이 지워져버리게 된다. 
		
		// 이름이 다르게 붙여지게 되었을 경우, 이름이 다르다는 판정이 일어나서 삭제된다?
		if(file_now == null) file_now =""; //
		
		System.out.println(path + "\\" +file_name);
		if(!file_now.equals(file_name)){
			File fp = new File(path + "\\" +file_name); 
		
			if(fp.exists()){
				fp.delete(); 
				System.out.println(file_name + " 삭제 완료"); 
				
				bb.setFile_name(multi.getFilesystemName("file_name")); // 새로 넣어줄 파일 이름
				//삭제했을 때 이름을 넣어줘야한다. 
			} //기존에 들어가있는 것과 파일 이름이 다르면 지워주기 처리.
		}
		
		boolean flag = bDao.updateBoard(bb);

	%>
	
	<script type="text/javascript">
		if (
	<%=flag%>
		) {
			alert("업데이트 완료!");
		}
		var curr =
	<%=(String) session.getAttribute("curr")%>
		;
		var listCnt =
	<%=(String) session.getAttribute("listCnt")%>
		if (curr == null)
			curr = 1;
		if (listCnt == null)
			listCnt = 3;

		location.href = "boardList.jsp?currentIndex=" + curr + "&listCnt="
				+ listCnt;
	</script>
</body>
</html>