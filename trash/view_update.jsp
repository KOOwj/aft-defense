<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="view_update.css">
<title>Insert title here</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<%
	String category = null;
	String cat_eng = null;
	String cat_db = null;
	String cat_kor = null;
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	if(category.equals("notice")){
		cat_db = "notice_title";
		cat_eng = "news.jsp";
		cat_kor = "��������";
	}
	else if(category.equals("update")){
		cat_db = "update_title";
		cat_eng = "update.jsp";
		cat_kor = "������Ʈ";
	}
	else{
		cat_db = "event_title";
		cat_eng = "event.jsp";
		cat_kor = "�̺�Ʈ";
	}
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	//Connection con = null;
	Statement stmt = null;
	//String driverName = "com.mysql.jdbc.Driver";
	//String dbURL = "jdbc:mysql://localhost/project";
	
	try {
		//Class.forName(driverName);
		//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt
				.executeQuery("select title, hit, date, contents from " + cat_db + " where no=" + idx + ";");
		if (result.next()) {
			String title = result.getString(1);
			int hit = result.getInt(2);
			String date = result.getString(3);
			String contents = result.getString(4);
			hit++;
	
%>

<body>
	<div class="all">
		<div class="header">
			<ul class="topMenu">
				<li><a href="main.jsp">ART Defense</a></li>
				<li><a href="news.jsp">���ҽ�</a>
					<ul class="subMenu">
						<li><a href="news.jsp">��������</a></li>
						<li><a href="update.jsp">������Ʈ</a></li>
						<li><a href="event.jsp">�̺�Ʈ</a></li>
					</ul></li>
				<li><a href="#">���̵�</a>
					<ul class="subMenu">
						<li><a href="#">���Ӽ���</a></li>
						<li><a href="#">Ÿ������</a></li>
						<li><a href="#">��������</a></li>
					</ul></li>
				<li><a href="#">��ŷ</a></li>
				<li><a href="#">Ŀ�´�Ƽ</a>
					<ul class="subMenu">
						<li><a href="#">�����Խ���</a></li>
						<li><a href="#">�����Խ���</a></li>
						<li><a href="#">��аԽ���</a></li>
					</ul></li>
				<li><a href="#">������</a>
					<ul class="subMenu">
						<li><a href="#">����/1:1����</a></li>
						<li><a href="#">���� �Ű�</a></li>
					</ul></li>
				<li><a href="#">�ڷ��</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title"><%=cat_kor %></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="#" width="250" height="250"/>
			</button>
		</div>
		<div class="noticeline">
		<table class="view">
			<tr>
				<th><%= title %></th>
			</tr>
			<tr>
				<td id="date"><image src="eye.png"> <%=hit %>&nbsp;&nbsp;&nbsp; <image src="clock.png"> <%=date %></td>
			</tr>
			<tr>
				<td id="contents"><%=contents %></td>
			</tr>
			<tr>
				<td id="list"><button id="list" onclick="window.location='<%=cat_eng%>?pg=<%=pg%>'">���</button></td>
			</tr>
		</table>
		<%
		stmt.executeUpdate("UPDATE " + cat_db + " SET hit=" + hit + " where no=" + idx + ";");
			result.close();
			stmt.close();
			con.close();
		}
	} catch(SQLException e){
		out.print(e.toString());
	}
		%>
		<div class="nav">
				<div class="section01">���ҽ�</div>
				<ul>
					<li><a href="news.jsp">��������</a></li>
					<li><a href="update.jsp">������Ʈ</a></li>
					<li><a href="event.jsp">�̺�Ʈ</a></li>
				</ul>
			</div>
		</div>
	</div>
		<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
</body>
</html>