package movie.movieDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.firstzone.dbtest.EmpDTO;
import com.shinhan.util.DBUtil;

import movie.movieDTO.UserDTO;

public class UserDAO {
	
	public int insert(UserDTO s) {
		int result = 0;
		String sql = "insert into users values (?,?,?)";
		Connection conn = DBUtil.getConnection();
		// Statement는 ?(binding변수 지원안함) <------PreparedStatement는 지원
		PreparedStatement st = null;
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, s.getID());
			st.setString(2, s.getPasswd());
			st.setString(3, s.getName());

			result = st.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, st, null);
		}

		return result;
	}

	public UserDTO select(String ID, String PW) {

		String sql = "select ID from users where ID = '" + ID + "' and PW = '" +  PW + "'";
		Connection conn = DBUtil.getConnection();
		Statement st = null;
		ResultSet rs = null;
		UserDTO user = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				user = f_makeUser(rs);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, st, null);
		}

		return user;
	}
	
	
	private static UserDTO f_makeUser(ResultSet rs) throws SQLException {
		UserDTO user = new UserDTO();
		user.setID(rs.getString("ID"));
		return user;
	}

	
}
