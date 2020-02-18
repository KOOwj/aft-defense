<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="login_form.css">
<title>ART Defense</title>
<script language="javascript">
	function loginCheck(){
		var form = document.loginform;
		if(!form.id.value){
			alert("아이디를 입력해주세요.");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
			return;
		}
		form.submit();
	}
</script>

<% 
String category = null;
if(request.getParameter("category") != null){
	category = request.getParameter("category");
}
%>


</head>
<body>
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
		<div class="login">
			<table>
				<form name="loginform" method="post" action="login_form_ok.jsp?category=<%=category%>">
					<tr>
						<th>로그인</th>
					</tr>
					<tr>
						<td><input type="text" name="id" placeholder="ID"></td>
					</tr>
					<tr>
						<td><input type="password" name="password" placeholder="PW"></td>
					</tr>
					<tr>
						<td><input id="login" type="button" value="로그인" onclick="javascript:loginCheck()"> <input
							id="member" type="button" value="회원가입" onclick="window.location='join_form.jsp'"></td>
					</tr>

				</form>
			</table>
		</div>
	</div>
</body>
</html>