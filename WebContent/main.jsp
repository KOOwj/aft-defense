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
<link rel="stylesheet" type="text/css" href="main.css">
<title>ART Defense</title>
</head>

<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<body>

	<%
		//Connection con = null;

		//String driverName = "org.gjt.mm.mysql.Driver";
		//String driverName = "com.mysql.jdbc.Driver";
		//String dbURL = "jdbc:mysql://localhost/project";
		String cat_db = null;
		int n = 0;
		String c = null;
		String category = null;
		try {
			//Class.forName(driverName);
			//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			Statement stmt = null;
			Statement stmt2 = null;
			Connection con = db.getConnection();
			stmt = con.createStatement();
			stmt2 = con.createStatement();
			ResultSet result = stmt
					.executeQuery("select category, title, date from all_news order by no desc limit 5;");
	%>

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
		<div id="slider">
			<figure>
				<a href="#"><img src="slide1.jpg" alt=""></a>
				<a href="#"><img src="slide2.jpg" alt=""></a>
				<a href="#"><img src="slide3.jpg" alt=""></a>
				<a href="#"><img src="slide4.jpg" alt=""></a>
				<a href="#"><img src="slide1.jpg" alt=""></a>
			</figure>
		</div>
		<div class="line">
			<button id="left">&lt;</button>
			<button id="right">&gt;</button>
		</div>
		<div class="startline">
			<div class="download">
				<a href="https://ko-kr.facebook.com/FacebookKorea/" target="_block"><image
						src="facebook.png">���̽��� �ٷΰ���</a> <a
					href="https://www.youtube.com/" target="_block"><image
						src="youtube.png">��Ʃ�� �ٷΰ���</a>
			</div>
			<div class="start">
				<button id="start" onclick="window.location='start.jsp?run=exe'">
					<image src="real_start.png" width="250" height="250">
				</button>
			</div>
			<%
				String id = (String) session.getAttribute("sessionID");
					String name = (String) session.getAttribute("sessionName");
			%>

			<div class="customer">
				<%
					if (id == null) {
				%>
				<button id="login"
					onclick="window.location='login_form.jsp?category=main'">�α���</button>
				<button id="join" onclick="window.location='join_form.jsp'">ȸ������</button>
				<%
					} else {
				%>
				<button id="login1"><%=name%>��
				</button>
				<button id="join" onclick="window.location='logout.jsp'">�α׾ƿ�</button>
				<%
					}
				%>
			</div>
		</div>

		<div class="sectionline">
			<div class="section01">
				<ul class="notice">���ҽ�
				</ul>
				<span><a href="news.jsp?category=notice">������+</a></span>

				<%
					while (result.next()) {
							if ((result.getString(1)).equals("[����]") || (result.getString(1)).equals("[����]")) {
								cat_db = "notice_title";
								c = "notice";
							} else if ((result.getString(1)).equals("[������Ʈ]")) {
								cat_db = "update_title";
								c = "update";
							} else if ((result.getString(1)).equals("[�̺�Ʈ]")) {
								cat_db = "event_title";
								c = "event";
							}
							ResultSet result2 = stmt2.executeQuery("select no from " + cat_db + " where title='"
									+ result.getString(2) + "' and date='" + result.getString(3) + "';");
							if (result2.next()) {
								n = result2.getInt(1);
							}
							result2.close();
				%>
				<li><a href="view_news.jsp?category=<%=c%>&pg=1&idx=<%=n%>"><%=result.getString(1) + result.getString(2)%></a></li>

				<%
					}
						stmt2.close();
						result.close();
						stmt.close();
				%>
			</div>
			<%
				String nn[] = new String[5];
					int cc = 0;
					int ss = 0;
					int hh = 0;
					int mm = 0;
					String tt[] = new String[5];
					Statement stmt3 = con.createStatement();
					ResultSet result3 = stmt3.executeQuery("select id, score from project.rank order by step2 asc limit 5");
					int i = 0;	
					while (result3.next()) {
						nn[i] = result3.getString(1);
						cc = result3.getInt(2);
						hh = cc / 3600;
						mm = (cc % 3600) / 60;
						ss = (cc % 3600) % 60;
						tt[i] = String.format("%02d:%02d:%02d", hh, mm, ss);
						i++;
					}
			%>
			<div class="section02">
				<ul class="ranking">��ŷ
				</ul>
				<span><a href="rank.jsp?category=rank">������+</a></span>
				<table class="rk">
					<tr>
						<td id="tnsdnl"><image src="ico_ranking_gold.png" /></td>
						<td id="dkdlel"><%=nn[0]%></td>
						<td id="ch"><%=tt[0]%></td>
					</tr>
					<tr>
						<td id="tnsdnl"><image src="ico_ranking_silver.png" /></td>
						<td id="dkdlel"><%=nn[1]%></td>
						<td id="ch"><%=tt[1]%></td>
					</tr>
					<tr>
						<td id="tnsdnl"><image src="ico_ranking_bronze.png" /></td>
						<td id="dkdlel"><%=nn[2]%></td>
						<td id="ch"><%=tt[2]%></td>
					</tr>
					<tr id="45">
						<td id="tnsdnl">4</td>
						<td id="dkdlel"><%=nn[3]%></td>
						<td id="ch"><%=tt[3]%></td>
					</tr>
					<tr id="45">
						<td id="tnsdnl">5</td>
						<td id="dkdlel"><%=nn[4]%></td>
						<td id="ch"><%=tt[4]%></td>
					</tr>
				</table>
			</div>
		</div>
		<%
			stmt3.close();
				result3.close();
				con.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
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