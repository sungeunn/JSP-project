<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="review.ReviewDAO"%>
<%@page import="review.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie REVIEW</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/review.css" rel="stylesheet" type="text/css">
<link href="../css/star.css" rel="stylesheet" type="text/css">
<script defer src="../js/star.js"></script>
</head>
<body>
<div id="wrap">

<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->

<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 게시판 -->
<%
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
//if 세션값이 없으면   ../member/login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
%>
<article>
<form action="writePro.jsp" method="post" class="form-js">
<table id="notice">
<tr><td>글쓴이</td>
<td><input type="text" name="name" value="<%=id%>" readonly></td>
<tr><td>비밀번호</td>
<td><input type="password" name="pass"></td>
<tr><td>평점</td>
<td><div id="star_grade">
	<span data-score="1">★</span>
	<span data-score="2">★</span>
	<span data-score="3">★</span>
	<span data-score="4">★</span>
	<span data-score="5">★</span>
	<input type="hidden" class="star-score-js" name="star"/>
</div></td></tr>
<tr><td>영화제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>내용</td>
<td><textarea name="content" rows="10" cols="20"></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글쓰기" class="btn">
<input type="button" value="목록" class="btn" 
              onclick="location.href='notice.jsp'">
</div>
</form>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>