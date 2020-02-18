<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="java.util.Enumeration" %>
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
	String category = null;
	String cat_db = null;
	String cat_kor = null;
	String id = null;
	String pass = null;
	String title = null;
	String contents = null;
	int cnt = 0;
	int max = 0;
	String realFolder = "";
	String filename1 = "";
	int maxSize = 1024*1024*5;
	String encType = "euc-kr";
	String savefile = "img";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath(savefile);
	String realpath = "C:\\Users\\user\\Downloads\\webprogram\\project\\project\\WebContent\\img";

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
	
	id = (String) session.getAttribute("sessionID");
	pass = (String)session.getAttribute("sessionPass");
	title = null;
	contents = null;

	try{
		MultipartRequest multi=new MultipartRequest(request, realpath, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
		String file1 = (String)files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		title = multi.getParameter("title");
		contents = multi.getParameter("contents");
		contents = contents.replace("\r\n","<br>");
		String fullpath = realpath + "\\" + filename1;

		Connection con = db.getConnection();
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select min(no+1) from " + cat_db + " where (no+1) not in (select no from " + cat_db + ");");
		if(result.next()){
			cnt = result.getInt(1);
		}
		result.close();
		result = stmt.executeQuery("select max(no) from " + cat_db + ";");
		if(result.next()){
			max = result.getInt(1);
		}
		result.close();
		
		PreparedStatement pstmt = con.prepareStatement("insert into " + cat_db+"(no, id, passwd, title, contents, ref, image_path ) values(?,?,?,?,?,?,?);");
		pstmt.setInt(1, cnt);
		pstmt.setString(2, id);
		pstmt.setString(3, pass);
		pstmt.setString(4, title);
		pstmt.setString(5, contents);
		pstmt.setInt(6, max+1);
		if(filename1 != null){
			//pstmt.setString(7, fullpath);
			pstmt.setString(7, "img/"+filename1);
		}
		else{
			pstmt.setString(7, null);
		}
		
		pstmt.execute();
		

		pstmt.close();
		stmt.close();
		con.close();
		
		
	} catch(SQLException e){
		out.print(e.toString());
	}catch(Exception e) {
		out.print(e.toString());
	 }
	
	if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
%>
	<script language=javascript>
	self.window.alert("등록되었습니다.");
	location.href="view_board.jsp?category=<%=category%>&pg=1&idx=<%=cnt%>";
	</script>
	<%} else{ %>
<script language=javascript>
	self.window.alert("등록되었습니다.");
	location.href="view_board.jsp?category=<%=category%>&pg=1&idx=<%=cnt%>";
	</script>
	<%} %>

<body>

</body>
</html>