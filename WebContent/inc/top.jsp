<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header>
<%
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// if 세션값이  없으면 로그인 안한 상태 login join 보이기
//				   있으면 로그인 성공 OO님 logout 회원정보수정
if(id == null) {
	%>
	<div id="login"><a href="../member/join.jsp">join</a> | <a href="../member/login.jsp">login</a></div>
	<%
} else {
	%>
	<div id="login"><%=id %>님 | <a href="../member/logout.jsp">logout</a> | <a href="../member/updateForm.jsp">modify</a></div>
	<%
}
%>

<div class="clear"></div>

<!-- 로고들어가는 곳 -->
<a href="../main/main.jsp">
<div class="logo"><img src="../images/logo_black.png" width="700" height="200"></div>
</a>
<!-- 로고들어가는 곳 -->

<div class="clear"></div>

<nav id="top_menu">
<ul>
		<li><a href="../about/about.jsp">ABOUT</a></li>
		<li><a href="../review/notice.jsp">REVIEW</a></li>
		<li><a href="../board/notice.jsp">BOARD</a></li>
		<li><a href="../gallery/notice.jsp">GALLERY</a></li>
		<li><a href="../contact/contact.jsp">CONTACT</a></li>
</ul>
</nav>

</header>
 