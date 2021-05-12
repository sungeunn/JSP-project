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
int num=Integer.parseInt(request.getParameter("num"));
ReviewDAO rdao=new ReviewDAO();
ReviewBean rb=rdao.getReview(num);
%>
<article>
<table id="notice">
<tr><td>번호</td><td><%=rb.getNum() %></td>
	  <td>평점</td>
      <td class="rstar" id="star_grade">
		<span class=<%= Integer.parseInt(rb.getStar()) >= 1 ? "on" : "" %> data-score="1">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 2 ? "on" : "" %> data-score="2">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 3 ? "on" : "" %> data-score="3">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 4 ? "on" : "" %> data-score="4">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 5 ? "on" : "" %> data-score="5">★</span>
	  <%=rb.getStar() %></td>
	  <td>글쓴이</td><td><%=rb.getName() %></td>
      <td>작성일</td><td><%=rb.getDate() %></td><tr>
<tr><td>영화제목</td><td colspan="2"><%=rb.getSubject() %></td>
	  <td>내용</td><td colspan="4"><%=rb.getContent() %></td><tr>
</table>
<div id="table_search">
<%
String id = (String)session.getAttribute("id");

if(id!=null){
	if(id.equals(rb.getName())){
	%>
<input type="button" value="수정" class="btn" 
        onclick="location.href='updateForm.jsp?num=<%=rb.getNum()%>'">
<input type="button" value="삭제" class="btn" 
        onclick="location.href='deleteForm.jsp?num=<%=rb.getNum()%>'">	
	<%
	}
}
%>
<input type="button" value="목록" class="btn"  onclick="location.href='notice.jsp'">
</div>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>