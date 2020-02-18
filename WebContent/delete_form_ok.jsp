<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ART Defense</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"/>
<%
String category = null;
String cat_db = null;
String cat_kor = null;
int idx = Integer.parseInt(request.getParameter("idx"));
int pg = Integer.parseInt(request.getParameter("pg"));
if(request.getParameter("category") != null){
	category = request.getParameter("category");
}
if(category.equals("free")){
	cat_db = "free_board";
	cat_kor = "�����Խ���";
}
else if(category.equals("info")){
	cat_db = "info_board";
	cat_kor = "�����Խ���";
}
else if(category.equals("discuss")){
	cat_db = "discuss_board";
	cat_kor = "��аԽ���";
}else if(category.equals("1vs1")){
	cat_db = "customer_1vs1";
	cat_kor = "1:1����";
}else if(category.equals("���׽Ű�")){
	cat_db = "customer_bug";
	cat_kor = "���׽Ű�";
}
Statement stmt = null;
try{
	Connection con = db.getConnection();
	stmt = con.createStatement();
	stmt.executeUpdate("delete from " + cat_db + " where no=" + idx + ";");
	stmt.executeUpdate("update " + cat_db + " set no = no - 1 where no > " + idx + ";");
	
	stmt.close();
	con.close();
} catch(SQLException e){
	out.println(e.toString());
}
	if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
%>
	<script language=javascript>
	self.window.alert("��ϵǾ����ϴ�.");
	location.href="board.jsp?category=<%=category%>";
	</script>
	<%} else{ %>
<script language=javascript>
	self.window.alert("��ϵǾ����ϴ�.");
	location.href="customer.jsp?category=<%=category%>";
	</script>
	<%} %>
<body>

</body>
</html>