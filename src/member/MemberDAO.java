package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	public Connection getConnection() throws Exception {

		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;

		System.out.println(mb.getPostcode());
		try {
			con = getConnection();
			String sql = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getPhone());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getPostcode());
			pstmt.setString(7, mb.getAddress());
			pstmt.setString(8, mb.getDetailAddress());
			pstmt.setInt(9, mb.getYy());
			pstmt.setInt(10, mb.getMm());
			pstmt.setInt(11, mb.getDd());
			pstmt.setString(12, mb.getGender());
			pstmt.setTimestamp(13, mb.getDate());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
	}

	public int userCheck(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return check;
	}

	public MemberBean getMember(String id) {
		MemberBean mb = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setPhone(rs.getString("phone"));
				mb.setEmail(rs.getString("email"));
				mb.setPostcode(rs.getString("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setDetailAddress(rs.getString("detailAddress"));
				mb.setYy(rs.getInt("yy"));
				mb.setMm(rs.getInt("mm"));
				mb.setDd(rs.getInt("dd"));
				mb.setGender(rs.getString("gender"));
				mb.setDate(rs.getTimestamp("date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return mb;
	}
	
	public void updateMember(MemberBean mb){
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			String sql=
					"update member set pass=?,name=?,phone=?,email=?,postcode=?,address=?,detail_address=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,mb.getPass());
			pstmt.setString(2,mb.getName());
			pstmt.setString(3,mb.getPhone());
			pstmt.setString(4,mb.getEmail());
			pstmt.setString(5,mb.getPostcode());
			pstmt.setString(6,mb.getAddress());
			pstmt.setString(7,mb.getDetailAddress());
			pstmt.setString(8,mb.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch (SQLException ex) {}
			if(con!=null) try {con.close();}catch (SQLException ex) {}
		}
	}
	
	// int check= iddupcheck(id) 메서드 정의 하고 호출 (아이디 중복확인)
	public int iddupcheck(String id) {
		int check=-1;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql 구문 준비  id=?
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4 sql실행 결과 저장
			rs=pstmt.executeQuery();
			// 5 다음행으로 이동 했을때  데이터 있으면 check=1
			//                                             없으면 check=-1
			if(rs.next()) {
				check=1; // 아이디 있음, 아이디 중복
			}else {
				check=-1; // 아이디 없음, 아이디 사용가능
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();}catch (SQLException ex) {}
			if(con!=null) try {con.close();}catch (SQLException ex) {}
		}
		return check;
	}

} // 클래스
