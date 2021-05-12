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
request.setCharacterEncoding("utf-8");
String search=request.getParameter("search");

ReviewDAO rdao=new ReviewDAO();
int count=rdao.getReviewCount(search);

int pageSize=15;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

List<ReviewBean> rbList=rdao.getReviewList(startRow,pageSize,search);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<table id="notice">
<tr><th class="tno">No.</th>
      <th class="tstar">Grade</th>
      <th class="ttitle">Title</th>
      <th class="twrite">Writer</th>
      <th class="tdate">Date</th></tr>
    <%
    for(int i=0;i<rbList.size();i++){
    	ReviewBean rb=rbList.get(i);
    	%>
<tr onclick="location.href='content.jsp?num=<%=rb.getNum()%>'">
      <td><%=rb.getNum() %></td>
      <td class="rstar" id="star_grade">
		<span class=<%= Integer.parseInt(rb.getStar()) >= 1 ? "on" : "" %> data-score="1">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 2 ? "on" : "" %> data-score="2">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 3 ? "on" : "" %> data-score="3">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 4 ? "on" : "" %> data-score="4">★</span>
		<span class=<%= Integer.parseInt(rb.getStar()) >= 5 ? "on" : "" %> data-score="5">★</span>
	  <%=rb.getStar() %></td>
      <td><%=rb.getSubject() %></td>
      <td><%=rb.getName() %></td>
      <td><%=sdf.format(rb.getDate()) %></td>
    <%
    }
    %>
</table>
<div id="table_search">
<%
String id = (String)session.getAttribute("id");
if(id!=null){
%>
<input type="button" value="글쓰기" class="btn"  onclick="location.href='writeForm.jsp'">	
<%
}
%>
</div>
<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
int pageBlock=10;
int startPage=((currentPage-1) /pageBlock)*pageBlock + 1;
int endPage=startPage+pageBlock-1;
int pageCount=count/pageSize+(count%pageSize==0?0:1);
if(endPage > pageCount){
	endPage=pageCount;
}
if(startPage > pageBlock){
	%><a href="noticeSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">Prev</a><%
}
for(int i=startPage;i<=endPage;i++){
	%><a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a><%
}
if(endPage < pageCount){
	%><a href="noticeSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">Next</a><%
}
%>
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