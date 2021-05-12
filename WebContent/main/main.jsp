<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie 당신의 인생영화는 무엇인가요?</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>

<body>
<div id="wrap">

<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더파일들어가는 곳 -->

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
  <div class="slide">
    <ul>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
  </div>
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<!-- 메인 콘텐츠 들어가는 곳 -->

<div class="book">
	<a href="http://www.cgv.co.kr/ticket/"><image src="../images/cgv.jpeg" width=200px; height=140px;></a>
	<a href="https://www.lottecinema.co.kr/NLCHS/Ticketing"><image src="../images/lotte.jpeg" width=250px; height=150px;></a>
	<a href="https://www.megabox.co.kr/booking"><image src="../images/megabox.jpeg" width=150px; height=150px;></a>
</div>

<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>

</body>
</html>