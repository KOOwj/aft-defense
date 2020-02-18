<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%
    request.setCharacterEncoding("euc-kr");
    %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="join_form.css">
<title>ART Defense</title>
<script language = "javascript">
	
	function joinCheck(){
		var form = document.joinform;
		if(!form.id.value){
			alert("아이디를 입력해주세요.");
			form.id.focus();
			return;
		}
		var idRule = /^[A-Za-z0-9]{4,18}$/;
		if(!(idRule.test(form.id.value))){
			alert("아이디는 영문/숫자 4~18자리 입니다.");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
			return;
		}
		var passwordRule = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		if(!(passwordRule.test(form.password.value))){
			alert("비밀번호는 영문/숫자/특수문자 8~16자리 입니다.")
			form.password.focus();
			return;
		}
		if(!form.repassword.value || (form.password.value != form.repassword.value)){
			alert("비밀번호를 확인해주세요.");
			form.repassword.focus();
			return;
		}
		if(!form.name.value){
			alert("이름을 적어주세요.");
			form.name.focus();
			return;
		}	
		if(!form.birthday.value){
			alert("생년월일을 입력해주세요.");
			form.birthday.focus();
			return;
		}

		if(!form.phone.value){
			alert("핸드폰을 입력해주세요.");
			form.phone.focus();
			return;
		}
		var phoneRule = /^\d{3}-\d{3,4}-\d{4}$/;
		if(!(phoneRule.test(form.phone.value))){
			alert("핸드폰 형식을 맞춰주세요.");
			form.phone.focus();
			return;
		}
		if(!form.email.value){
			alert("이메일을 입력해주세요.");
			form.email.focus();
			return;
		}
		var emailRule = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!(emailRule.test(form.email.value))){
			alert("이메일 형식을 맞춰주세요.");
			form.email.focus();
			return;
		}
		form.submit();
	}
</script>

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
		<div class="join">
			<table>
			<form name="joinform" method="post" action="join_form_ok.jsp">
			<tr><th>회원가입</th></tr>
			<tr><td><input id = "idform" type="text" name="id" placeholder="ID"/></td></tr>
			<tr><td><input type="password" name="password" placeholder="PW"></td></tr>
			<tr><td><input type="password" name="repassword" placeholder="PW"></td></tr>
			<tr><td><input type="text" name="name" placeholder="이름"></td></tr>
			<tr><td><input type="text" name="birthday" placeholder="951109"></td></tr>
			<tr><td><input type="tel" name="phone" placeholder="010-0000-0000"></td></tr>
			<tr><td><input type="email" name="email" placeholder="example@xxxxx.com"></td></tr>
			<tr><td><input id="login" type="button" value="확인" onclick="javascript:joinCheck()"> <input id="member" type="button" value="취소" onclick="javascript:history.back(-1)"></td></tr>
		
			</form>
			</table>
		</div>
	</div>
</body>
</html>