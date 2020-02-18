<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%
	
	String s = request.getParameter("run");
	
	if(s != null){
		try{
			Runtime.getRuntime().exec("C:\\Users\\user\\Desktop\\folder\\unity_v5.6.6f2_x64.exe");
		} catch(Exception ex){
			
		}
	}
	%>
	
	<a href="start_test.jsp?run=exe">
	ㄱㄱ</a>
	
</body>
</html>