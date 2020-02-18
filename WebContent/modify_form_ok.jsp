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
<jsp:useBean id="write" class="project.write_bean" />
<jsp:useBean id="db" class="project.DBcon_bean" />

<jsp:setProperty property="title" name="write" />
<jsp:setProperty property="contents" name="write" />

<%
String search = null;
if(request.getParameter("search") != null){
	search = request.getParameter("search");
}
String category = null;
String cat_db = null;
String cat_kor = null;
if (request.getParameter("category") != null) {
	category = request.getParameter("category");
}
if (category.equals("free")) {
	cat_db = "free_board";
	cat_kor = "자유게시판";
} else if (category.equals("info")) {
	cat_db = "info_board";
	cat_kor = "정보게시판";
} else if (category.equals("discuss")) {
	cat_db = "discuss_board";
	cat_kor = "토론게시판";
} else if (category.equals("1vs1")){
	cat_db = "customer_1vs1";
	cat_kor = "1:1문의";
} else if (category.equals("bug")){
	cat_db = "customer_bug";
	cat_kor = "버그신고";
}
	String title = write.getTitle();
	String contents = write.getContents();
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	Statement stmt = null;
	try{
		Connection con = db.getConnection();
		stmt = con.createStatement();
		stmt.executeUpdate("update " + cat_db + " set title='" + title + "', contents='" + contents + "'where no=" + idx + ";");
	} catch(SQLException e){
		out.println(e.toString());
	}

	if(search == null){
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="view_board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>";
</script>
<%
	} else{
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="view_board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>&search=<%=search%>";
</script>
<%
}
%>
</head>
<body>

</body>
</html>