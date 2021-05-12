<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function () {
		
		
		$.ajax({
			url: "ajax2.jsp",
			data: {test:"test"} , 
			method : "get",
			success: function(result){
				alert("성공!"); 
				$('body').append(result); 
			}
		}); 
	}) ; 
</script>
</head>
<body>

</body>
</html>