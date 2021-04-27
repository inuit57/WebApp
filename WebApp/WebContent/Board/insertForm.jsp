<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<script type="text/javascript">
	function moveList(){
			
			var curr = <%=(String)session.getAttribute("curr")%>; 
			var listCnt = <%=(String)session.getAttribute("listCnt")%>
			
			if (curr == null) curr = 1 ;
			if (listCnt == null) listCnt = 3; 
			
			location.href="boardList.jsp?currentIndex="+curr+"&listCnt="+listCnt; 
		}
</script>
</head>
<body>


<fieldset> 
	<legend>게시글 작성</legend>
	<form action="insertPro.jsp">
		<table border="2">
			<tr> 
				<td>
					<select name="btype">
						<option value="1">공지</option>
						<option value="2" selected="selected">일반</option>
						<option value="3">자료</option>
					</select>
				</td>
				<td colspan="2">
					<input type="text" name="bsubject" placeholder="제목">  
				</td>
			</tr>
			<tr> 
				<td colspan="3">
					<textarea rows="20" cols="30" name="bcontent" placeholder="내용"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
					<input type="submit" value="작성">
					<!-- TODO : 취소 js 함수 만들어서 처리, 글 목록으로 이동 -->
					<input type="button" value="취소" onclick="moveList()">
				</td> 
			</tr>
		</table>
	</form>
</fieldset>
</body>
</html>