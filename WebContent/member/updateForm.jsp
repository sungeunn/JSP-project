<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/update.css" />
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/variables.css" />
<link rel="stylesheet" href="../css/top.css" />
<title>allmovie : modify</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../js/postcode.js"></script>
</head>

<body>
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);
%>

	<header class="header">
		<nav>
			<ul class="header__menu">
				<li><a href="../main/main.jsp">HOME</a></li>
				<li><a href="../member/join.jsp">JOIN</a></li>
				<li><a href="../member/login.jsp">LOGIN</a></li>
			</ul>
		</nav>
		<a href="../main/main.jsp">
			<div class="logo">
				<img src="../images/logo_white.png" width="800" height="200">
			</div>
		</a>
	</header>

	<div class="update-container">
		<div class="update-redcarpet">
			<img src="../images/redcarpet.png" width="700" height="70">
		</div>
		<div class="update-wrap">
				<h2 class="update-title">MODIFY</h2>
			<form action="./updatePro.jsp" method="post" class="update-form">
		            <input type="text" name="id" class="id"  value="<%=mb.getId()%>"  readonly>
				    <input type="password" id="pass" name="pass" placeholder="* 비밀번호 (영문 대소문자/ 숫자 8~16자)" />
					<input type="text" name="name" value="<%=mb.getName()%>">
					<input type="text" name="phone" value="<%=mb.getPhone()%>">
					<input type="email" name="email" value="<%=mb.getEmail()%>">
					<div class="check-container">
						<input type="text" id="postcode" name="postcode" value="<%=mb.getPostcode()%>" />
						<button type="button" id="postcode_bt" onclick="DaumPostcode()">우편번호 찾기</button>
					</div>
					<input type="text" name="address" readonly value="<%=mb.getAddress()%>">
					<input type="text" id="detailAddress" name="detailAddress" value="<%=mb.getDetailAddress()%>" />
					<div class="submit-container">
			  	    	<button type="submit" class="update-form__submit">정보수정</button>
			  	    	<button type="reset" class="update-form__reset">취소</button>			
					</div>
			</form>
		</div>
	</div>

</body>
</html>