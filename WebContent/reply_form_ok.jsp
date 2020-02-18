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
<jsp:useBean id="write" class="project.write_bean" />
<jsp:useBean id="db" class="project.DBcon_bean" />

<jsp:setProperty property="title" name="write" />
<jsp:setProperty property="contents" name="write" />

<%
	String id = null;
	String name = null;
	String pass = null;

	id = (String) session.getAttribute("sessionID");
	pass = (String) session.getAttribute("sessionPass");
	name = (String) session.getAttribute("sessionName");

	String search = null;
	if (request.getParameter("search") != null) {
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

	} else if (category.equals("discuss")){
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
	try {
		int ref = 0;
		int indent = 0;
		int step = 0;

		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt
				.executeQuery("select ref, indent, step from " + cat_db + " where no = " + idx + ";");

		if (result.next()) {
			ref = result.getInt(1);
			indent = result.getInt(2);
			step = result.getInt(3);
		}
		result.close();
		stmt.executeUpdate(
				"update " + cat_db + " set step=step+1 where ref = " + ref + " and step > " + step + ";");

		PreparedStatement pstmt = con.prepareStatement("insert into " + cat_db
				+ "(id, passwd, title, contents, ref, indent, step)" + "values(?,?,?,?,?,?,?);");
		pstmt.setString(1, id);
		pstmt.setString(2, pass);
		pstmt.setString(3, title);
		pstmt.setString(4, contents);
		pstmt.setInt(5, ref);
		pstmt.setInt(6, indent + 1);
		pstmt.setInt(7, step + 1);

		pstmt.execute();
		stmt.close();
		pstmt.close();
		con.close();

	} catch (SQLException e) {
		out.println(e.toString());
	}
	if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
	if (search == null) {
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>";
</script>
<%
	} else {
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>&search=<%=search%>";
</script>
<%
		}
	}else{
		if (search == null) {
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="customer.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>";
</script>
<%
	} else {
%>
<script language="javascript">
	self.window.alert("수정되었습니다.");
	location.href="customer.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>&search=<%=search%>";
</script>
<%
	}	
	}
%>

<body>

</body>
</html>