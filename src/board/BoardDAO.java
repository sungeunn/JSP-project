package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	    // 1,2 단계 디비연결
		public Connection getConnection() throws Exception{
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			Connection con=ds.getConnection();
			return con;
		}
		
		// int count=getBoardCount() 메서드 정의 
		public int getBoardCount() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				String sql="select count(*) from board";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return count;
		}
		
		// 검색어
		public int getBoardCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
//				String sql="select count(*) from board where subject like '%검색어%' ";
				String sql="select count(*) from board where subject like ? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				rs=pstmt.executeQuery();
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return count;
		}
		
		//	List bbList=bdao.getBoardList(startRow,pageSize);
		// 제네릭 List에 모든형을 저장하지 않고 BoardBean형만 저장
		public List<BoardBean> getBoardList(int startRow,int pageSize) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<BoardBean> bbList=new ArrayList<BoardBean>();
			try {
				con=getConnection();
				String sql="select * from board order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					BoardBean bb=new BoardBean();
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setDate(rs.getTimestamp("date"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setFile(rs.getString("file"));
					bbList.add(bb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return bbList;
		}
		
		// 검색어
		public List<BoardBean> getBoardList(int startRow,int pageSize,String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<BoardBean> bbList=new ArrayList<BoardBean>();
			try {
				con=getConnection();
//				String sql="select * from board where subject like '%검색어%' order by num desc limit ?,?";
				String sql="select * from board where subject like ? order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					BoardBean bb=new BoardBean();
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setDate(rs.getTimestamp("date"));
					bb.setReadcount(rs.getInt("readcount"));
					bbList.add(bb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return bbList;
		}
		
		// BoardBean bb = getBoard(num);
		public BoardBean getBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			BoardBean bb=new BoardBean();
			try {
				con=getConnection();
				String sql="select * from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setDate(rs.getTimestamp("date"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setFile(rs.getString("file"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return bb;
		}
		
		// bdao.updateReadcount(num);
		public void updateReadcount(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="update board set readcount=readcount+1 where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
		
		// insertBoard(bb) 메서드 만들고 호출
		public void insertBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			try {
				con=getConnection();
				int num=0;
				String sql2="select max(num) from board";
				pstmt2=con.prepareStatement(sql2);
				rs=pstmt2.executeQuery();
				if(rs.next()){
					// num구하기 최대num값 번호 +1
					num=rs.getInt("max(num)")+1;
				}
				String sql="insert into board(num,name,pass,subject,content,date,readcount,file) values(?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bb.getName());
				pstmt.setString(3, bb.getPass());
				pstmt.setString(4, bb.getSubject());
				pstmt.setString(5, bb.getContent());
				pstmt.setTimestamp(6, bb.getDate());
				pstmt.setInt(7, bb.getReadcount());
				pstmt.setString(8, bb.getFile());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(pstmt2!=null) 	try {	pstmt2.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
		
		// int check = numCheck(num,pass)
		public int numCheck(int num,String pass) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			int check=-1;
			try {
				con=getConnection();
				String sql="select * from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					if(pass.equals(rs.getString("pass"))) {
						check=1;
					}else {
						check=0;
					}
				}else {
					check=-1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return check;
		}
		// bdao.updateBoard(bb);
		public void updateBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="update board set subject=?, content=?, file=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, bb.getSubject());
				pstmt.setString(2, bb.getContent());
				pstmt.setString(3, bb.getFile());
				pstmt.setInt(4, bb.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
		
		// bdao.deleteBoard(num);
		public void deleteBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="delete from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
}
