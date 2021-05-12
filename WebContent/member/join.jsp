<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/join.css" />
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/variables.css" />
<link rel="stylesheet" href="../css/top.css" />
<title>allmovie : join</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../js/postcode.js"></script>
<script defer src="../js/join.js"></script>
<script type="text/javascript">
 function dupcheck() {
	// 아이디 텍스트 상자가 비어있으면 "아이디 입력하세요" 포커스 리턴
	if(document.Member.id.value==""){
		alert("아이디를 입력하세요.");
		document.Member.id.focus();
		return;
	}
	// 아이디 상자 입력되어있으면
	// 윈도창 열기
	var idvalue=document.Member.id.value;
	window.open("dupcheck.jsp?id="+idvalue,"","width=400,height=100");
 }
 </script>
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
			<div class="logo">
				<img src="../images/logo_white.png" width="800" height="200">
			</div>
		</a>
	</header>

	<div class="join-container">
		<div class="join-redcarpet">
			<img src="../images/redcarpet.png" width="700" height="70">
		</div>
		<div class='join-wrap'>
			<h2 class="join-title">JOIN</h2>
			<form action="./joinPro.jsp" name="Member" method="post" class="join-form join-form-js">
			
				<div class="check-container">
					<input type="text" id="id" name="id" placeholder="* 아이디 (영문 소문자/ 숫자 4~12자)"
						required/>
					<button type="button" value="dup. check" class="dup" onclick="dupcheck()">아이디 중복확인</button>
				</div>
				<input type="password" id="pass" name="pass" placeholder="* 비밀번호 (영문 대소문자/ 숫자 8~16자)" />
				<input type="password" id="confirm-pass" name="passck" placeholder="* 비밀번호 확인" />
				<input type="text" id="name" name="name" placeholder="* 이름" />
				<input type="text" id="phone" name="phone" placeholder="* 휴대폰 번호 ( - 없이 입력하세요.)" />
				<input type="email" id="email" name="email" placeholder="* 이메일" />
				<div class="check-container">
					<input type="text" id="postcode" name="postcode" placeholder="* 우편번호" />
					<button type="button" id="postcode_bt" onclick="DaumPostcode()">우편번호 찾기</button>
				</div>
				<input type="text" id="address" name="address" readonly placeholder="* 주소" />
				<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" />
				<div class="check-container">
					<div class="bir_wrap">
						<div class="bir_yy">
							<input type="text" id="yy" name="yy" placeholder="년도(4자)" class="int" maxlength="4">		
						</div>
						<div class="bir_mm">
							<select id="mm" name="mm" class="sel">
								<option value="0">월</option>
								<option value="1">01</option>
								<option value="2">02</option>
								<option value="3">03</option>
								<option value="4">04</option>
								<option value="5">05</option>
								<option value="6">06</option>
								<option value="7">07</option>
								<option value="8">08</option>
								<option value="9">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div>
						<div class=" bir_dd">
							<input type="text" id="dd" name="dd" placeholder="일" class="int" maxlength="2">
						</div>
					</div>
				</div>	
				<div class="check-container">
					<input type="radio" class="btn" name="gender" id="id-gender-male" value="male" />
					<label for=id-gender-male>male</label>
					<input type="radio" class="btn" name="gender" id="id-gender-female" value="female" />
					<label for="id-gender-female">female</label>
				</div>
				<div class="submit-container">
					<button type="submit" class="join-form__submit join-form-submit-btn-js" onclick="send_mail()">회원가입</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>