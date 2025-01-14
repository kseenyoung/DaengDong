package movie.movieService;

import java.util.List;

import movie.movieDAO.MovieDAO;
import movie.movieDTO.MovieDTO;


public class MovieService {
    MovieDAO movieDAO = new MovieDAO();
	
	public List<MovieDTO> selectAll_movie() {
		return movieDAO.selectAll();
	}
}
