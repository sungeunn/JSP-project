package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {

		public Connection getConnection() throws Exception{
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			Connection con=ds.getConnection();
			return con;
		}
		
		public int getReviewCount() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				String sql="select count(*) from review";
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
		public int getReviewCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				String sql="select count(*) from review where subject like ? ";
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
		
		public List<ReviewBean> getReviewList(int startRow,int pageSize) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ReviewBean> rbList=new ArrayList<ReviewBean>();
			try {
				con=getConnection();
				String sql="select * from review order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					ReviewBean rb=new ReviewBean();
					rb.setNum(rs.getInt("num"));
					rb.setName(rs.getString("name"));
					rb.setPass(rs.getString("pass"));
					rb.setStar(rs.getString("star"));
					rb.setSubject(rs.getString("subject"));
					rb.setContent(rs.getString("content"));
					rb.setDate(rs.getTimestamp("date"));
					rbList.add(rb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return rbList;
		}
		
		// 검색어
		public List<ReviewBean> getReviewList(int startRow,int pageSize,String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ReviewBean> rbList=new ArrayList<ReviewBean>();
			try {
				con=getConnection();
				String sql="select * from review where subject like ? order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					ReviewBean rb=new ReviewBean();
					rb.setNum(rs.getInt("num"));
					rb.setName(rs.getString("name"));
					rb.setPass(rs.getString("pass"));
					rb.setStar(rs.getString("star"));
					rb.setSubject(rs.getString("subject"));
					rb.setContent(rs.getString("content"));
					rb.setDate(rs.getTimestamp("date"));
					rbList.add(rb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return rbList;
		}
		
		public ReviewBean getReview(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ReviewBean rb=new ReviewBean();
			try {
				con=getConnection();
				String sql="select * from review where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					rb.setNum(rs.getInt("num"));
					rb.setName(rs.getString("name"));
					rb.setPass(rs.getString("pass"));
					rb.setStar(rs.getString("star"));
					rb.setSubject(rs.getString("subject"));
					rb.setContent(rs.getString("content"));
					rb.setDate(rs.getTimestamp("date"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return rb;
		}
		
		public void insertReview(ReviewBean rb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			try {
				con=getConnection();
				int num=0;
				String sql2="select max(num) from review";
				pstmt2=con.prepareStatement(sql2);
				rs=pstmt2.executeQuery();
				if(rs.next()){
					// num구하기 최대num값 번호 +1
					num=rs.getInt("max(num)")+1;
				}
				String sql="insert into review(num,name,pass,star,subject,content,date) values(?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, rb.getName());
				pstmt.setString(3, rb.getPass());
				pstmt.setString(4, rb.getStar());
				pstmt.setString(5, rb.getSubject());
				pstmt.setString(6, rb.getContent());
				pstmt.setTimestamp(7, rb.getDate());
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
				String sql="select * from review where num=?";
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

		public void updateReview(ReviewBean rb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="update review set star=?, subject=?, content=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, rb.getStar());
				pstmt.setString(2, rb.getSubject());
				pstmt.setString(3, rb.getContent());
				pstmt.setInt(4, rb.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
		
		public void deleteReview(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="delete from review where num=?";
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
