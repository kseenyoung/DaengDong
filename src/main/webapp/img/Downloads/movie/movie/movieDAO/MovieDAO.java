package movie.movieDAO;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.firstzone.dbtest.EmpDTO;
import com.shinhan.util.DBUtil;

import movie.movieDTO.MovieDTO;

public class MovieDAO {
	public static List<MovieDTO> selectAll() {
		String sql = "select * from screeningMovie join movie on movie.MovieCode = screeningMovie.MovieCode";
		Connection conn = DBUtil.getConnection();
		Statement st = null;
		ResultSet rs = null;
		List<MovieDTO> movielist = new ArrayList<MovieDTO>();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while (rs.next()) {
				MovieDTO movie = makeMovie(rs);
				movielist.add(movie);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, st, rs);
		}
		return movielist;
		
	}
	
	private static MovieDTO makeMovie(ResultSet rs) throws SQLException {
		MovieDTO movie = new MovieDTO();
		movie.setScreeningnumber(rs.getInt("Screeningnumber"));
		movie.setStartTime(rs.getString("startTime"));
		movie.setEndTime(rs.getString("endTime"));
		movie.setStartDate(rs.getDate("startDate"));
		movie.setTotalSeat(rs.getInt("TotalSeat"));
		movie.setScreeningSpace(rs.getString("ScreeningSpace"));
		movie.setMovieCode(rs.getInt("MovieCode"));
		movie.setTitle(rs.getString("Title"));
	
		return movie;
	}
}
