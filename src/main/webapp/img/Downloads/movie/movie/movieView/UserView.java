package movie.movieView;

import java.util.List;

import movie.movieDTO.UserDTO;

public class UserView {

//	public static void display(List<UserDTO> emplist) {		
//		System.out.println("====모든 직원조회====");
//		
//		for(UserDTO emp:emplist) {
//			System.out.println(emp);
//		}
//	}
	public static void display(UserDTO userDTO) {		
		System.out.println();
		System.out.println("==============================");
	    System.out.println(userDTO==null?"찾을 수 없습니다.": "환영합니다. " + userDTO.ID + "님");
	    System.out.println("==============================");
		System.out.println();
	}
//	public static void display(String message) {		
//	    System.out.println("[알림]"+ message);
// 
//	}
}



