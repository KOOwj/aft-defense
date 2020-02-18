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

<title>ART Defense</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<%
	String search = null;
	if (request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	String category = null;
	String cat_db = null;
	String cat_kor = null;
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	if (category.equals("game")){
		cat_kor = "��������";
		cat_db = "game_info";
		%><link rel="stylesheet" type="text/css" href="guide_game.css"><%
	}
	else if (category.equals("tower")){
		cat_kor = "Ÿ������";
		cat_db = "tower_info";
		%><link rel="stylesheet" type="text/css" href="guide_tower.css"><%
	}
	else if (category.equals("monster")){
		cat_kor = "��������";
		cat_db = "monster_info";
		%><link rel="stylesheet" type="text/css" href="guide_monster.css"><%
	}
	
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
				.executeQuery("select contents from " + cat_db + ";");
		if (result.next()) {
			String contents = result.getString(1);
%>

<body>
	<div class="all">
		<div class="header">
			<ul class="topMenu">
				<li><a href="main.jsp">ART Defense</a></li>
				<li><a href="news.jsp?category=notice">���ҽ�</a>
					<ul class="subMenu">
						<li><a href="news.jsp?category=notice">��������</a></li>
						<li><a href="news.jsp?category=update">������Ʈ</a></li>
						<li><a href="news.jsp?category=event">�̺�Ʈ</a></li>
					</ul></li>
				<li><a href="guide_game.jsp?category=game">���̵�</a>
					<ul class="subMenu">
						<li><a href="guide_game.jsp?category=game">���Ӽ���</a></li>
						<li><a href="guide_tower.jsp?category=tower">Ÿ������</a></li>
						<li><a href="guide_monster.jsp?category=monster">��������</a></li>
					</ul></li>
				<li><a href="rank.jsp?category=rank">��ŷ</a></li>
				<li><a href="board.jsp?category=free">Ŀ�´�Ƽ</a>
					<ul class="subMenu">
						<li><a href="board.jsp?category=free">�����Խ���</a></li>
						<li><a href="board.jsp?category=info">�����Խ���</a></li>
						<li><a href="board.jsp?category=discuss">��аԽ���</a></li>
					</ul></li>
				<li><a href="customer.jsp?category=1vs1">������</a>
					<ul class="subMenu">
						<li><a href="customer.jsp?category=1vs1">����/1:1����</a></li>
						<li><a href="customer.jsp?category=bug">���� �Ű�</a></li>
					</ul></li>
				<li><a href="data.jsp?category=data">�ڷ��</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title"><%=cat_kor %></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250"/>
			</button>
		</div>
		<div class="noticeline">
		<table class="view">
			<tr>
				<td id="contents"><%=contents %></td>
			</tr>
		</table>
		<%
			result.close();
			stmt.close();
			con.close();
		}
	} catch(SQLException e){
		out.print(e.toString());
	}
	String id = (String) session.getAttribute("sessionID");
	String name = (String) session.getAttribute("sessionName");
	if (id == null) {
		%>
		<button id="login" onclick="window.location='login_form.jsp?category=<%=category%>'">�α���</button>
		<%
					} else {
				%>
				<button id="login1"><%=name%>��
				</button>
				<%
					}
				%>
		<div class="nav">
		
				
				
				<div class="section01">���̵�</div>
				<ul>
					<li><a href="guide_game.jsp?category=game">���Ӽ���</a></li>
					<li><a href="guide_tower.jsp?category=tower">Ÿ������</a></li>
					<li><a href="guide_monster.jsp?category=monster">��������</a></li>
				</ul>
			</div>
		</div>
		<div class="footer">
			<br>
			<ul class="footer">
				<li><a href="#">���۱���å��</a></li>
				<li><a href="#">�̿�ȳ���</a></li>
				<li><a href="#">�����̿��޾ȳ���</a></li>
				<li><a href="#">��������ó����ħ��</a></li>
				<li><a href="#">û�ҳ⺸ȣ��å��</a></li>
				<li><a href="#">ȸ�����񽺾����</a></li>
				<li><a href="#">Ȩ������ �����Ű�</a></li>
			</ul>
			<br />

			<ul class="footer">
				<li>������ ��õ�� ���� ���ַ�80����-16 ��ö����/ TEL: 010-2944-4455/ FAX:
					010-8243-6780</li>
				<br>
				<li>Copyright(c) ART Defense All. rights Reserved.</li>
			</ul>
			<br>
		</div>
	</div>
</body>
</html>