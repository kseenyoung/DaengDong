package movie.movieService;

import movie.movieDAO.ReserveDAO;
import movie.movieDTO.ReserveDTO;

public class ReserveService {
	ReserveDAO reserveDAO = new ReserveDAO();
	
	public void create_reserveService(ReserveDTO reserveDTO) {
		reserveDAO.reserve_insert(reserveDTO);
		reserveDAO.seat_insert(reserveDTO);
//		return 
	}
}
