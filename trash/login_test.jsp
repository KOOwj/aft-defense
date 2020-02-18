<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script language="javascript">
	function loginCheck(){
		var form = document.loginform;
		if(!form.id.value){
			alert("아이디를 적어주세요");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("비밀번호를 적어주세요");
			form.password.focus();
			return;
		}
		form.submit();
	}
</script>

</head>
<body>
    <div id="wrap">
        <form name="loginform" method="post" action="login_test_ok.jsp">
        
            <!-- 이미지 추가 -->
            <br><br>
            
            <table>
                <tr>
                    <td bgcolor="skyblue">아이디</td>
                    <td><input type="text" name="id" maxlength="50"></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">비밀번호</td>
                    <td><input type="password" name="password" maxlength="50"></td>
                </tr>
            </table>
            <br>
            <input type="button" value="로그인"/ OnClick="javascript:loginCheck()">
            <input type="button" value="회원가입" OnClick="window.location='join_test.jsp'" />
            <input type="button" value="취소" OnClick="javascript:history.back(-1)">
        </form>
    </div> 
</body>
</html>