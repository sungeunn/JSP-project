<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie : id check</title>
<script type="text/javascript">
	function ok() {
		// window.opener 변수 : join.jsp에서 window.open(dupcheck.jsp) 창열기
		// dupcheck.jsp 에서 창을 열리게 한 페이지 join.jsp 를 opener변수에 저장
		// join.jsp 아이디상자 value= dupcheck.jsp에서 찾은 아이디 value 
		// alert("찾은 아이디 : "+document.wfr.id.value);
		window.opener.document.Member.id.value=document.wfr.id.value;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
<!-- member/dupcheck.jsp -->
<%
// http://localhost:8080/FunWeb/member/dupcheck.jsp?id=dd
// http가 id파라미터 값을 들고 옴 => request 저장
String id=request.getParameter("id");
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// int check= iddupcheck(id) 메서드 정의 하고 호출
%>
<form action="dupcheck.jsp" method="get" name="wfr"><br>
아이디 : <input type="text" name="id" value="<%=id%>">
<input type="submit" value="아이디중복체크"><br>

<%
int check=mdao.iddupcheck(id);
// check==1  "아이디 있음" "아이디 중복"
// check==-1 "아이디 없음" "아이디 사용가능"  
if(check==1){
	%>이미 사용중인 아이디입니다.<%
}else{
	%>사용 가능한 아이디입니다.
	<input type="button" value="아이디 사용" onclick="ok()"><%
}
%>
</form>
</body>
</html>