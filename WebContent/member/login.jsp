<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/login.css"/>
<link rel="stylesheet" href="../css/reset.css"/>
<link rel="stylesheet" href="../css/variables.css"/>
<link rel="stylesheet" href="../css/top.css"/>
<title>allmovie : login</title>
</head>

<body>

<header class="header">
<nav>
	<ul class="header__menu">
		<li><a href="../main/main.jsp">HOME</a></li>
		<li><a href="../member/join.jsp">JOIN</a></li>
		<li><a href="../member/login.jsp">LOGIN</a></li>
	</ul>
</nav>
<a href="../main/main.jsp">
<div class="logo"><img src="../images/logo_white.png" width="800" height="200"></div>
</a>
</header>

<div class="login-container">
	<div class="login-redcarpet">
		<img src="../images/redcarpet.png" width="700" height="70">
	</div>
	<div class='login-wrap'>
		<h1 class="login-title">LOGIN</h1>
		<form action="./loginPro.jsp" method="post" class="login-form">
	    <input type="text" name="id" placeholder="아이디"/>
	    <input type="password" name="pass" placeholder="비밀번호"/>
		<div class="submit-container">
		  	  <button type="submit" class="login-form__submit">로그인</button>		
		</div>
		</form>
	</div>
</div>

</body>
</html>