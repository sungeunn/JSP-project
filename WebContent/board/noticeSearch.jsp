<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie BOARD</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/board.css" rel="stylesheet" type="text/css">
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
// noticeSearch.jsp
// 한글처리
request.setCharacterEncoding("utf-8");
// search 파라미터 가져오기
String search=request.getParameter("search");

// 패키지 board 파일이름 BoardDAO 파일만들기
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// int count=getBoardCount(search) 메서드 정의 하고 호출
int count=bdao.getBoardCount(search);

// 한페이지 보여줄 글개수 지정  15지정
int pageSize=15;

// http://localhost:8080/FunWeb/center/notice.jsp => 1페이지
// http://localhost:8080/FunWeb/center/notice.jsp?pageNum=2
// 현페이지 번호 파라미터 가져오기
String pageNum=request.getParameter("pageNum");
// pageNum 없으면 1로 설정
if(pageNum==null){
	pageNum="1";
}
// pageNum   pageSize  조합해서  startRow 구간 시작행 구하기
// 계산하기위해서 pageNum 정수형 변경
int currentPage=Integer.parseInt(pageNum);
// startRow 구간 시작행 번호 구하기 - 알고리즘
// 페이지번호 currentPage  한화면에 보여줄글개수 pageSize => startRow시작하는 행번호
// 1                             10                      => (1-1)*10+1=>0*10+1=>0+1 =>1
// 2                             10                      => (2-1)*10+1=>1*10+1=>10+1=>11
// 3                             10                      => (3-1)*10+1=>2*10+1=>20+1=>21
int startRow = (currentPage-1)*pageSize+1;
//endRow 구간 끝행번호 구하기 - 알고리즘
//currentPage   pageSize    => endRow 
// 1                    10        => 10
// 2                    10        => 20
// 3                    10        => 30
int endRow = currentPage*pageSize;
//한개글,한개글  => 배열 java.util.List  한칸,한칸에 담아서 전달 가져옴
//List bbList = getBoardList(시작행,가져올글개수,검색어) 메서드 정의 호출
//String sql="select * from board order by num desc limit 시작행-1,글개수";
List<BoardBean> bbList=bdao.getBoardList(startRow,pageSize,search);
// 날짜 모양 변경  날짜 모양변경 -> 문자열
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    <%
    for(int i=0;i<bbList.size();i++){
//     	BoardBean bb=(BoardBean)bbList.get(i);
// 제네릭타입으로 데이터 가져오면  형변환없이 사용가능
    	BoardBean bb=bbList.get(i);
    	%>
<tr onclick="location.href='content.jsp?num=<%=bb.getNum()%>'">
      <td><%=bb.getNum() %></td>
      <td class="left"><%=bb.getSubject() %></td>
      <td><%=bb.getName() %></td>
      <td><%=sdf.format(bb.getDate()) %></td>
      <td><%=bb.getReadcount() %></td></tr>    	
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
// 한화면에 보여줄 페이지개수 설정
int pageBlock=10;
// 한화면에 보여줄 시작페이지번호 구하기
// 1~10 => 1  , 11~20 -> 11
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