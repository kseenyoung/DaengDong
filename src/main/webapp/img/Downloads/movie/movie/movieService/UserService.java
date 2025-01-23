package movie.movieService;

import movie.movieDAO.UserDAO;
import movie.movieDTO.UserDTO;

public class UserService {
	
	UserDAO userDAO = new UserDAO();
	
	public int insertService(UserDTO userDTO) {
		return userDAO.insert(userDTO);
	}
	
	public UserDTO loginService(String ID, String PW) {
		return userDAO.select(ID, PW);
	}
}
