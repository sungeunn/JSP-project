package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalleryDAO {
	    // 1,2 단계 디비연결
		public Connection getConnection() throws Exception{
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			Connection con=ds.getConnection();
			return con;
		}
		
		public int getGalleryCount() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				String sql="select count(*) from gallery";
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
		
		public int getGalleryCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				String sql="select count(*) from gallery where subject like ? ";
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
		
		public List<GalleryBean> getGalleryList(int startRow,int pageSize) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<GalleryBean> gbList=new ArrayList<GalleryBean>();
			try {
				con=getConnection();
				String sql="select * from gallery order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					GalleryBean gb=new GalleryBean();
					gb.setNum(rs.getInt("num"));
					gb.setName(rs.getString("name"));
					gb.setPass(rs.getString("pass"));
					gb.setSubject(rs.getString("subject"));
					gb.setFile(rs.getString("file"));
					gbList.add(gb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return gbList;
		}
		
		public List<GalleryBean> getGalleryList(int startRow,int pageSize,String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<GalleryBean> gbList=new ArrayList<GalleryBean>();
			try {
				con=getConnection();
				String sql="select * from gallery where subject like ? order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					GalleryBean gb=new GalleryBean();
					gb.setNum(rs.getInt("num"));
					gb.setName(rs.getString("name"));
					gb.setPass(rs.getString("pass"));
					gb.setSubject(rs.getString("subject"));
					gbList.add(gb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return gbList;
		}
		
		public GalleryBean getGallery(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			GalleryBean gb=new GalleryBean();
			try {
				con=getConnection();
				String sql="select * from gallery where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					gb.setNum(rs.getInt("num"));
					gb.setName(rs.getString("name"));
					gb.setPass(rs.getString("pass"));
					gb.setSubject(rs.getString("subject"));
					gb.setFile(rs.getString("file"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) 	    try {	rs.close(); } catch (SQLException ex) { }
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
			return gb;
		}
		
		public void updateReadcount(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="update gallery set readcount=readcount+1 where num=?";
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
		
		public void insertGallery(GalleryBean gb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			try {
				con=getConnection();
				int num=0;
				String sql2="select max(num) from gallery";
				pstmt2=con.prepareStatement(sql2);
				rs=pstmt2.executeQuery();
				if(rs.next()){
					num=rs.getInt("max(num)")+1;
				}
				String sql="insert into gallery(num,name,pass,subject,file) values(?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, gb.getName());
				pstmt.setString(3, gb.getPass());
				pstmt.setString(4, gb.getSubject());
				pstmt.setString(5, gb.getFile());
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
		
		public int numCheck(int num,String pass) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			int check=-1;
			try {
				con=getConnection();
				String sql="select * from gallery where num=?";
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

		public void updateGallery(GalleryBean gb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="update gallery set subject=?, file=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, gb.getSubject());
				pstmt.setString(2, gb.getFile());
				pstmt.setInt(3, gb.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
				if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
			}
		}
		
		public void deleteGallery(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConnection();
				String sql="delete from gallery where num=?";
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
