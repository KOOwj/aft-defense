<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script language = "javascript">
	function joinCheck(){
		var form = document.joinform;
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
		if(!form.repassword.value || (form.password.value != form.repassword.value)){
			alert("비밀번호를 확인해주세요");
			form.repassword.focus();
			return;
		}
		
		if(!form.name.value){
			alert("이름을 적어주세요");
			form.name.focus();
			return;
		}
		if(!form.birthday.value){
			alert("생년월일을 적어주세요");
			form.birthday.focus();
			return;
		}
		if(!form.email.value){
			alert("이메일을 적어주세요");
			form.email.focus();
			return;
		}
		if(!form.phone.value){
			alert("휴대전화를 적어주세요");
			form.phone.focus();
			return;
		}
		form.submit();
	}
</script>

</head>
<body>
    <!-- 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div id="wrap">
        <br><br>
        <b><font size="6" color="gray">회원가입</font></b>
        <br><br><br>
        <form name="joinform" method="post" action="join_test_ok.jsp">
            <table>
                <tr>
                    <td id="title">아이디</td>
                    <td>
                        <input type="text" name="id" maxlength="20">
                        <input type="button" value="중복확인" >    
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input type="password" name="password" maxlength="15">
                    </td>
                </tr>
                
                <tr>
                    <td id="title">비밀번호 확인</td>
                    <td>
                        <input type="password" name="repassword" maxlength="15">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">이름</td>
                    <td>
                        <input type="text" name="name" maxlength="40">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">성별</td>
                    <td>
                        <input type="radio" name="gender" value="남" checked>남
                        <input type="radio" name="gender" value="여" >여
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">생년월일</td>
                    <td>
                    	<input type="date" name="birthday" placeholder="ex)000000" maxlength="6">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">이메일</td>
                    <td>
                        <input type="email" name="email" placeholder="ex)example@xxxxx.com" maxlength="30">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">휴대전화</td>
                    <td>
                        <input type="tel" name="phone" placeholder="ex)000-0000-0000"/>
                    </td>
                </tr>
            </table>
            <br>
            <input type="button" value="가입"/ OnClick="javascript:joinCheck()">  <input type="button" value="취소" onclick="javascript:history.back(-1)">
        </form>
    </div>
</body>
</html>