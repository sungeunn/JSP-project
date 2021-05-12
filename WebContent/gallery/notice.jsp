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
GalleryDAO gdao=new GalleryDAO();
int count=gdao.getGalleryCount();

int pageSize=15;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

List<GalleryBean> gbList=gdao.getGalleryList(startRow,pageSize);
%>

<div class="grid">
    <%
    int column = 4;
    int index = 0;
    int firstNumber = (gbList.size() / column) + (gbList.size() % column);
    
   for(int i = 0; i < column; ++i) {
	    int iterNumber = index < firstNumber ? firstNumber : gbList.size() / column;
	   %>
	   <div>
	   <% 
	   for(int j = 0 ; j < iterNumber; ++j) {
	   GalleryBean gb=gbList.get(index);
		   %>
		     <a href="content.jsp?num=<%=gb.getNum()%>">
		  	 <img class="photo-item__image" src="../upload/<%=gbList.get(index).getFile() %>" >
		  	 </a>
		   <%
		   ++index;
	   }
	   %>
	   </div>   
	   <%
   }	   
	   %>
</div>     
<div class="clear"></div>
<div id="table_search">
<%
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// if 세션값이 있으면  글쓰기 버튼 보이기
if(id!=null){
	%>
<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">	
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
	%><a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
for(int i=startPage;i<=endPage;i++){
	%><a href="notice.jsp?pageNum=<%=i%>"><%=i %></a><%
}
if(endPage < pageCount){
	%><a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
</div>

<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>