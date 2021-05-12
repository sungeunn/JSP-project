<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie GALLERY</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/gallery.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">

<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->

<!-- 게시판 -->
<%
request.setCharacterEncoding("utf-8");

String search=request.getParameter("search");

GalleryDAO gdao=new GalleryDAO();

int count=gdao.getGalleryCount(search);

int pageSize=15;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

List<GalleryBean> gbList=gdao.getGalleryList(startRow,pageSize,search);
%>
<article>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th></tr>
    <%
    for(int i=0;i<gbList.size();i++){
//     	BoardBean bb=(BoardBean)bbList.get(i);
// 제네릭타입으로 데이터 가져오면  형변환없이 사용가능
    	GalleryBean gb=gbList.get(i);
    	%>
<tr onclick="location.href='content.jsp?num=<%=gb.getNum()%>'">
      <td><%=gb.getNum() %></td>
      <td class="left"><%=gb.getSubject() %></td>
      <td><%=gb.getName() %></td></tr>    	
    	<%
    }
    %>
</table>
<div id="table_search">
<%
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// if 세션값이 있으면  글쓰기 버튼 보이기
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
// 한화면에 보여줄 끝페이지번호 구하기
int endPage=startPage+pageBlock-1;
// 전체페이지개수 구하기
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