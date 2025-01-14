package movie.movieDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.shinhan.util.DBUtil;

import movie.movieDTO.ReserveDTO;
import movie.movieDTO.UserDTO;


public class ReserveDAO {
	
	public int reserve_insert (ReserveDTO reserveDTO) {
		int result = 0;
		String sql = "insert into 예매 values(예매_SEQ.NEXTVAL,?,?)";
		Connection conn = DBUtil.getConnection();
		// Statement는 ?(binding변수 지원안함) <------PreparedStatement는 지원
		PreparedStatement st = null;
		try {
			st = conn.prepareStatement(sql);

			st.setString(1, reserveDTO.getID());
			st.setInt(2, reserveDTO.getScreeningnumber());

			result = st.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, st, null);
		}
		return result;
	}

	public int seat_insert (ReserveDTO reserveDTO) {
		String sql2 = "select ReserveNumber from 예매 where ID = '" + reserveDTO.getID() + "' and Screeningnumber = "+  reserveDTO.getScreeningnumber();
		Connection conn2 = DBUtil.getConnection();
		Statement st2 = null;
		ResultSet rs2 = null;
		int researveNum = 0;
		try {
			st2 = conn2.createStatement();
			rs2 = st2.executeQuery(sql2);
			if (rs2.next()) {
				researveNum = rs2.getInt("ReserveNumber");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn2, st2, null);
		}
		
		
		
		int result = 0;
		String sql = "insert into 좌석  values(예매_SEQ.NEXTVAL,?, ?, ?)";
		Connection conn = DBUtil.getConnection();
		// Statement는 ?(binding변수 지원안함) <------PreparedStatement는 지원
		PreparedStatement st = null;
		try {
			st = conn.prepareStatement(sql);
			st.setInt(1, reserveDTO.getSeatNumber());
			st.setInt(2, reserveDTO.getScreeningnumber());
			st.setInt(3, researveNum);

			result = st.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, st, null);
		}

		return result;
	}
	
//	public int select(ReserveDTO reserveDTO) {
//
//		String sql2 = "select ReserveNumber from 예매 where ID = '" + reserveDTO.getID() + "' and Screeningnumber = "+  reserveDTO.getScreeningnumber();
//		Connection conn2 = DBUtil.getConnection();
//		Statement st2 = null;
//		ResultSet rs2 = null;
//		int researveNum = 0;
//		try {
//			st2 = conn2.createStatement();
//			rs2 = st2.executeQuery(sql2);
//			if (rs2.next()) {
//				researveNum = rs2.getInt("ReserveNumber");
//			}
//
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			DBUtil.dbDisconnect(conn2, st2, null);
//		}
//
//		return researveNum;
//	}
//	
	

}
