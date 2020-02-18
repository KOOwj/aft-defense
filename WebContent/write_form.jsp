<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ART Defense</title>
<script language="javascript">
	function writeCheck() {
		var form = document.writeform;
		if (!form.title.value) {
			alert("제목을 적어주세요");
			form.title.focus();
			return;
		}
		if (!form.contents.value) {
			alert("내용을 적어주세요");
			form.contents.focus();
			return;
		}
		form.submit();
	}
</script>
</head>
<body>
	<%
		String category = null;
		String cat_db = null;
		String cat_kor = null;
		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		if (category.equals("free")) {
			cat_db = "free_board";
			cat_kor = "자유게시판";
	%><link rel="stylesheet" type="text/css" href="write_free.css">
	<%
		} else if (category.equals("info")) {
			cat_db = "info_board";
			cat_kor = "정보게시판";
	%><link rel="stylesheet" type="text/css" href="write_info.css">
	<%
		} else if (category.equals("discuss")) {
			cat_db = "discuss_board";
			cat_kor = "토론게시판";
	%><link rel="stylesheet" type="text/css" href="write_discuss.css">
	<%
		} else if (category.equals("1vs1")) {
			cat_db = "customer_1vs1";
			cat_kor = "1:1문의";
	%><link rel="stylesheet" type="text/css" href="write_free.css">
	<%
		} else if (category.equals("bug")) {
			cat_db = "customer_bug";
			cat_kor = "버그신고";
	%><link rel="stylesheet" type="text/css" href="write_info.css">
	<%
		}

		String id = null;
		String pass = null;
		String name = null;
		id = (String) session.getAttribute("sessionID");
		name = (String) session.getAttribute("sessionName");
		pass = (String) session.getAttribute("sessionPass");

		if (id != null && pass != null) {
	%>
	<div class="all">
		<div class="header">
			<ul class="topMenu">
				<li><a href="main.jsp">ART Defense</a></li>
				<li><a href="news.jsp?category=notice">새소식</a>
					<ul class="subMenu">
						<li><a href="news.jsp?category=notice">공지사항</a></li>
						<li><a href="news.jsp?category=update">업데이트</a></li>
						<li><a href="news.jsp?category=event">이벤트</a></li>
					</ul></li>
				<li><a href="guide_game.jsp?category=game">가이드</a>
					<ul class="subMenu">
						<li><a href="guide_game.jsp?category=game">게임설명</a></li>
						<li><a href="guide_tower.jsp?category=tower">타워정보</a></li>
						<li><a href="guide_monster.jsp?category=monster">몬스터정보</a></li>
					</ul></li>
				<li><a href="rank.jsp?category=rank">랭킹</a></li>
				<li><a href="board.jsp?category=free">커뮤니티</a>
					<ul class="subMenu">
						<li><a href="board.jsp?category=free">자유게시판</a></li>
						<li><a href="board.jsp?category=info">정보게시판</a></li>
						<li><a href="board.jsp?category=discuss">토론게시판</a></li>
					</ul></li>
				<li><a href="customer.jsp?category=1vs1">고객지원</a>
					<ul class="subMenu">
						<li><a href="customer.jsp?category=1vs1">도움말/1:1문의</a></li>
						<li><a href="customer.jsp?category=bug">버그 신고</a></li>
					</ul></li>
				<li><a href="data.jsp?category=data">자료실</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title"><%=cat_kor%></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250" />
			</button>
		</div>
		<div class="noticeline">
			<div class="notice">
				<table class="write">
					<form name="writeform" method="post"\ action="write_form_ok.jsp?category=<%=category%>" enctype="multipart/form-data">
						<tr>
							<th colspan="2">글쓰기</th>
						</tr>

						<tr>
							<td id="title">제목</td>
							<td><input id="title" type="text" name="title"></td>
						</tr>
						
						<tr>
							<td id="file">첨부</td>
							<td><input id="file" type="file" name="file"></td>
						</tr>

						<tr>
							<td id="contents">내용</td>
							<td><textarea id="contents" name="contents"></textarea></td>
						</tr>

						<tr>
							<td id="button" colspan="2"><input type="button" value="확인"
								onclick="javascript:writeCheck();"> <input type="button"
								value="취소" onclick="javascript:history.back(-1)"></td>
						</tr>
					</form>
				</table>
			</div>

			<button id="login1"><%=name%>님
			</button>
			<div class="nav">
				<%
					if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
				%>
				<div class="section01">커뮤니티</div>
				<ul>
					<li><a href="board.jsp?category=free">자유게시판</a></li>
					<li><a href="board.jsp?category=info">정보게시판</a></li>
					<li><a href="board.jsp?category=discuss">토론게시판</a></li>
				</ul>
				<%
					} else {
				%>
				<div class="section01">고객지원</div>
				<ul>
					<li><a href="customer.jsp?category=1vs1">1:1문의</a></li>
					<li><a href="customer.jsp?category=bug">버그신고</a></li>
				</ul>
				<%
					}
				%>
			</div>
		</div>
		<div class="footer">
			<br>
			<ul class="footer">
				<li><a href="#">저작권정책｜</a></li>
				<li><a href="#">이용안내｜</a></li>
				<li><a href="#">게임이용등급안내｜</a></li>
				<li><a href="#">개인정보처리방침｜</a></li>
				<li><a href="#">청소년보호정책｜</a></li>
				<li><a href="#">회원서비스약관｜</a></li>
				<li><a href="#">홈페이지 오류신고</a></li>
			</ul>
			<br />

			<ul class="footer">
				<li>강원도 춘천시 교동 삭주로80번지-16 원철민준/ TEL: 010-2944-4455/ FAX:
					010-8243-6780</li>
				<br>
				<li>Copyright(c) ART Defense All. rights Reserved.</li>
			</ul>
			<br>
		</div>
	</div>

	<%
		} else {
	%>
	<script language="javascript">
		self.window.alert("로그인 해주세요.");
		javascript: history.back(-1);
	</script>
	<%
		}
	%>
</body>
</html>