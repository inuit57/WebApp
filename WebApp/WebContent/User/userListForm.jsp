<%@page import="com.itwillbs.user.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유저 관리창</title>
</head>
<body>
<%
	String id = (String)session.getAttribute("id"); 

	if(id == null || !id.equals("admin")){
		//잘못된 접근! 
		response.sendRedirect("Login/main.jsp");
	}

	UserDAO udao = new UserDAO(); 
	ArrayList<UserBean> arrUser = udao.getUserList(); 
	int size = arrUser.size(); 
%>
<h2>회원 목록</h2>
<table border="1">
	<tr>
	<!-- "select id, name, gender, age, userGrant, email,signInDate from userinfo"; -->
		<th>ID</th>
		<th>이름</th>
		<th>성별</th>
		<th>나이</th>
		<th>권한</th>
		<th>이메일</th>
		<th>가입일자</th>
		<th>수정</th>
		<th>전체 선택<input type="checkbox" id="chk_all" onclick="checkAll(this)"></th>
	</tr>
	<%
	for(UserBean ub : arrUser){
		if(ub.getUserGrant()==3) continue; //관리자는 건너뛰도록
		int userGrant = ub.getUserGrant(); 
	%>
	<tr>
		<td><%=ub.getId() %></td>
		<td><%=ub.getName() %></td>
		<td><%=(ub.getGender().equals("M") ? "남" : "여") %></td>
		<td><%=ub.getAge()%></td>
		<%-- <td><%=(ub.getUserGrant() == 0 ? "비회원" : "정회원") %></td> --%>
		<td>
			<select name="grant" id="grant_<%=ub.getId() %>">
				<!-- <option name="g00">추방</option> -->
				<option name="g01" value="0" <% if(userGrant == 0){ %>selected="selected" <%} %>>비회원</option>
				<option name="g02" value="1" <% if(userGrant == 1){ %>selected="selected" <%} %>>정회원</option>
			</select>
		</td>
		<td><%=ub.getEmail() %></td>
		<td><%=ub.getSignInDate()%></td>
		<td><input type="button" value="수정" id="btn_<%=ub.getId() %>" onclick="userGrantUpdate('<%=ub.getId() %>')"></td>
		<td align="center"><input type="checkbox" name="chkbox" id="chk_<%=ub.getId() %>" ></td>
	</tr>
	<%	
	}
	%>
</table>
<input type="button" value="일괄 수정" onclick="userGrantUpdateAll()">
<input type="button" value="추방" onclick="kickUser()">


<!-- TODO : Ajax로 변경?  -->
<!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script>
	function userGrantUpdate(id){
		//alert("grant_"+idx); 

		var grantSelect = document.getElementById("grant_"+id); 
		
		var index = grantSelect.selectedIndex; 
		//alert(grantSelect.options[index].text);
		//alert(grantSelect.options[index].value);
		
		location.href="updateUserGrantPro.jsp?id="+id+"&grant="+grantSelect.options[index].value ; 
	} //권한 업데이트 끝.
	
	
	function kickUser(){
		arr = [] ; 
		<%
		for(UserBean ub : arrUser){
			String uid = ub.getId(); 
			if ( uid.equals("admin") ) continue; 
			%>
			var test = document.getElementById("chk_<%=uid%>") ;
			//console.log(test.checked);
				if(test.checked){
					arr.push("<%=uid%>"); 
					//console.log("<%=uid%>");
				}
			<%
		}
		%>
		
		location.href="deleteUserListPro.jsp?arr="+arr; 
	} //유저 여러 명 삭제 
	
	function userGrantUpdateAll(){
		uid_list = [] ; 
		grant_list = [] ; 
		<%
		for(UserBean ub : arrUser){
			String uid = ub.getId(); 
			if ( uid.equals("admin") ) continue; 
			%>
			var test = document.getElementById("chk_<%=uid%>") ;
			var grantSelect = document.getElementById("grant_<%=uid%>"); 
			var index = grantSelect.selectedIndex;
			//console.log(test.checked);
				if(test.checked){
					
					uid_list.push("<%=uid%>"); 
					grant_list.push(grantSelect.options[index].value); 
					
					// TODO : 하나의 객체로 묶어서 보내는 방법 연구.
					// JSON 타입으로 묶어서 ajax 통신을 하면 되려나. 
					//arr.push({"<%=uid%>" : grantSelect.options[index].value}); 
					// [object%20Object] 에러가 난다. 
				}
			<%
		}
		%>
		location.href="updateUserListPro.jsp?uid_list="+uid_list+"&grant_list="+grant_list; 
	} // 권한 업데이트 여러 명 하기 
	
	
	function checkAll(selectAll) {
		  const checkboxes 
	       = document.getElementsByName('chkbox');
	  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  })
	}
</script>
</body>
</html>